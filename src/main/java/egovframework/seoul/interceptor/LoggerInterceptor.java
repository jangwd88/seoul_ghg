package egovframework.seoul.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.seoul.log.service.AccessLogService;

@SuppressWarnings({ "unchecked", "rawtypes" })
public class LoggerInterceptor extends HandlerInterceptorAdapter {

    private static final Logger log = LoggerFactory.getLogger(LoggerInterceptor.class);

//	@Autowired
//	LogManageService logManageService;

	@Autowired
	AccessLogService accessLogService;

	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        // 로그 등록
        accessLog(request);

        return super.preHandle(request, response, handler);
    }

//	@SuppressWarnings("unused")
//    private void regiMenuAccessLog(String menuId, HttpSession session) throws Exception {
//        Map parmMap = new HashMap();
//		String ssUserId = (String) session.getAttribute(BizConst._SESSION_KEY_USERID);
//		parmMap.put("ssUserId", ssUserId);
//		// inert menu access log
//		//int res = logManageService.insertMenuAccessLog(parmMap);
//
//	}

	// 접속 로그 등록
    private void accessLog(HttpServletRequest request) {

        HttpSession session   = request.getSession();
        Map         loginInfo = (Map)session.getAttribute("loginInfo");
        String      userNo    = (loginInfo != null)? (String)loginInfo.get("ADMIN_ID") : "";
        String      serverNm  = request.getServerName();

        // Access Log Registration
        Map logMap = new HashMap();
        logMap.put("userNo",    (userNo != null && userNo.trim().length() != 0)? userNo : "guest" );
        logMap.put("userIp",    request.getRemoteAddr());
        logMap.put("progNm",    getRequestURL(request));
        logMap.put("serverNm",  serverNm+":"+request.getServerPort()+"__"+
                                request.getLocalName()+"__"+
                                request.getLocale().toString());

        // DB 등록 처리
        accessLogService.regiAccessLog(logMap);
    }

    private String getRequestURL(HttpServletRequest request) {
        String requestURL = request.getRequestURI();
        requestURL      = requestURL.substring(request.getContextPath().length());
        String pathInfo = request.getPathInfo();

        if ("/".equals(requestURL) && pathInfo != null) {
            requestURL = pathInfo;
        }
        return requestURL;
    }
}
