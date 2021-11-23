package egovframework.seoul.stat.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.seoul.stat.service.StatService;
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
public class StatController {

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(StatController.class);

	@Autowired
	StatService statService;

	@RequestMapping(value = "/stat/stat001.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String stat001(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		/* 에너지원 */
		searchMap.put("S_CAT", "ENERGY_TYPE");
		List<Map<String, Object>> ENERGY_TYPE = statService.getCode(searchMap);
		model.addAttribute("ENERGY_TYPE", ENERGY_TYPE);

		/* 용도 */
		searchMap.put("S_CAT", "PURPS");
		List<Map<String, Object>> PURPS = statService.getCode(searchMap);
		model.addAttribute("PURPS", PURPS);

		/* 규모 */
		/*searchMap.put("S_CAT", "TOTAREA");
		List<Map<String, Object>> TOTAREA = statService.getCode(searchMap);
		model.addAttribute("TOTAREA", TOTAREA);*/

		/* 노후도 */
		/*searchMap.put("S_CAT", "PERMISSION");
		List<Map<String, Object>> PERMISSION = statService.getCode(searchMap);
		model.addAttribute("PERMISSION", PERMISSION);*/

		/* 조회기간 년 */
		searchMap.put("S_CAT", "YYYY");
		List<Map<String, Object>> YYYY = statService.getCode(searchMap);
		model.addAttribute("YYYY", YYYY);

		/* 조회기간 월 */
		searchMap.put("S_CAT", "MM");
		List<Map<String, Object>> MM = statService.getCode(searchMap);
		model.addAttribute("MM", MM);

		/* 조회단위 */
		searchMap.put("S_CAT", "ACU");
		List<Map<String, Object>> ACU = statService.getCode(searchMap);
		model.addAttribute("ACU", ACU);

		Map<String, Object> minMaxYear = statService.selectMinMaxYear(searchMap);
		model.addAttribute("minMaxYear", minMaxYear);

		return "stat/stat001";
	}

	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/stat/stat001_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String stat001_search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List<Map<String, Object>> list = statService.stat001_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}

	@RequestMapping(value = "/stat/stat002.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String stat002(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();
		/* 에너지원 */
		searchMap.put("S_CAT", "ENERGY_TYPE");
		List<Map<String, Object>> ENERGY_TYPE = statService.getCode(searchMap);
		model.addAttribute("ENERGY_TYPE", ENERGY_TYPE);

		/* 자치구 */
		searchMap.put("S_CAT", "SIGUNGU");
		List<Map<String, Object>> SIGUNGU = statService.getCode(searchMap);
		model.addAttribute("SIGUNGU", SIGUNGU);

		/*
		 * 법정동 삭제 : 김경욱
		 */
		/*
		 * searchMap.put("S_CAT", "BJDONG"); List BJDONG =
		 * statService.getCode(searchMap); model.addAttribute("BJDONG", BJDONG);
		 */

		/* 조회기간 년 */
		searchMap.put("S_CAT", "YYYY");
		List<Map<String, Object>> YYYY = statService.getCode(searchMap);
		model.addAttribute("YYYY", YYYY);

		/* 조회기간 월 */
		searchMap.put("S_CAT", "MM");
		List<Map<String, Object>> MM = statService.getCode(searchMap);
		model.addAttribute("MM", MM);

		/* 조회단위 */
		searchMap.put("S_CAT", "ACU");
		List<Map<String, Object>> ACU = statService.getCode(searchMap);
		model.addAttribute("ACU", ACU);

		Map<String, Object> minMaxYear = statService.selectMinMaxYear(searchMap);
		model.addAttribute("minMaxYear", minMaxYear);

		return "stat/stat002";
	}

	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/stat/stat002_getBjdong.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String stat002_getBjdong(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List<Map<String, Object>> list = statService.stat002_getBjdong(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}

	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/stat/stat002_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String stat002_search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List<Map<String, Object>> list = statService.stat002_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}

	@RequestMapping(value = "/stat/stat003.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String stat003(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();
		/* 조회기간 년 */
		searchMap.put("S_CAT", "YYYY");
		List<Map<String, Object>> YYYY = statService.getCode(searchMap);
		model.addAttribute("YYYY", YYYY);

		/* 조회기간 월 */
		searchMap.put("S_CAT", "MM");
		List<Map<String, Object>> MM = statService.getCode(searchMap);
		model.addAttribute("MM", MM);

		/* 조회단위 */
		/*searchMap.put("S_CAT", "ACU");
		List<Map<String, Object>> ACU = statService.getCode(searchMap);
		model.addAttribute("ACU", ACU);*/

		return "stat/stat003";
	}

	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/stat/stat003_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String stat003_search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List<Map<String, Object>> list = statService.stat003_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}

	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/stat/stat003_saveBuilding.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String stat003_saveBuilding(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String msg = statService.stat003_saveBuilding(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", msg);

		return "json/response";
	}
	
	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/stat/stat003_deleteBuilding.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String stat003_deleteBuilding(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String msg = statService.stat003_deleteBuilding(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", msg);
		
		return "json/response";
	}

	@SuppressWarnings({ "static-access" })
	@RequestMapping(value = "/stat/stat003_getBuildingList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String stat003_getBuildingList(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List<Map<String, Object>> list = statService.stat003_getBuildingList(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}

}
