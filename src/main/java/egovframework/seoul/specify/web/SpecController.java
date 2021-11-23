package egovframework.seoul.specify.web;

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
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.seoul.specify.service.SpecService;

/**
 * 건물 온실가스 총량제
 * 
 * @author ghg 개발
 * @since 2020.11 ~ 2020.12
 *
 */

@Controller
@RequestMapping("/spec")
public class SpecController {

	private static final Logger logger = LoggerFactory.getLogger(SpecController.class);

	@Autowired
	SpecService specService;

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

	@RequestMapping("/specArch.do")
	public String specArch(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);

		paramMap.put("energy_target", "target_first");
		
		ArrayList listOfficer = specService.listOfficer(paramMap);
		ArrayList listCons = specService.listCons(paramMap);
		model.addAttribute("listOfficer", listOfficer);
		model.addAttribute("listCons", listCons);

		return "spec/specArch";
	}

	@RequestMapping("/listEmd.do")
	public String listEmd(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);

		ArrayList listEmd = specService.listEmd(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listEmd);

		return "json/response";
	}

	@RequestMapping("/specArchList.do")
	public String specArchList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request,
			ModelMap model) throws Exception {

		HashMap paramMap = getParameterMap(request);
		String conditionFlag = paramMap.get("conditionFlag").toString();
		
		if(!"all".equals(conditionFlag)) {
			String[] arr_condition = request.getParameterValues("arr_condition[]");
			List<String> codeList = new ArrayList<String>();
			for (int i = 0; i < arr_condition.length; i++) {
				codeList.add(arr_condition[i]);
			}
			paramMap.put("codeList", codeList);
		}

		paramMap.put("requestMap", requestMap);

		ArrayList listArch = specService.specArchList(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("listArch", listArch);

		return "spec/specArchHtml";
	}

	@RequestMapping("/listSpecArch.do")
	public String listSpecArch(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);
		String conditionFlag = paramMap.get("conditionFlag").toString();
		
		if(!"all".equals(conditionFlag)) {
			String[] arr_condition = request.getParameterValues("arr_condition[]");
			List<String> codeList = new ArrayList<String>();
			for (int i = 0; i < arr_condition.length; i++) {
				codeList.add(arr_condition[i]);
			}
			paramMap.put("codeList", codeList);
		}
		
		ArrayList listSpecArch = specService.listSpecArch(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listSpecArch);

		return "json/response";
	}
	
	@RequestMapping("/specOfficerList.do")
	public String listOfficerSearch(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);

		ArrayList listOfficer = specService.selectOfficerList(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listOfficer);

		return "json/response";
	}

	@RequestMapping("/specConsList.do")
	public String listConsSearch(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);

		ArrayList listCons = specService.selectConsList(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listCons);

		return "json/response";
	}

	@RequestMapping("/listCons.do")
	public String listCons(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);

		ArrayList listCons = specService.listCons(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listCons);

		return "json/response";
	}

	@RequestMapping("/openTotalTargetMgmt.do")
	public String openTotalTargetMgmt(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);
		model.addAttribute("paramMap", paramMap);

		return "spec/openTotalTargetMgmt";
	}
	
	@RequestMapping("/getTotalAmtTarget.do")
	public String getTtlAmtTargt(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);

		HashMap getTtlAmtTargt = specService.getTotalAmtTarget(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", getTtlAmtTargt);

		return "json/response";
	}
	
	@RequestMapping("/updtTotalAmtTarget.do")
	public String updtTtlAmtTargt(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);

		specService.updtTotalAmtTarget(paramMap);

		model.addAttribute("paramMap", paramMap);

		return "json/response";
	}
	
	
}
