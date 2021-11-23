package egovframework.seoul.dash.web;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.seoul.dash.service.DashService;
import egovframework.seoul.inven.service.InvenService;

/**
 * 대시보드
 * 
 * @author ghg 개발
 * @since 2020.11 ~ 2020.12
 *
 */

@Controller
@RequestMapping("/dash")
public class DashController {
	
	private static final Logger logger = LoggerFactory.getLogger(DashController.class);

	@Autowired
	DashService dashService;
	
	@Autowired
	InvenService invenService;
	
	public HttpServletRequest request = null;

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	protected HashMap getParameterMap(HttpServletRequest req) {
		setRequest(req);

		HashMap map = new HashMap();

		Enumeration enm = req.getParameterNames();

		String name = null;
		String value = null;
		String[] arr = null;

		while (enm.hasMoreElements()) {
			name = (String) enm.nextElement();
			arr = req.getParameterValues(name);

			if (name.startsWith("arr")) {
				map.put(name, arr);
			} else {
				if (arr != null && arr.length > 0) {
					value = arr[0];
				} else {
					value = req.getParameter(name);
				}

				map.put(name, value);
			}
		}

		return map;
	}
	
	@RequestMapping("/dashCurrent.do")
	public String dashCurrent(HttpServletRequest request, ModelMap model) { 
		HashMap paramMap = getParameterMap(request);
		
		model.addAttribute("paramMap", paramMap);
		return "dash/dashCurrent";
	}
	
	@RequestMapping("/dashCurrentSub.do")
	public String dashCurrentSub(HttpServletRequest request, ModelMap model) { 
		HashMap paramMap = getParameterMap(request);
		
		model.addAttribute("paramMap", paramMap);
		return "dash/dashCurrentSub";
	}
	
	@RequestMapping("/listBuildEnergyInfoByMonth.do")
	public String listBuildEnergyInfoByMonth(HttpServletRequest request, ModelMap model) throws Exception {

		HashMap paramMap = getParameterMap(request);
		ArrayList listBuildEnergyInfoByMonth = dashService.dashBoardListInfo(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listBuildEnergyInfoByMonth);

		return "json/response";
	}
	
	@RequestMapping("/selectFacilInfo.do")
	public String selectFacilInfo(HttpServletRequest request, ModelMap model) throws Exception {

		HashMap paramMap = getParameterMap(request);	
		HashMap faciliInfo = dashService.dashBoardFacilityInfo(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", faciliInfo);

		return "json/response";
	}
	
	/*
	@RequestMapping("/listSeoulOwnTarget1.do")
	public String listSeoulOwnTarget1(HttpServletRequest request, ModelMap model) { 
		HashMap paramMap = getParameterMap(request);
		
		ArrayList listSeoulOwnTarget1 = dashService.listSeoulOwnTarget1(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listSeoulOwnTarget1);
		
		return "json/response";
	}
	
	@RequestMapping("/nextViewSeoulOwnTarget1.do")
	public String nextViewSeoulOwnTarget1(HttpServletRequest request, ModelMap model) { 
		HashMap paramMap = getParameterMap(request);
		
		HashMap nextViewSeoulOwnTarget1 = dashService.nextViewSeoulOwnTarget1(paramMap);
		paramMap.put("target_num", nextViewSeoulOwnTarget1.get("target_num"));
		dashService.updtNextSeoulOwnTarget1(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", nextViewSeoulOwnTarget1);
		
		return "json/response";
	}
	
	@RequestMapping("/viewSeoulOwnTarget1.do")
	public String viewSeoulOwnTarget1(HttpServletRequest request, ModelMap model) { 
		HashMap paramMap = getParameterMap(request);
		
		HashMap viewSeoulOwnTarget1 = dashService.viewSeoulOwnTarget1(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", viewSeoulOwnTarget1);
		
		return "json/response";
	}
	
	@RequestMapping("/listSeoulOwnTarget1EnergyLedger.do")
	public String listSeoulOwnTarget1EnergyLedger(HttpServletRequest request, ModelMap model) { 
		HashMap paramMap = getParameterMap(request);
		
		ArrayList listSeoulOwnTarget1EnergyLedger = dashService.listSeoulOwnTarget1EnergyLedger(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listSeoulOwnTarget1EnergyLedger);
		
		return "json/response";
	}*/
	
	/*총량제 대상 대시보드*/
	@RequestMapping("/spec/dashboard.do")
	public String specDashBoard(HttpServletRequest request, ModelMap model) {
		HashMap paramMap = getParameterMap(request);
		
		model.addAttribute("paramMap", paramMap);
		return "dash/spec/dashboard";
	}
	
	@RequestMapping("/spec/seoul/own/target/1.do")
	public String specDashboardSeoulOwnTarget1(HttpServletRequest request, ModelMap model) {
		HashMap paramMap = getParameterMap(request);
		
		ArrayList specDashboardSeoulOwnTarget1 = dashService.specDashboardSeoulOwnTarget1(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", specDashboardSeoulOwnTarget1);
		
		return "json/response";
	}
	

	/* 인벤토리 대시보드*/
	@RequestMapping("/inven/current.do")
	public String invenDashBoard(HttpServletRequest request, ModelMap model) {
		HashMap paramMap = getParameterMap(request);
		
		paramMap.put("FIX_YN", "N");
		List<Map<String, Object>> yearList = invenService.selectYearList(paramMap);
		model.addAttribute("yearList", yearList);
		
		model.addAttribute("paramMap", paramMap);
		
		return "dash/inven/current";
	}
	
}
