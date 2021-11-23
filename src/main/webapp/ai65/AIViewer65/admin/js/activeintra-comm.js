/**
 * activeintra.comm: a module of classes communicating with AIServer
 *   -> 최상위 document에 한번만 로딩하여 sub프레임등에서 공유하는 구조를 가정
 */

activeintra.comm = {};
// IE9까지에서 선행 include된 jquery.form-3.X에서 true로 설정
activeintra.comm.ieLess10 = window.ieLess10 || false;
var defineAIClass = activeintra.Class.define;

// 파라미터만을 포함하는 일반 Request를 (Ajax or submit)처리하는 클래스
// 단일 instance생성후 반복사용되는 구조를 지원(setTask- ...)
// 데이타(파라미터)의 유효성은 caller가 체크함
activeintra.comm.SimpleRequest = defineAIClass({ // -> constructor fn.
    name: "SimpleRequest",
    // targetFrame: 화일다운로드인 경우 request(form submit)의 target
    //        (메뉴등이 아닌 content프레임을 지정하는 것이 에러시의 UI에 바람직)
    construct: function(targetFrame) { // plus, instance field
        // 통신할 서버주소, 리소스(html등)는 current기준 상대로 사용(like, js/~.js)
        // 상대+고정주소(보안문제회피)
        this.serverURL = activeintra.comm.resolveServerURL();
        this.targetFrame = targetFrame;
    },
    methods: { // instance method(only)
        setTask: function(app, task, job) {
            this.headers = activeintra.comm.composeTaskHeader(app, task, job);
        },
        // callBack:성공이나 실패처리후 호출할 client callback함수
        //          null인 경우에는 Ajax대신 form submit(바이너리화일 Res.에 적용)
        doRequest: function(method, paramObj, callBack, timeoutMillis, resType) {
            activeintra.comm.clearCookies();
            if (callBack == null) { // req.후 (binary)file download로 진행됨
                activeintra.comm.submitSimpleData(this.serverURL, method, paramObj,
                                                  this.targetFrame, this.headers);
                return;
            }

            // 예측불가능성을 없애기 위해 파라미터를 직접 인코딩하여 사용
            var queryString = this.composeQueryString(paramObj);
            var request = $.ajax({ // jqXHR Object
                url: this.serverURL,
                data: queryString,
                method: method,
                headers: this.headers,
                timeout: timeoutMillis, // milliseconds
                beforeSend: activeintra.comm.beforeSend,
                dataType:  resType,
                cache: false, global: false,
                context: this // callback도 this환경화
            });
            // text(xml)POST시: contentType속성설정(text/plain ~) &&
            //                  data=text데이타 && processData=false
            // -> 별도로 구성하는 대신 파라미터로 구분하여 통합처리

            request.done(function(content, textStatus, jqXHR) {
                activeintra.comm.handleResponse(content, jqXHR, callBack);
            });
            // timeOut,network에러,서버에러,AI서버미구동 등...
            request.fail(function(jqXHR, errorType, statusMsg) {
                // errorType: "timeout", "error", "abort"
                // WebLogic등에서 body에 empty라인이 추가되면 이곳으로 진입함(JQ구현)
                // SimpleResponse(444 등)에서 무의미한 에러를 회피하기 위해 구분하여 처리
                if (jqXHR.getResponseHeader("AIServer-Result") == null) {
                    activeintra.comm.onFail(errorType + "(" + statusMsg + ")", "-1");
                } else {
                    activeintra.comm.handleResponse("", jqXHR, callBack);
                }
            });
        },
        // 파라미터객체를 폼인코딩에 부합하는 query string으로 구성한다.
        composeQueryString: function(paramObj) {
            var queryString = "";
            if (!paramObj) return queryString;

            var added = false;
            for (var name in paramObj) {
                if (added) queryString += "&"; else added = true;
                queryString += (name + "=" + window.encodeURIComponent(paramObj[name]));
            }
            return queryString;
        }
    }
});

