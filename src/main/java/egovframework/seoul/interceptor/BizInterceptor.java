package egovframework.seoul.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class BizInterceptor extends HandlerInterceptorAdapter {

	@SuppressWarnings("unused")
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@SuppressWarnings("unchecked")
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		if(!request.getRequestURI().equals("/main/login.do") && !request.getRequestURI().equals("/main/actionLogin.do") && !request.getRequestURI().equals("/main/changePassword.do")) {
			Map<String, Object> loginInfo = (Map<String, Object>) request.getSession().getAttribute("loginInfo");
			if(loginInfo == null) {
				ModelAndView modelAndView = new ModelAndView("forward:/main/login.do");
				modelAndView.getModelMap().addAttribute("message", "세션이 종료되었습니다. 다시 로그인해 주세요.");
				throw new ModelAndViewDefiningException(modelAndView);
			}
		}

		return super.preHandle(request, response, handler);
	}
}
