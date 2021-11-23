package egovframework.seoul.system.userManage.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.seoul.stat.service.StatService;
import egovframework.seoul.system.userManage.service.UserManageService;
import lombok.extern.slf4j.Slf4j;

/**
 * 온실가스 지도
 * 
 * @author ghg 개발
 * @since 2020.11 ~ 2020.12
 *
 */

@Controller
@Slf4j
public class UserManageController {

	@Autowired
	UserManageService userManageService;

	@Autowired
	StatService statService;

	@RequestMapping(value = "/userManage/userManage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String userManage(@RequestParam Map<String, Object> paraMap, ModelMap model) throws Exception {

		/* 기관 */
		List<Map<String, Object>> officerList = userManageService.selectOfficerCodeList();
		model.addAttribute("officerList", officerList);

		/* 권한 */
		paraMap.put("S_CAT", "AUTH_INFO");
		List<Map<String, Object>> AUTH_INFO = statService.getCode((HashMap<String, Object>) paraMap);
		model.addAttribute("AUTH_INFO", AUTH_INFO);

		/* 가입상태 */
		paraMap.put("S_CAT", "REG_STATUS");
		List<Map<String, Object>> REG_STATUS = statService.getCode((HashMap<String, Object>) paraMap);
		model.addAttribute("REG_STATUS", REG_STATUS);

		return "userManage/userManage";
	}

	@RequestMapping(value = "/userManage/userManage_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String userManage_search(@RequestParam Map<String, Object> paraMap, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List<Map<String, Object>> list = userManageService.userManage_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}

	@RequestMapping(value = "/userManage/userManage_create.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String userManage_create(@RequestParam Map<String, Object> paraMap, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		int result = userManageService.userManage_create(paraMap);
		String message = null;
		if (result > 0) {
			message = "사용자가 정상적으로 등록되었습니다.";
		} else {
			message = "사용자 등록이 실패하였습니다. 관리자에게 문의해 주세요.";
		}

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", message);

		return "json/response";
	}

	@RequestMapping(value = "/userManage/userManage_delete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String userManage_delete(@RequestParam Map<String, Object> paraMap, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		int result = userManageService.userManage_delete(paraMap);
		String message = null;
		if (result > 0) {
			message = "사용자 정보가 정상적으로 삭제되었습니다.";
		} else {
			message = "사용자정보 삭제가 실패하였습니다. 관리자에게 문의해 주세요.";
		}

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", message);

		return "json/response";
	}

	@RequestMapping(value = "/userManage/userManage_update.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String userManage_update(@RequestParam Map<String, Object> paraMap, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		int result = userManageService.userManage_update(paraMap);
		String message = null;
		if (result > 0) {
			message = "사용자 정보가 수정되었습니다.";
		} else {
			message = "사용자 정보 수정이 실패하였습니다. 관리자에게 문의해 주세요.";
		}

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", message);

		return "json/response";
	}

	@RequestMapping(value = "/userManage/userManage_initPassword.do", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String userManage_initPassword(@RequestParam Map<String, Object> paraMap, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		int result = userManageService.userManage_initPassword(paraMap);
		String message = null;
		if (result > 0) {
			message = "사용자의 비밀번호가 초기화되었습니다.";
		} else {
			message = "사용자 비밀번호 초기화에 실패하였습니다. 관리자에게 문의해 주세요.";
		}

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", message);

		return "json/response";
	}

}
