package egovframework.seoul.main.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.seoul.main.service.MainService;

@Controller
public class MainController {

	@Autowired
	MainService mainService;

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(MainController.class);

	@RequestMapping(value = "/main/login.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(HttpServletRequest request, ModelMap model, @RequestParam Map<String, Object> paraMap) {
		logger.debug("paraMap::" + paraMap.toString());
		model.addAttribute("paraMap", paraMap);
		
		return "/main/login";
	}

	@RequestMapping(value = "/main/intro.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String intro(HttpServletRequest request, ModelMap model, @RequestParam Map<String, Object> paraMap) {
		return "/main/intro";
	}

	@RequestMapping(value = "/main/actionLogin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String actionLogin(HttpServletRequest request, ModelMap model, @RequestParam Map<String, Object> paraMap) throws Exception {
		logger.debug("paraMap::" + paraMap.toString());

		Map<String, Object> loginInfo = mainService.actionLogin(paraMap);
		if (loginInfo != null && loginInfo.get("ADMIN_ID") != null && !loginInfo.get("ADMIN_ID").equals("")) {
			request.getSession().setAttribute("loginInfo", loginInfo);
		} else {
			model.addAttribute("message", "로그인에 실패하였습니다. 관리자에게 문의해 주세요.");
			return "/main/login";
		}

		return "redirect:/main/intro.do";
	}
	
	@RequestMapping(value = "/main/changePassword.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String changePassword(HttpServletRequest request, ModelMap model, @RequestParam Map<String, Object> paraMap) throws Exception {
		logger.debug("paraMap::" + paraMap.toString());
		
		String message = null;
		int resultCnt = mainService.changePassword(paraMap); 
		if(resultCnt > 0){
			message = "비밀번호가 성공적으로 변경되었습니다.";
		}else {
			message = "비밀번호 변경에 실패하였습니다.";			
		}
		model.addAttribute("result", message);

		return "json/response";
	}
	
	@RequestMapping(value = "/main/actionLogout.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String actionLogout(HttpServletRequest request, ModelMap model, @RequestParam Map<String, Object> paraMap) throws Exception {
		logger.debug("paraMap::" + paraMap.toString());

		request.getSession().setAttribute("loginInfo", null);

		return "redirect:/main/login.do";
	}
}
