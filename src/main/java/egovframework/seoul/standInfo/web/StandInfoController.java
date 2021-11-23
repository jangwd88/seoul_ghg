package egovframework.seoul.standInfo.web;

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

import egovframework.seoul.standInfo.service.StandInfoService;
import egovframework.seoul.util.RequestUtil;
import lombok.extern.slf4j.Slf4j;
import twitter4j.JSONArray;

/**
 * 온실가스 지도
 * 
 * @author ghg 개발
 * @since 2020.11 ~ 2020.12
 *
 */

@Controller
@Slf4j
public class StandInfoController {

	@Autowired
	StandInfoService standInfoService;

	@RequestMapping(value = "/standInfo/standInfo001.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String standInfo001(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		List<Map<String, Object>> yearList = standInfoService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);

		return "standInfo/standInfo001";
	}

	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/standInfo/standInfo001_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String standInfo001_search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List list = standInfoService.standInfo001_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}
	
	

	
	@RequestMapping(value = "/standInfo/standInfo002.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String standInfo002(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		List<Map<String, Object>> yearList = standInfoService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);
		
		return "standInfo/standInfo002";
	}

	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/standInfo/standInfo002_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String standInfo002_search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List list = standInfoService.standInfo002_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}

	@RequestMapping(value = "/standInfo/standInfo003.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String standInfo003(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();

		List<Map<String, Object>> yearList = standInfoService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);
		
		List<Map<String, Object>> dataInfo = standInfoService.getDataInfo(searchMap);
		model.addAttribute("dataInfo", new JSONArray(dataInfo));
		
		return "standInfo/standInfo003";
	}

	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/standInfo/standInfo003_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String standInfo003_search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List list = standInfoService.standInfo003_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}
	
	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/standInfo/standInfo003_searchDetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String standInfo003_searchDetail(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		List list = standInfoService.standInfo003_searchDetail(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);
		
		return "json/response";
	}
	
	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/standInfo/standInfo003_searchDetailTalbe.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String standInfo003_searchDetailTalbe(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		List list = standInfoService.standInfo003_searchDetailTalbe(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);
		
		return "json/response";
	}
	
	@SuppressWarnings({ "rawtypes", "static-access" })
	@RequestMapping(value = "/standInfo/standInfo003_saveRow.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String standInfo003_saveRow(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		standInfoService.standInfo003_saveRow(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", "저장되었습니다.");
		
		return "json/response";
	}
	
	@RequestMapping(value = "/standInfo/standInfo004.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String standInfo004(@RequestParam Map<String, Object> requestMap, ModelMap model) throws Exception {
		HashMap<String, Object> searchMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> yearList = standInfoService.selectYearList(searchMap);
		model.addAttribute("yearList", yearList);
		
		List<Map<String, Object>> gubunList = standInfoService.selectGubunList(searchMap);
		model.addAttribute("gubunList", gubunList);
		
		
		
		return "standInfo/standInfo004";
	}
	
	@RequestMapping(value = "/standInfo/standInfo004_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String standInfo004_search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		List list = standInfoService.standInfo004_search(paraMap);

		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", list);

		return "json/response";
	}
	
	@RequestMapping(value = "/standInfo/standInfo004_getPreYearData.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String standInfo004_getPreYearData(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String msg = standInfoService.standInfo004_getPreYearData(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", msg);
		
		return "json/response";
	}
	
	@RequestMapping(value = "/standInfo/standInfo004_save.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String dataManage004_save(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String msg = standInfoService.standInfo004_save(paraMap);
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", msg);
		
		return "json/response";
	}
	
	@RequestMapping(value = "/standInfo/standInfo004_checkYearData.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String standInfo004_checkYearData(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		HashMap<String, Object> paraMap = new RequestUtil().paramToHashMap(request);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		List list = standInfoService.standInfo004_checkYearData(paraMap);
		String msg = "";
		if(list.size() == 0) {
			int checkCnt = standInfoService.standInfo004_insertYearData(paraMap);
			if(checkCnt > 0) {
				msg = (Integer.parseInt((String)paraMap.get("year")) + 1) + "년에 데이터가 등록되었습니다. 기준년도를 변경하고 조회해 주세요.";
			}
		} else {
			msg = (Integer.parseInt((String)paraMap.get("year")) + 1) + "년에는 등록된 데이터가 이미 있습니다. 기준년도를 변경하고 조회해 주세요.";
		}
		
		model.addAttribute("paramMap", paraMap);
		model.addAttribute("result", msg);
		
		return "json/response";
	}

}
