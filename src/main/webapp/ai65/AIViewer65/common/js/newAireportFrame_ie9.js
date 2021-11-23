
    if(!contextMenu) {
        document.oncontextmenu = function () {
            return false;
        }

        document.ondragstart = function () {
            return false;
        }

        document.onselectstart = function () {
            return false;
        }

        document.onkeydown = function () {
            if (event.keyCode == 123) {
                return false;
            }
        }
    }

    //전자서명 관련
    function showSignPanel() {
      var spanel = document.getElementById("signaturePanel");
      spanel.style.display = "block";
    }

    function hideSignPanel(enableOpen) {
      var spanel = document.getElementById("signaturePanel");
      spanel.style.display = "none";  
    }
    //전자서명 관련

    var zoomArray       = new Array(0.5,0.6,0.7,0.8,0.9,1.0,1.1,1.2,1.3,1.4,1.5);
    var ieFlag = true;
    var swfReady = false;
    var jsReady = false;
    var printCount = 1;
    var reportUrl = document.URL;
    var scrollFlag = true;
    var pdffilename="";
    var menuHeight=57;                  //px단위
    var reportTopMargin=26;
    

    var browserSearchString = new Array(
        "Edge",
        "MSIE 6.0","MSIE 7.0","MSIE 8.0","MSIE 9.0","MSIE 10.0","rv:11.0","MSIE",
        "IEMobile 6","IEMobile 7","IEMobile 8","IEMobile/9.0","IEMobile",
        "Chrome/13","Chrome/14","Chrome/15","Chrome/16","Chrome/17","Chrome/18","Chrome/19","Chrome/20","Chrome/21","Chrome/22","Chrome/23","Chrome/24","Chrome",
        "Firefox/3","Firefox/4","Firefox/5","Firefox/6","Firefox/7","Firefox/8","Firefox/9","Firefox/10","Firefox",
        "Firefox/3.5 Maemo",
        "iPhone","iPad",
        "Safari/52","Safari/531","Safari/530","Safari/533","Safari/534","Safari",
        "J2ME/MIDP","Opera/8.0","Opera/9","Opera/9.80", "Opera"
    );

    var browserType= new Array(
        "Edge",
        "MSIE6","MSIE7","MSIE8","MSIE9","MSIE10","MSIE11","MSIE",
        "MSIEMobile6","MSIEMobile7","MSIEMobile8","MSIEMobile9","MSIEMobile",
        "Chrome13","Chrome14","Chrome15","Chrome16","Chrome17","Chrome18","Chrome19","Chrome20","Chrome21","Chrome22","Chrome23","Chrome24","Chrome",
        "Firefox3","Firefox4","Firefox5","Firefox6","Firefox7","Firefox8","Firefox9","Firefox10","Firefox",
        "FirefoxMobile",
        "iPhoneSafari","iPadSafari",
        "Safari3","Safari4","Safari4","Safari5","Safari6","Safari",
        "OperaMini","Opera8","Opera/9","Opera11", "Opera"
    );
    
    var browser = getBrowser();
    
    function getBrowser(){
		
		var browser = navigator.userAgent;
		if(browser == null)
			return "nothing";
		
		var i;
		for(i=0;i<browserSearchString.length;i++){
			if(browser.indexOf( browserSearchString[i] ) != -1){
				browser=browserType[i];
				break;
			}
		}
		
		if(i == browserSearchString.length)
			browser="nothing";
		
		return browser;
	}

    function isISOMobile(){

        if(browser.indexOf("iPhone")!=-1 || browser.indexOf("iPad")!=-1)
            return true;
        else
            return false;
    }

    if(reportUrl.indexOf("?") == -1){
    	reportUrl += "?reportMode=HTML";
    }else if(reportUrl.indexOf("reportMode") == -1){
    	reportUrl += "&reportMode=HTML";
    }
    
    if(window.console == undefined) 
		console = window.console || { log: function() {} };
		
	function getRealOffsetTop(el) {
	    return el ? el.offsetTop + getRealOffsetTop(el.offsetParent) : 0;
	}

	function getRealOffsetLeft(el) {
	    return el ? el.offsetLeft + getRealOffsetLeft(el.offsetParent) : 0;
	}

	$(document).ready(function(){

		jsReady = true;

        $('#root').show();
		$('#root').css({
			//'width': function(){return '800px';}
			'width': function(){return '100%';},
            'background-color': function(){return menuBackGroundColor;}

		});
		
		//화면이 보고서 폭보다 넓을 경우 와
	    //report_widthUnit 이 '%' 일 경우만
		//% 일 경우 100% 만 정상 동작
	    if( parseInt(($(window).width() - pageWidth)/2) > 0 && report_widthUnit != '%'){
	    	report_leftMargin = parseInt(($(window).width() - pageWidth)/2 - 10);
	    }
		
		$('#report').css({
			//'text-align': 'center',

            'border-style': function(){return 'solid';},
            'border-width': function(){return '1px';},
            'background-color' : function() {return reportBackGroundColor;},
			'margin-left' : function() {return report_leftMargin;},
			
			'width': function(){return report_width + report_widthUnit;},
			//'height': function(){return '1100px';}
			//'height': function(){return ($(window).height()-bottomMargine) + 'px';}
            'height': function(){return ($(window).height()-bottomMargine-2) + 'px';}
		});
		
		
		if (navigator.userAgent.indexOf("Opera") == -1){
			
			if (navigator.userAgent.indexOf("J2ME/MIDP") == -1){
				$('#report table').css({
					'table-layout': 'fixed',
					'word-break': 'break-all'
				});
				
			}	
		}

        try {

            var tempPage = $('#p' + currentPage).innerWidth();
            $('#p' + currentPage).css({
                'text-align': 'left',
                'margin-left': function () {
                    //report_width가 %로 동적으로 변할 경우
                    if (report_widthUnit == '%') {
                        var leftMargin = ($(window).width() - tempPage) / 2 - 1 + 'px';
                        if (parseInt(leftMargin) < 0) {
                            return 0;
                        } else {
                            return leftMargin;
                        }
                    }
                }
            });
        }
        catch(e){

        }

        if(!lemonade) {
            if (browser.indexOf("MSIE") != -1) {
                //$('#report td').css({'letter-spacing': '-1px' });
                $('#report td').css({'letter-spacing': '-0.05mm' });
            }
            else if (browser.indexOf("Chrome") != -1) {
                $('#report td').css({'letter-spacing': '-1px' });
            }
            else if (browser.indexOf("Firefox") != -1) {
                $('#report td').css({'letter-spacing': '-1px' });
            }
            else if (browser.indexOf("Opera") != -1) {
                $('#report td').css({'letter-spacing': '-1px' });
            }
            else if (browser.indexOf("Safari") != -1) {
                $('#report td').css({'letter-spacing': '-1px' });
            }
        }
        else{
            if (browser.indexOf("Chrome") != -1) {
                $('#report td').css({'-webkit-text-size-adjust': 'none' });
            }
            else if (browser.indexOf("Firefox") != -1) {
                //$('#report td').css({'letter-spacing': '-0.1mm' });
            }
            else if (browser.indexOf("Opera") != -1) {
                //$('#report td').css({'letter-spacing': '-1px' });
                //$('#report td').css({'letter-spacing': '-0.2mm' });
                $('#report td').css({'-webkit-text-size-adjust': 'none' });
            }
            else if (browser.indexOf("Safari5") != -1) {
                //$('#report td').css({'letter-spacing': '-0.1pt' });
            }
            else {
                //$('#report td').css({'letter-spacing': 'normal' });
            }

        }

		pageTop = new Array();
		oldPageTop = new Array();

        try {
            pageTop[currentPage] = parseInt($('#p' + currentPage).offset().top) - menuHeight - reportTopMargin;
            //console.log(i + " " + pageTop[i]);
        }
        catch(e){

        }
		
		$(window).resize(function(){
			
			//화면이 보고서 폭보다 넓을 경우 와
		    //report_widthUnit 이 '%' 일 경우만
			//% 일 경우 100% 만 정상 동작
		    if( parseInt(($(window).width() - pageWidth)/2) > 0 && report_widthUnit != '%'){
		    	report_leftMargin = parseInt(($(window).width() - pageWidth)/2 - 10 );
		    }
		    
			$('#report').css({
				//'text-align': 'center',
				'margin-left' : function() {return report_leftMargin;},
				
				'width': function(){return report_width + report_widthUnit;},
				//'height': function(){return '1100px';}
				'height': function(){return ($(window).height()-bottomMargine) + 'px';}
			});

            var tempPage=$('#p' + currentPage).innerWidth();
            $('#p' + currentPage).css({
                'text-align': 'left',
                'margin-left' : function() {
                    //report_width가 %로 동적으로 변할 경우
                    if(report_widthUnit =='%'){
                        //var leftMargin = ($(window).width() - tempPage)/2 - 10 + 'px';
                        var leftMargin = ($(window).width() - tempPage)/2 - 1 + 'px';
                        if(parseInt(leftMargin) < 0){
                            return 0;
                        }else{
                            return leftMargin;
                        }
                    }
                }
            });

		});

        $('#page *',parent.document).remove();
        for(var i=1;i<=endPage;i++){
            var optionStr = "<option>" + i + "/" + endPage + "page</option>";

            $('#page',parent.document).append(optionStr);
        }

		$("#size option").eq(5).prop("selected", "selected");
		
		zoom(zoomRate);

		$("#report").scroll(function(){

			if(scrollFlag == false){
				return;
			}

			var position = $('#report').scrollTop();
			var scrollHeight = $('#report')[0].scrollHeight;
            var bottomPosition = position + $(window).height() + 5;
            var offset= $('#report').innerHeight();
            var offset2= $('#subreport').innerHeight();

			if(position ==0 && currentPage > startPage){
                goPrev();
				return true;
			}

            if(bottomPosition > scrollHeight && currentPage < endPage){
                goNext();
				return true;
			}
				
			return true;
		});
			
	});
	
    function goToMove(){
        //var pageNum = $("#page option").index($("#page option:selected"))+ 1;
        var pageNum = $('#page option',parent.document).index($('#page option:selected',parent.document))+ 1;
        goScroll(pageNum);
    }

    function goPrev(){
		
		goScroll(currentPage - 1);
		
	}
	
	function goNext(){
		goScroll(currentPage + 1);
	}

    function getMaxPage(){
        return endPage;
    }

    function goScrollTop(){
        goScroll(startPage);
        return startPage;
    }

    function goScrollBottom(){
        goScroll(endPage);
        return endPage;
    }

    function goScrollNext(){
        goScroll(currentPage+1);
        return currentPage;
    }

    function goScrollPrev(){
        goScroll(currentPage-1);
        return currentPage;
    }

    function goScrollPage(index){
        goScroll(index);
    }

    function goScrollAjax(jspUrl, parameter, method, pageNum){

        scrollFlag = false;

        if(pageNum < startPage){
            currentPage = startPage;
            pageNum = startPage;
        }
        else if(pageNum > endPage){
            currentPage = endPage;
            pageNum = endPage;
        }
        else{
            currentPage = pageNum;
        }

        parameter['page']=pageNum;
        $.ajax({
            type: method,
            dataType: "html",
            url: jspUrl,
            data: parameter ,
            success: function (html) {
                $("#subreport > *").remove();
                $("#subreport").append(html);
                var tempPage = $('#p' + pageNum).innerWidth();
                $('#p' + pageNum).css({
                    'text-align': 'left',
                    'margin-left' : function() {
                        //report_width가 %로 동적으로 변할 경우
                        if(report_widthUnit =='%'){
                            //var leftMargin = ($(window).width() - tempPage)/2 - 10 + 'px';
                            var leftMargin = ($(window).width() - tempPage)/2 - 1 + 'px';
                            if(parseInt(leftMargin) < 0){
                                return 0;
                            }else{
                                return leftMargin;
                            }
                        }
                    }
                });

                try {

                    if (zoomRate < 1.0) {
                        pageTop[pageNum] = parseInt($('#p' + pageNum).offset().top + $('#report').scrollTop()) - menuHeight - parseInt((reportTopMargin * zoomRate));
                    }
                    else {
                        pageTop[pageNum] = parseInt($('#p' + pageNum).offset().top + $('#report').scrollTop()) - menuHeight - reportTopMargin;
                    }
                }
                catch(e){
                    //console.log(e);
                }

                if (browser.indexOf("MSIE9") != -1) {
                    $('#report').animate({	scrollTop: 10 }, 0);
                    //console.log("id=" + id + " pageTop=" + (pageTop[id] ));
                }
                else if (browser.indexOf("Chrome") != -1) {
                    $('#report').animate({	scrollTop: 10 }, 0);
                    //console.log("id=" + id + " pageTop=" + (pageTop[id] ));
                }
                else if (browser.indexOf("Firefox") != -1) {
                    $('#report').animate({	scrollTop: 10 }, 0);
                    //console.log("id=" + id + " pageTop=" + (pageTop[id] ));
                }
                else if (browser.indexOf("Opera") != -1) {
                    $('#report').animate({	scrollTop: 10 }, 0);
                }
                else if (browser.indexOf("Safari") != -1) {
                    $('#report').animate({	scrollTop: 10 + 1}, 0);
                }
                else {
                    //$('#report').animate({	scrollTop: pageTop[pageNum] }, 0);
                    $('#report').animate({	scrollTop: 10 }, 0);
                }

                $('#page option',parent.document).eq(pageNum-1).prop("selected", "selected");

                scrollFlag = true;

            },
            error:function (xhr, status, error) {
                currentPage--;
                alert(status + " " + error);
            }
        });

    }

	function zoom(size){
			//console.log("-1size=" + size);

            //안드로이드 킷켓(4.4.2)이면 확대축소 무시
            if(navigator.userAgent.indexOf("Android 4.4.2") != -1)
                return;

            if(simpleMode){
                if (browser.indexOf("MSIE9") != -1) {
                    $('#subreport').css('-ms-transform-origin', '0 0');
                    $('#subreport').css('-ms-transform', 'scale(' + (size) + ')');

                }
                else if (browser.indexOf("MSIE10") != -1) {
                    $('#subreport').css('-ms-transform-origin', '0 0');
                    $('#subreport').css('-ms-transform', 'scale(' + (size) + ')');
                }
                else if (browser.indexOf("MSIE11") != -1) {
                    $('#subreport').css('-ms-transform-origin', '0 0');
                    $('#subreport').css('-ms-transform', 'scale(' + (size) + ')');
                }
                else if (browser.indexOf("MSIE7") != -1) {
                    $('#subreport').css('-ms-transform-origin', '0 0');
                    $('#subreport').css('-ms-transform', 'scale(' + (size) + ')');
                }
                else if (browser.indexOf("MSIE6") != -1) {
                    $('#subreport').css('-ms-transform-origin', '0 0');
                    $('#subreport').css('-ms-transform', 'scale(' + (size) + ')');
                }
                else {

                    $('#subreport').css('-webkit-transform', 'scale(' + (size) + ')');
                    $('#subreport').css('-webkit-transform-origin', '0 0');
                    $('#subreport').css('-moz-transform', 'scale(' + (size) + ')');
                    $('#subreport').css('-moz-transform-origin', '0 0');
                    $('#subreport').css('-o-transform', 'scale(' + (size) + ')');
                    $('#subreport').css('-o-transform-origin', '0 0');
                }

            }
            else {
                if (browser.indexOf("MSIE9") != -1) {
                    $('#subreport').css('-ms-transform-origin', '50% 0');
                    $('#subreport').css('-ms-transform', 'scale(' + (size) + ')');

                }
                else if (browser.indexOf("MSIE10") != -1) {
                    $('#subreport').css('-ms-transform-origin', '50% 0');
                    $('#subreport').css('-ms-transform', 'scale(' + (size) + ')');
                }
                else if (browser.indexOf("MSIE11") != -1) {
                    $('#subreport').css('-ms-transform-origin', '50% 0');
                    $('#subreport').css('-ms-transform', 'scale(' + (size) + ')');
                }
                else if (browser.indexOf("MSIE7") != -1) {
                    $('#subreport').css('-ms-transform-origin', '50% 0');
                    $('#subreport').css('-ms-transform', 'scale(' + (size) + ')');
                }
                else if (browser.indexOf("MSIE6") != -1) {
                    $('#subreport').css('-ms-transform-origin', '50% 0');
                    $('#subreport').css('-ms-transform', 'scale(' + (size) + ')');
                }
                else {

                    $('#subreport').css('-webkit-transform', 'scale(' + (size) + ')');
                    $('#subreport').css('-webkit-transform-origin', '50% 0');
                    $('#subreport').css('-moz-transform', 'scale(' + (size) + ')');
                    $('#subreport').css('-moz-transform-origin', '50% 0');
                    $('#subreport').css('-o-transform', 'scale(' + (size) + ')');
                    $('#subreport').css('-o-transform-origin', '50% 0');
                }

                if(size==1.1){
                    $('#bmargin').remove();
                    $('#report').append('<div id="bmargin" style="position:relative;height:240px"></div>');
                }
                else if(size==1.2){
                    $('#bmargin').remove();
                    $('#report').append('<div id="bmargin" style="position:relative;height:380px"></div>');
                }
                else if(size==1.3){
                    $('#bmargin').remove();
                    $('#report').append('<div id="bmargin" style="position:relative;height:520px"></div>');
                }
                else if(size==1.4){
                    $('#bmargin').remove();
                    $('#report').append('<div id="bmargin" style="position:relative;height:660px"></div>');
                }
                else if(size==1.5){
                    $('#bmargin').remove();
                    $('#report').append('<div id="bmargin" style="position:relative;height:760px"></div>');
                }
                else if(size==1.0){
                    $('#bmargin').remove();
                    if(landScape)
                        $('#report').append('<div id="bmargin" style="position:relative;height:240px"></div>');
                    else
                        $('#report').append('<div id="bmargin" style="position:relative;height:100px"></div>');
                }
                else{
                    $('#bmargin').remove();
                    $('#report').append('<div id="bmargin" style="position:relative;height:1px"></div>');
                }

            }

			for(var i=0;i<11;i++){
				if (size == zoomArray[i]) {
					$("#size option").eq(i).prop("selected", "selected");
				}
					
			}

            try {

                if (size < 1.0) {
                    pageTop[i] = parseInt($('#p' + currentPage).offset().top + $('#report').scrollTop()) - menuHeight - parseInt((reportTopMargin * size));
                }
                else {
                    pageTop[i] = parseInt($('#p' + currentPage).offset().top + $('#report').scrollTop()) - menuHeight - reportTopMargin;
                }
                //console.log(i + " " + pageTop[i]);
            }
            catch(e){

            }
	}

	function ZoomIn(){
		var index = $("#size option").index($("#size option:selected"));
		zoom(zoomArray[index+1]);
		zoomRate = zoomArray[index+1];
	}
			
	function ZoomOut(){
		var index = $("#size option").index($("#size option:selected"));
		if(index == 0)
			index = 1;
		zoom(zoomArray[index-1]);
		zoomRate = zoomArray[index-1];
		
	}		
	
	function ZoomInOut(){
		var index = $("#size option").index($("#size option:selected"));
		zoom(zoomArray[index]);
		zoomRate = zoomArray[index];
	}

	function divPrint() {
		beforePrint();
		window.print();		
		afterPrint();
		
	}
	
	function beforePrint(){
		
	}
	
	function afterPrint(){
			
	}

    function callLink(method, url, params, targetFrame, callbackFn) {
        var paramElements = "";
        if (params) {
            var paramPairs = params.split('&'); // array of param(n=v)
            for (var i = 0; i < paramPairs.length; i++) {
                var pair = paramPairs[i].split('='); // param arr(n,v)
                paramElements += "<input type='hidden' name='" + pair[0] +
                    "' value='" + escapeValue(pair[1]) + "'>\n";
            }
        }

        var form = document.getElementById("aireport-dummy-form");
        if (form == null) { // first submit
            form = document.createElement("form");
            form.setAttribute("id", "aireport-dummy-form");
            document.body.appendChild(form);
        } else { // clear후 재사용 (삭제는 구조상 곤란)
            form.innerHTML = "";
        }

        form.setAttribute("action", url);
        form.setAttribute("method", method);
        form.setAttribute("target", targetFrame);
        form.innerHTML = paramElements;

        form.submit();
        if (callbackFn) callbackFn();
    }

    function callLink2(method, url, params, targetFrame) {
        var paramElements = "";
        if (params) {
            var paramPairs = params.split('&'); // array of param(n=v)
            for (var i = 0; i < paramPairs.length; i++) {
                var pair = paramPairs[i].split('='); // param arr(n,v)
                paramElements += "<input type='hidden' name='" + pair[0] +
                    "' value='" + escapeValue(pair[1]) + "'>\n";
            }
        }

        var form = document.getElementById("aireport-dummy-form");
        if (form == null) { // first submit
            form = document.createElement("form");
            form.setAttribute("id", "aireport-dummy-form");
            document.body.appendChild(form);
        } else { // clear후 재사용 (삭제는 구조상 곤란)
            form.innerHTML = "";
        }

        form.setAttribute("action", url);
        form.setAttribute("method", method);
        form.setAttribute("target", targetFrame);
        form.innerHTML = paramElements;

        form.submit();
    }

    var replExp = /'/g; // input value='v'에 적용하기 위해 '를 replace
    function escapeValue(value) {
        if (typeof value != "string") return value;

        if (value.indexOf("'") == -1) {
            return value;
        } else {
            return (value.replace(replExp, "&#039;"));
        }
    }

    var $iframe;
    function callRequestUrl(url, params, method) {
        if ($iframe) {
            $iframe.remove();
        }

        if(isISOMobile()) {
            var myParams = "";
            for (var key in params) {
                if (params.hasOwnProperty(key)) {

                    myParams += key + '=' + params[key] + '&';
                }
            }

            url = url + '?' + myParams + 'url=' + getStripUrl(reportUrl);
            if(window.location != window.parent.location)
                window.open(url);
            else
                location.href = url;
            return;
        }

        var fileDownloadCheckTimer;
        var downloadWindow,
            formDoc,
            $form;

        var formInnerHtml = "";

        method = method || "POST";

        // 현재 쿠키설정 테스트
        $.cookie("cookieTest","true");
        var cookieTest= $.cookie("cookieTest");

        if(cookieTest) {
            $("#loading3").show();
            $.removeCookie('fileDownloadToken', { path: '/' });
        }

        for(var key in params) {
            if(params.hasOwnProperty(key)) {

                formInnerHtml += '<input type="hidden" name="' + key + '" value="' + params[key] + '" />';
            }
        }

        formInnerHtml += '<input type="hidden" name="' + 'url' + '" value="' + getStripUrl(reportUrl) + '" />';

        $iframe = $("<iframe>")
            .hide()
            .prop("src", 'about:blank')
            .prop("id", 'myframe')
            .prop("name", 'myframe')
            .appendTo("body");

        formDoc = getiframeDocument($iframe);
        formDoc.write("<html><head></head><body><form name='myform' method='" + method + "' action='" + url + "'>" + formInnerHtml + "</form>" + "</body></html>");
        //$form = $(formDoc).find('form');

        fileDownloadCheckTimer = setInterval(function () {
            if(!cookieTest){
                clearInterval(fileDownloadCheckTimer);
                return;
            }

            var cookieValue = $.cookie("fileDownloadToken");
            if (cookieValue == "success") {

                setTimeout(function () {
                    $("#loading3").hide();
                    //if ($iframe) {
                    //    $iframe.remove();
                    //}
                },10);

                $.removeCookie('fileDownloadToken', { path: '/' });
                clearInterval(fileDownloadCheckTimer);
                return;
            }

        }, 500);

        //window.top.myframe.document.myform.submit();
        formDoc.myform.submit();
        //$form.submit();

    }

    //gets an iframes document in a cross browser compatible manner
    function getiframeDocument($iframe) {
        var iframeDoc = $iframe[0].contentWindow || $iframe[0].contentDocument;
        if (iframeDoc.document) {
            iframeDoc = iframeDoc.document;
        }
        return iframeDoc;
    }

	function getStripUrl(url){
		if(url.indexOf("?") != -1){
			var stripUrl=url.substring(0,url.indexOf("?"));
		}
		else{
			stripUrl=url;
		}
		
		return stripUrl;
	}

    function printDialogPopupIE(jspCall, pdfPath){

        pdfPath=encodeURIComponent(pdfPath);
        var embedTag="<object data=\"" + jspCall + pdfPath + "\" " + "id=\"pdfDoc\" name=\"pdfDoc\" type=\"application/pdf\" width=\"1px\" height=\"1px\">";
        //var embedIframeTag="<iframe id=\"iFramePdf\" name=\"iFramePdf\" src=\"" + jspCall + pdfPath + "\" " + "style=\"display:none\" width=\"1px\" height=\"1px\"></iframe>";
        if($('#pdfdiv').children().length == 0){
            $('#pdfdiv').append(embedTag);
        }
        else{
            $('#pdfDoc').remove();
            $('#pdfdiv').append(embedTag);
        }

        setTimeout("printDialogIE();", 1000);

    }

    function printDialogIE(){
        document.getElementById('pdfDoc').printAll();
        if(langScCd.indexOf("ko")!=-1)
            alert("인쇄완료...");
        else
            alert("Complete Print...");
    }

    function printDialogPopup(jspCall, pdfPath){

        // 현재 쿠키설정 테스트
        var fileDownloadCheckTimer;
        $.cookie("cookieTest","true");
        var cookieTest= $.cookie("cookieTest");

        if(cookieTest) {
            $("#loading3").show();
            $.removeCookie('fileDownloadToken', { path: '/' });
        }

        fileDownloadCheckTimer = setInterval(function () {
            if(!cookieTest){
                clearInterval(fileDownloadCheckTimer);
                return;
            }

            var cookieValue = $.cookie("fileDownloadToken");
            if (cookieValue == "success") {

                setTimeout(function () {
                    $("#loading3").hide();
                },10);

                $.removeCookie('fileDownloadToken', { path: '/' });
                clearInterval(fileDownloadCheckTimer);
                return;
            }

        }, 500);

        //pdfPath=encodeURIComponent(pdfPath);
        //var embedTag="<embed src=\"" + jspCall + pdfPath + "\" " + "id=\"pdfDoc\" name=\"pdfDoc\" width=\"1px\" height=\"1px\" onload=printAll();>";
        var embedTag="<embed src=\"" + jspCall + pdfPath + "\" " + "id=\"pdfDoc\" name=\"pdfDoc\" width=\"1px\" height=\"1px\">";
        //var embedTag="<embed src=\"" + jspCall + pdfPath + "\" " + "id=\"pdfDoc\" name=\"pdfDoc\" width=\"1px\" height=\"1px\" type=\"application/pdf\" pluginspage=\"http://www.macromedia.com/shockwave/download/index.cgi? P1_Prod_Version=ShockwaveFlash\" >";
        var embedIframeTag="<iframe id=\"iFramePdf\" name=\"iFramePdf\" src=\"" + jspCall + pdfPath + "\" " + "style=\"display:none\" width=\"1px\" height=\"1px\" onload=printDialog()></iframe>";
        var embedIframeTag2="<iframe id=\"iFramePdf\" name=\"iFramePdf\" src=\"" + jspCall + pdfPath + "\" " + "width=\"1px\" height=\"1px\" onload=printDialog()></iframe>";

        if (navigator.userAgent.indexOf("Safari") != -1 )
        {

            if(navigator.userAgent.indexOf("Chrome") != -1){

                if($('#pdfdiv').children().length == 0){
                    $('#pdfdiv').append(embedIframeTag);
                }
                else{
                    //var getMyFrame = document.getElementById('iFramePdf');
                    //getMyFrame.focus();
                    //getMyFrame.contentWindow.print();
                    $('#iFramePdf').remove();
                    $('#pdfdiv').append(embedIframeTag);
                }

            }
            else if(navigator.userAgent.indexOf("Edge") != -1){
                //Edge
                if($('#pdfdiv').children().length == 0){
                    $('#pdfdiv').append(embedIframeTag2);
                }
                else{
                    var getMyFrame = document.getElementById('iFramePdf');
                    getMyFrame.focus();
                    getMyFrame.contentWindow.print();
                }
            }
            else{
                //Chrome, Opera
                if($('#pdfdiv').children().length == 0){
                    $('#pdfdiv').append(embedTag);
                }
                else{
                    $('#pdfDoc').remove();
                    $('#pdfdiv').append(embedTag);
                }
            }
        }
        else if(navigator.userAgent.indexOf("MSIE") != -1 || navigator.userAgent.indexOf("rv:11.0") != -1){

            //IE9-11
            if($('#pdfdiv').children().length == 0){
                $('#pdfdiv').append(embedIframeTag);
            }
            else{
                $('#iFramePdf').remove();
                $('#pdfdiv').append(embedIframeTag);

            }

        }
        else
        {
            //FireFox
            if($('#pdfdiv').children().length == 0){
                $('#pdfdiv').append(embedTag);
            }
            else{
                $('#pdfDoc').remove();
                $('#pdfdiv').append(embedTag);
            }
        }

    }
		
	function printDialog(){
		var getMyFrame = document.getElementById('iFramePdf');
        setTimeout(function () {
            getMyFrame.focus();
            getMyFrame.contentWindow.print();
        },1000);
	}
	
	function urlPrint(xmlData){
		alert(xmlData);
		if(printCount == 1){
			if (swfReady){
				getSWF("AIprint").flashPrint(xmlData);
			}
		}
		else{
			if (swfReady){
				getSWF("AIprint").flashPrint("reprint");
			}
		}
	}

    function directPrint(params, url, method){

        method = method || "POST";

        //if((browser.indexOf("Edge") != -1) || windowPrint){
        if(windowPrint){

            /*
             if(langScCd.indexOf("ko")!=-1) {
             alert("Edge나 WindowPrint Mode에서는 인쇄를 진행할 수 없습니다.");
             }
             else {
             alert("Edge or WindowPrint Mode not support printing.");
             }
             return;
             */

            if((browser.indexOf("MSIE8")==-1) && (browser.indexOf("MSIE7")==-1) && (browser.indexOf("MSIE6")==-1) &&
                (browser.indexOf("Safari")==-1) ) {
                var target = document.getElementById('myIframe');
                if (target == null) {
                    var $iframe, formDoc;
                    var formInnerHtml = "";

                    // 현재 쿠키설정 테스트
                    $.cookie("cookieTest", "true");
                    var cookieTest = $.cookie("cookieTest");

                    if (cookieTest)
                        $("#loading3").show();

                    for (var key in printParameter) {
                        if (printParameter.hasOwnProperty(key)) {

                            formInnerHtml += '<input type="hidden" name="' + key + '" value="' + printParameter[key] + '" />';
                        }
                    }

                    $iframe = $("<iframe>")
                        .hide()
                        .prop("src", 'about:blank')
                        .prop("id", 'myIframe')
                        .prop("name", 'myIframe')
                        .appendTo("body");

                    formDoc = getiframeDocument($iframe);
                    formDoc.write("<html><head></head><body><form name='myform' method='" + method + "' action='" + url + "'>" + formInnerHtml + "</form>" + "</body></html>");

                    $iframe.on("load",function () {

                        $("#loading3").hide();

                        target = document.getElementById('myIframe');
                        if (browser.indexOf("Firefox") != -1) {
                            target.contentWindow.print();
                        }
                        else {
                            target.contentWindow.document.execCommand('print', false, null);
                        }

                    });

                    formDoc.myform.submit();
                }
                else {

                    if (browser.indexOf("Firefox") != -1) {
                        target.contentWindow.print();
                    }
                    else {
                        target.contentWindow.document.execCommand('print', false, null);
                    }
                }
                return;
            }

        }

        if(browser.indexOf("Firefox") != -1){
            if (langScCd.indexOf("ko") != -1) {
                if (confirm("Firefox는 직접 인쇄를 할 수 없습니다. \r\n해당 문서를 다운로드후 인쇄를 진행 하시겠습니까?")) {
                    PDFConvert();
                }
            }
            else {
                if (confirm("Firefox can not direct printing.\r\nDo you want to download the document?")) {
                    PDFConvert();
                }
            }
            return;
        }

        if(browser.indexOf("Safari") == -1 && browser.indexOf("Chrome") == -1 && browser.indexOf("Edge") == -1){

            if(isInstalledAcrobatReader() == false){

                if(langScCd.indexOf("ko")!=-1) {
                    if (confirm("Adobe Reader가 없거나 최신버전이 아닙니다. \r\n해당 문서를 다운로드 하시겠습니까?")) {
                        PDFConvert();
                    }
                }
                else {
                    if(confirm("The latest version of Adobe Reader, please use the installation or upgrade.\r\nDo you want to download the document?")){
                        PDFConvert();
                    }
                }

                return;
            }
        }

        printDialogPopupIframe(url, params, "POST");

    }

    var $iframe2;
    function printDialogPopupIframe(url, params, method) {

        var fileDownloadCheckTimer;
        var formDoc;
        var formInnerHtml = "";

        //url=url+'?';

        method = method || "POST";

        if ($iframe2) {
            $iframe2.remove();
        }

        // 현재 쿠키설정 테스트
        $.cookie("cookieTest","true");
        var cookieTest= $.cookie("cookieTest");

        if(cookieTest) {
            $("#loading3").show();
            $.removeCookie('fileDownloadToken', { path: '/' });
        }

        for(var key in params) {
            if(params.hasOwnProperty(key)) {

                formInnerHtml += '<input type="hidden" name="' + key + '" value="' + params[key] + '" />';
            }
        }

        $iframe2 = $("<iframe>")
            .hide()
            .prop("src", 'about:blank')
            .prop("id", 'myframe2')
            .prop("name", 'myframeName')
            .prop("width", '1px')
            .prop("height", '1px')
            .appendTo("body");

        formDoc = getiframeDocument($iframe2);
        formDoc.write("<html><head></head><body><form name='myform' method='" + method + "' action='" + url + "'>" + formInnerHtml + "</form>" + "</body></html>");

        fileDownloadCheckTimer = setInterval(function () {
            if(!cookieTest){
                clearInterval(fileDownloadCheckTimer);
                return;
            }

            var cookieValue = $.cookie("fileDownloadToken");
            if (cookieValue == "success") {

                setTimeout(function () {
                    $("#loading3").hide();
                },10);

                $.removeCookie('fileDownloadToken', { path: '/' });
                clearInterval(fileDownloadCheckTimer);
                return;
            }

        }, 500);

        $iframe2.on("load",function(){

            window.clearInterval(fileDownloadCheckTimer);
            $("#loading3").hide();

            var getMyFrame = document.getElementById('myframe2');
            setTimeout(function () {
                getMyFrame.focus();
                getMyFrame.contentWindow.print();
            },1000);

        });

        formDoc.myform.submit();

    }

	function pdfPrint(url,params,width,height){
		
		/*
		if(browser.indexOf("Safari") == -1){
			
			var info = getAcrobatInfo();
			if(info.acrobat==false){
				if(langScCd.indexOf("ko")!=-1)
					alert("Adobe Reader를 설치후 이용바랍니다.");
				else
					alert("Please use after installing Adobe Reader.");
				return;
			}
		}
		*/
		
		if(browser.indexOf("Safari") == -1 && browser.indexOf("Chrome") == -1){
			
			//var info = getAcrobatInfo();
			if(isInstalledAcrobatReader() == false){

				//if(langScCd.indexOf("ko")!=-1)
				//	alert("Adobe Reader를 최신버전으로 설치 또는 업그레이드 후 이용바랍니다.");
				//else
				//	alert("The latest version of Adobe Reader, please use the installation or upgrade.");

                if(langScCd.indexOf("ko")!=-1) {
                    if (confirm("Adobe Reader가 없거나 최신버전이 아닙니다. \r\n해당 문서를 다운로드 하시겠습니까?")) {
                        PDFConvert();
                    }
                }
                else {
                    if(confirm("The latest version of Adobe Reader, please use the installation or upgrade.\r\nDo you want to download the document?")){
                        PDFConvert();
                    }
                }
				return;
			}
		}
		
		var urlparams = JSON.parse(params);
		//var options = "toolbar=no," + "width=" + width + ",height=" + height + ",status=no";
		//window.open(url+urlparams[0].targetURL,"print",options);
		
		printDialogPopup(url, urlparams[0].targetURL);
	}

    function isInstalledAcrobatReader(){
        var displayString;
        var acrobat=new Object();

        acrobat.installed=true;
        return acrobat.installed;

        acrobat.installed=false;
        if(browser.indexOf("MSIE11") != -1 || browser.indexOf("MSIE10") != -1){
            try
            {
                oAcro7=new ActiveXObject('AcroPDF.PDF.1');
                if (oAcro7)
                {
                    acrobat.installed=true;
                    acrobat.version='7.0';

                    if( oAcro7.GetVersions().indexOf("10") == -1 &&
                        oAcro7.GetVersions().indexOf("11") == -1 &&
                        oAcro7.GetVersions().indexOf("12") == -1 &&
                        oAcro7.GetVersions().indexOf("13") == -1 &&
                        oAcro7.GetVersions().indexOf("14") == -1 &&
                        oAcro7.GetVersions().indexOf("15") == -1 &&
                        oAcro7.GetVersions().indexOf("16") == -1 &&
                        oAcro7.GetVersions().indexOf("17") == -1 &&
                        oAcro7.GetVersions().indexOf("18") == -1 &&
                        oAcro7.GetVersions().indexOf("19") == -1 &&
                        oAcro7.GetVersions().indexOf("20") == -1  ){

                        acrobat.installed=false;
                    }
                    return acrobat.installed;

                }
            }
            catch(e) {
                acrobat.installed=false;
            }

            try
            {
                oAcro7=new ActiveXObject('FoxitReader.FoxitReaderCtl.1');
                if (oAcro7)
                {
                    acrobat.installed=true;
                    acrobat.version='7.0';
                    return acrobat.installed;
                }
            }
            catch(e) {
                acrobat.installed=false;
            }

            try
            {
                oAcro7=new ActiveXObject('NitroPDF.IE.ActiveDoc.8');
                if (oAcro7)
                {
                    acrobat.installed=true;
                    acrobat.version='7.0';
                    return acrobat.installed;
                }
            }
            catch(e) {
                acrobat.installed=false;
            }

            try
            {
                oAcro7=new ActiveXObject('NitroPDF.IE.ActiveDoc.5');
                if (oAcro7)
                {
                    acrobat.installed=true;
                    acrobat.version='7.0';
                    return acrobat.installed;
                }
            }
            catch(e) {
                acrobat.installed=false;
            }

            return acrobat.installed;
        }


        if (navigator.plugins && navigator.plugins.length) {

            for (x=0; x<navigator.plugins.length;x++) {

                if (
                    navigator.plugins[x].description.indexOf('Adobe Acrobat')!= -1 ||
                    navigator.plugins[x].description.indexOf('Adobe PDF')!= -1
                    )
                {
                    acrobat.version=parseFloat(navigator.plugins[x].description.split('Version ')[1]);

                    if (acrobat.version.toString().length == 1) acrobat.version+='.0';

                    acrobat.installed=true;
                    return acrobat.installed;
                }
                else if(navigator.plugins[x].description.indexOf('Foxit') != -1 ||
                    navigator.plugins[x].description.indexOf('Nitro') != -1)
                {
                    acrobat.installed=true;
                    return acrobat.installed;
                }
            }
        }
        else if (window.ActiveXObject)
        {
            for (x=2; x<10; x++)
            {
                try
                {
                    var id="PDF.PdfCtrl." + x;
                    oAcro=new ActiveXObject(id);
                    if (oAcro)
                    {
                        acrobat.installed=true;
                        return acrobat.installed;
                    }
                }
                catch(e) {
                    acrobat.installed=false;
                }
            }

            try
            {
                oAcro4=new ActiveXObject('PDF.PdfCtrl.1');
                if (oAcro4)
                {
                    acrobat.installed=true;
                    acrobat.version='4.0';
                    return acrobat.installed;
                }
            }
            catch(e) {
                acrobat.installed=false;
            }

            try
            {
                oAcro7=new ActiveXObject('AcroPDF.PDF.1');
                if (oAcro7)
                {
                    acrobat.installed=true;
                    acrobat.version='7.0';
                    return acrobat.installed;
                }
            }
            catch(e) {
                acrobat.installed=false;
            }

            try
            {
                oAcro7=new ActiveXObject('FoxitReader.FoxitReaderCtl.1');
                if (oAcro7)
                {
                    acrobat.installed=true;
                    acrobat.version='991.0';
                    return acrobat.installed;
                }
            }
            catch(e) {}

            try
            {
                oAcro7=new ActiveXObject('NitroPDF.IE.ActiveDoc.8');
                if (oAcro7)
                {
                    acrobat.installed=true;
                    acrobat.version='992.0';
                    return acrobat.installed;
                }
            }
            catch(e) {
                acrobat.installed=false;
            }

            try
            {
                oAcro7=new ActiveXObject('NitroPDF.IE.ActiveDoc.5');
                if (oAcro7)
                {
                    acrobat.installed=true;
                    acrobat.version='992.1';
                    return acrobat.installed;
                }
            }
            catch(e) {
                acrobat.installed=false;
            }

        }

        return acrobat.installed;
    }

    function handleConvert() {
        var convertType = document.getElementById("convertType");
        var type = convertType.options[convertType.selectedIndex].value;
        if (type == "pdf") {
            PDFConvert();
        } else if (type == "excel") {
            ExcelConvert();
        } else if (type == "hwp") {
            hwpConvert();
        } else if (type == "word") {
            mswordConvert();
        } else if (type == "ppt") {
            powerPointConvert();
        }
    }