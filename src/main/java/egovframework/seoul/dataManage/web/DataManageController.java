package egovframework.seoul.dataManage.web;

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

import egovframework.seoul.dataManage.service.DataManageService;
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
public class DataManageController {

	@Autowired
	DataManageService dataManageService;

	@RequestMapping(value = "/dataManage/dataManage001.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String dataManage001(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		List<Map<String, Object>> yearList = dataManageService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);

		return "dataManage/dataManage001";
	}

	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/dataManage/dataManage001_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String dataManage001_search(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		List list = dataManageService.dataManage001_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}
	
	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/dataManage/dataManage001_execute.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String dataManage001_execute(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		dataManageService.dataManage001_execute(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", "S");
		
		return "json/response";
	}
	
	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/dataManage/dataManage001_saveMonth.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String dataManage001_saveMonth(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String msg= dataManageService.dataManage001_saveMonth(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", msg);
		
		return "json/response";
	}
	
	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/dataManage/dataManage001_getCRFMonthData.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String dataManage001_getCRFMonthData(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		List list = dataManageService.dataManage001_getCRFMonthData(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);
		
		return "json/response";
	}
	
	@RequestMapping(value = "/dataManage/dataManage002.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String dataManage002(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> yearList = dataManageService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);
		
		return "dataManage/dataManage002";
	}
	
	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/dataManage/dataManage002_close.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String dataManage002_close(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String msg = dataManageService.dataManage002_close(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", msg);

		return "json/response";
	}
	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/dataManage/dataManage002_closeCancel.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String dataManage002_closeCancel(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String msg = dataManageService.dataManage002_closeCancel(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", msg);
		
		return "json/response";
	}
	
	@RequestMapping(value = "/dataManage/dataManage003.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String dataManage003(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		List<Map<String, Object>> yearList = dataManageService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);

		return "dataManage/dataManage003";
	}
	
	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/dataManage/dataManage003_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String dataManage003_search(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		List list = dataManageService.dataManage003_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}
	
	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/dataManage/dataManage003_save.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String dataManage003_save(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String msg= dataManageService.dataManage003_save(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", msg);
		
		return "json/response";
	}
	

	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/dataManage/dataManage003_execute.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String dataManage003_execute(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		dataManageService.dataManage003_execute(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", "S");
		
		return "json/response";
	}

}
