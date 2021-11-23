package egovframework.seoul.inven.web;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.seoul.inven.service.InvenService;
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
public class InvenController {

	@Autowired
	InvenService invenService;

	@RequestMapping(value = "/inven/inven001.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String inven001(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		List<Map<String, Object>> yearList = invenService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);

		return "inven/inven001";
	}

	@SuppressWarnings({ "rawtypes", "static-access", "unchecked" })
	@RequestMapping(value = "/inven/inven001_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String inven001_search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List list = invenService.inven001_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);
		
		return "json/response";
	}

	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/inven/inven001_search_chart.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String inven001_search_chart(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		System.out.println("paraMap::"+paraMap.toString());
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List list = invenService.inven001_search_chart(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}
	@SuppressWarnings({ "unchecked" })
	@RequestMapping(value = "/inven/inven001_saveImage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String inven001_search_chart(MultipartHttpServletRequest multiRequest, HttpServletResponse response, ModelMap model)
			throws Exception {
		Map<String, Object> loginInfo = (Map<String, Object>) multiRequest.getSession().getAttribute("loginInfo");
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		String chartType = multiRequest.getParameter("type");
		System.out.println("chartType : " + chartType);
		String result = invenService.inven001_saveIMage(files, loginInfo, chartType);
		
		return "json/response";
	}

	@RequestMapping(value = "/inven/inven002.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String inven002(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		List<Map<String, Object>> yearList = invenService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);

		return "inven/inven002";
	}

	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/inven/inven002_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String inven002_search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List list = invenService.inven002_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}

	@RequestMapping(value = "/inven/inven003.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String inven003(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		List<Map<String, Object>> yearList = invenService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);

		return "inven/inven003";
	}

	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/inven/inven003_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String inven003_search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List list = invenService.inven003_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}

	@RequestMapping(value = "/inven/inven004.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String inven004(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		List<Map<String, Object>> yearList = invenService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);

		return "inven/inven004";
	}

	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/inven/inven004_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String inven004_search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List list = invenService.inven004_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}
	
	@RequestMapping(value = "/inven/inven009.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String inven009(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		searchMap.put("FIX_YN", "N");
		List<Map<String, Object>> yearList = invenService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);

		return "inven/inven009";
	}

}
