package egovframework.seoul.invenCal.web;

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

import egovframework.seoul.invenCal.service.InvenCalService;
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
public class InvenCalController {

	@Autowired
	InvenCalService invenCalService;

	@RequestMapping(value = "/invenCal/invenCal001.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String invenCal001(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		List<Map<String, Object>> yearList = invenCalService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);

		return "invenCal/invenCal001";
	}

	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/invenCal/invenCal001_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String invenCal001_search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List list = invenCalService.invenCal001_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}

	@RequestMapping(value = "/invenCal/invenCal002.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String invenCal002(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		List<Map<String, Object>> yearList = invenCalService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);

		return "invenCal/invenCal002";
	}

	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/invenCal/invenCal002_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String invenCal002_search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List list = invenCalService.invenCal002_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}

	@RequestMapping(value = "/invenCal/invenCal003.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String invenCal003(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		List<Map<String, Object>> yearList = invenCalService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);

		return "invenCal/invenCal003";
	}

	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/invenCal/invenCal003_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String invenCal003_search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List list = invenCalService.invenCal003_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}

}