// 화일과 파라미터를 포함하는 MultiPart Request를 (Ajax or submit)처리하는 클래스
// 화일은 각각을 별도의 field(part)로 구성해야하고 일반필드는 별도로 인코딩하지 않아야함
// (브라우저(ajax)가 UTF-8로 인코딩할것이고, 화일명(filename)은 서버에서 사용않음)
activeintra.comm.MultiPartRequest = defineAIClass({
    name: "MultiPartRequest",
    construct: function(targetFrame) {
        this.serverURL = activeintra.comm.resolveServerURL();
        this.targetFrame = targetFrame;
    },
    methods: {
        setTask: function(app, task, job) {
            this.headers = activeintra.comm.composeTaskHeader(app, task, job);
        },
        doRequest: function(form, callBack, timeoutMillis, resType) {
            activeintra.comm.clearCookies();
            if (callBack == null) { // req.후 (binary)file download로 진행됨
                form.setAttribute("action", this.serverURL);
                form.setAttribute("method", "POST");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("target", this.targetFrame);

                activeintra.comm.setTaskCookie(this.headers);
                form.submit();
                return;
            }

            var options = this.ajaxOptions();
            options.timeout = timeoutMillis; // milliseconds
            options.dataType =  resType;
            options.success = function(content, textStatus, jqXHR) {
                activeintra.comm.handleResponse(content, jqXHR, callBack);
            };
            options.error = function(jqXHR, errorType, statusMsg) {
                if (jqXHR.getResponseHeader("AIServer-Result") == null) {
                    activeintra.comm.onFail(errorType + "(" + statusMsg + ")", "-1");
                } else {
                    activeintra.comm.handleResponse("", jqXHR, callBack);
                }
            };

            if (activeintra.comm.ieLess10) { // IE9이하 -> form plugIn 사용
                // plugIn이 제공하는 target frame(폼을 submit할), target element
                // (content로 채울)옵션을 사용하지 않고 기본값으로 작동하게함
                // -> form을 temp frame에 submit하여 외관상으로는 ajax로 보여짐
                //    또한 response content는 text로 받아 직접처리함

                // *** plugIn: method설정않음->폼에설정, 헤더설정않음, 헤더리딩않됨
                activeintra.comm.setTaskCookie(this.headers);
                $(form).ajaxSubmit(options); // plugIn옵션대신 jqAjax옵션만 사용
            } else { // HTML5브라우저 -> XMLHttpRequest2(FormData) 사용
                options.data = new FormData(form);
                $.ajax(options);
            }
        },
        ajaxOptions: function() {
            return {
                url: this.serverURL,
                processData: false,
                method: "POST",
                contentType: false,
                headers: this.headers,
                beforeSend: activeintra.comm.beforeSend,
                cache: false, global: false,
                context: this // callback도 this환경화
            };
        }
    }
});

// 공통 유틸함수들을 정의
activeintra.comm.spaceExp = /\+/g; // "+" -> " "
activeintra.comm.handleResponse = function(content, jqXHR, callBack) {
    // 결과헤더에서 성공여부확인 -> 경우별로 처리
    var result = jqXHR.getResponseHeader("AIServer-Result");
    if (result == null) { // IE9이하 && plugIn
        var cookies = document.cookie; // n1=v1; n2=v2 처럼 순수값만 리스팅됨
        if (cookies) {
            var st = cookies.indexOf("AIServer-Result", 0);
            if (st != -1) {
                var ed = cookies.indexOf(";", st);
                if (st == -1) {
                    result = cookies.substring(st+16);
                } else {
                    result = cookies.substring(st+16, ed);
                }
            }
        }
    }
    this.clearCookies();

    if (result == null) { // 로그아웃후 import화면에서 실행등
        this.onFail("No resultCode", "-1");
        return;
    }

    var code, msg = "code";
    var idx = result.indexOf("; ", 0); // code[; msg]
    if (idx == -1) {
        code = result;
    } else {
        code = result.substring(0, idx);
        msg = result.substring(idx + 2);
        msg = window.decodeURIComponent(msg).replace(this.spaceExp, " ");
    }

    if (code == "200") { // success
        // 메타데이타("AIServer-Metadata"헤더)는 필요시까지 처리보류
        setLoadingDialogVisible(false);
        callBack(content, jqXHR); // body(content)는 caller가 선택적으로 사용
    } else { // fail
        // body에 있을수 있는 디버깅메세지 처리는 보류(생략)
        if (code == "444") { // NotLogined or Timeouted
            this.onFail("사용자 인증을 위해 먼저 로그인하세요.", "-1", true);
            clearSessionStatus();
            setLoginStatus(false);
            handleLogin();
        } else if (code == "450") { // Role required
            this.onFail("요청한 작업을 실행할 권한이 없습니다.", "-1", true);
        } else if (code == "999") {
            this.onFail("올바르지 않은 인증정보입니다.", "-1", true);
            handleLogin();
        } else if (code == "555") {
            this.onFail("설정전용모드로, [환경변수]와 [AI서버 재기동]만 사용가능합니다.\n" +
                        "\n[" + msg + "]", "-1", true);
        } else {
            this.onFail(msg, code);
        }
    }
};

