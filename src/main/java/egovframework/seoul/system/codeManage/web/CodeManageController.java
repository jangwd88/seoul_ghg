package egovframework.seoul.system.codeManage.web;

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

import egovframework.seoul.system.codeManage.service.CodeManageService;
import egovframework.seoul.util.RequestUtil;
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
public class CodeManageController {

	@Autowired
	CodeManageService codeManageService;

	@RequestMapping(value = "/codeManage/codeManage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String codeManage(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {

		return "codeManage/codeManage";
	}

	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/codeManage/masterCodeData.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String codeManage_search(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List<Map<String, Object>> list = codeManageService.masterCodeData(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}
	
	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/codeManage/detailCodeData.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String detailCodeData(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		List<Map<String, Object>> list = codeManageService.detailCodeData(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);
		
		return "json/response";
	}
	
	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/codeManage/addNUpdateCodeMaster.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String addCodeMaster(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		
		String msg = codeManageService.addNUpdateCodeMaster(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", msg);
		
		return "json/response";
	}
	
	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/codeManage/addNUpdateCodeDetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String addNUpdateCodeDetail(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		
		String msg = codeManageService.addNUpdateCodeDetail(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", msg);
		
		return "json/response";
	}
	
	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/codeManage/deleteCodeMaster.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteCodeMaster(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		
		String msg = codeManageService.deleteCodeMaster(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", msg);
		
		return "json/response";
	}
	
	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/codeManage/deleteCodeDetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteCodeDetail(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		
		String msg = codeManageService.deleteCodeDetail(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", msg);
		
		return "json/response";
	}

}