activeintra.comm.contextPath = "/"; // 쿠키 공통 path(서버와 동기화)
activeintra.comm.resolveServerURL = function() {
    // Path의 조작가능성은 무시(조작시 그냥 URL 에러됨)
    // serverPath: /contextPath/servletPath  (/aireport/aiServer.jsp 등)
    var serverPath = document.location.search; // ?sp=/serverPath
    serverPath = serverPath.substring(4);
    if (serverPath.lastIndexOf("/") > 0) { // "/contextPath/servletPath" 형식
        this.contextPath = serverPath.substring(0, serverPath.indexOf("/", 1));
    }

    return (serverPath);
};

activeintra.comm.composeTaskHeader = function(app, task, job) {
    return ({"AIServer-Task": "app=" + app + "&task=" + task + "&job=" + job});
};

// 헤더를 사용할 수 없는 경우 Task헤더와 대등한 값을 쿠키로 설정( -> 브라우저가 전송)
activeintra.comm.setTaskCookie = function(headers) {
    // 쿠키설정: 한번에 한개씩 full-spec으로 아래처럼 처리(전체 over-ride개념이 아님)
    document.cookie = "AIServer-Task=" +
            window.encodeURIComponent(headers["AIServer-Task"]) + "; Path=" + this.contextPath;
};

// 불필요한 전송과 혼선을 막기 위해 새로운 Request전/후에 사용쿠키를 무조건 삭제함
// (개념상으로 화일다운로드 즉 form submit후에도 호출이 바람직하지만 작동않음)
// (보완을 위해 AIServer.process에 쿠키read후 삭제쿠키헤더를 설정함)
activeintra.comm.clearCookies = function() {
    document.cookie = "AIServer-Task=a; Expires=Thu, 01-Jan-1970 00:00:00 GMT; Path=" + this.contextPath;
    document.cookie = "AIServer-Result=a; Expires=Thu, 01-Jan-1970 00:00:00 GMT; Path=" + this.contextPath;
};

activeintra.comm.beforeSend = function(jqXHR, settings) {
    // input blocking && 메세지창
    setLoadingDialogVisible(true);
    return true;
};

activeintra.comm.onFail = function(message, code, blocking) {
    this.clearCookies(); // task/result관련 쿠키만 삭제
    // (input blocking && 메세지창) off -> 실패메세지 표시
    setLoadingDialogVisible(false);
    if (code != "-1") message = message + " (error-code:" + code + ")";

    if (blocking === true) {
        window.alert(message);
    } else {
        showMessage(message, true, true);
    }
};

// form submit의 경우에는 AI결과헤더를 통한 사후처리가 불가능
// (서버에서 일반적인 페이지에러로 처리해주는 것이 바람직함)
activeintra.comm.submitSimpleData = function(url, method, paramObj,
                                             targetFrame, headers) {
    // dummy(hidden)form을 사용하여 targetFrame에 submit
    // (current window-document에 기반함-setTaskCookie() too)
    // ( -> 현재구현에서는 console.html을 사용함)
    // (아래는 aireportLoader.js코드를 부분수정하여 그대로 사용)
    var form = document.getElementById("aireport-admin-fk-form");
    if (form == null) { // first submit
        form = document.createElement("form");
        form.setAttribute("id", "aireport-admin-fk-form");
        document.body.appendChild(form); // body가 frameset이면 fail
    } else { // clear후 재사용 (삭제는 구조상 곤란)
        form.innerHTML = "";
    }

    form.setAttribute("action", url);
    form.setAttribute("method", method);
    form.setAttribute("target", targetFrame);

    var paramElements = "";
    if (paramObj) {
        for (var name in paramObj) {
            paramElements += "<input type='hidden' name='" + name + "' value='" +
                    this.escapeValue(paramObj[name]) + "'>\n";
        }
    }
    form.innerHTML = paramElements; // empty인 경우에도 정상처리됨

    // 헤더를 사용할 수 없으므로 쿠키를 사용하여 전송
    this.setTaskCookie(headers);

    form.submit();
};

activeintra.comm.replExp = /'/g; // input value='v'에 적용하기 위해 '를 replace
activeintra.comm.escapeValue = function(value) {
    if (typeof value != "string") return value;

    if (value.indexOf("'") == -1) {
        return value;
    } else {
        return (value.replace(this.replExp, "&#039;"));
    }
};