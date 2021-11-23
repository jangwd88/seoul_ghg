package egovframework.seoul.space.web;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.seoul.space.service.SpaceService;
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
public class SpaceController {
	
	private static final Logger logger = LoggerFactory.getLogger(SpaceController.class);
	@Autowired
	SpaceService spaceService;

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

	@RequestMapping("/space/selectArch.do")
	public String selectArch(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);
		model.addAttribute("paramMap", paramMap);
		return "space/selectArch";
	}
	
	@RequestMapping("/space/listEmd.do")
    public String listEmd(HttpServletRequest request, ModelMap model)
    throws Exception {
		
		HashMap paramMap = getParameterMap(request);
		
		ArrayList listEmd = spaceService.listEmd(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listEmd);
		
		return "json/response";
    }
	
	@RequestMapping("/space/listAdminHjCode.do")
    public String listAdminHjCode(HttpServletRequest request, ModelMap model)
    throws Exception {
		
		HashMap paramMap = getParameterMap(request);
		
		ArrayList listAdminHjCode = spaceService.listAdminHjCode(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listAdminHjCode);
		
		return "json/response";
    }
	
	@RequestMapping("/space/getAdminCoord.do")
    public String getAdminCoord(HttpServletRequest request, ModelMap model)
    throws Exception {
		
		HashMap paramMap = getParameterMap(request);
		
		HashMap getAdminCoord = spaceService.getAdminCoord(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", getAdminCoord);
		
		return "json/response";
    }
	
	@RequestMapping("/space/listMgmBldPk.do")
    public String listMgmBldPk(HttpServletRequest request, ModelMap model)
    throws Exception {
		
		HashMap paramMap = getParameterMap(request);
		
		ArrayList listMgmBldPk = spaceService.listMgmBldPk(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listMgmBldPk);
		
		return "json/response";
    }
	
	@RequestMapping("/space/listBuildInfo.do")
    public String listBuildInfo(HttpServletRequest request, ModelMap model)
    throws Exception {
		
		HashMap paramMap = getParameterMap(request);
		
		HashMap viewBuildInfo = spaceService.viewBuildInfo(paramMap);
		ArrayList listBuildInfo = spaceService.listBuildInfo(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listBuildInfo);
		
		return "json/response";
    }
	
	@RequestMapping("/space/viewBuildInfo.do")
    public String viewBuildInfo(HttpServletRequest request, ModelMap model)
    throws Exception {
		
		HashMap paramMap = getParameterMap(request);
		
		HashMap viewBuildInfo = spaceService.viewBuildInfo(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", viewBuildInfo);
		
		return "json/response";
    }
	
	@RequestMapping("/space/listBuildEnergyInfo.do")
    public String listBuildEnergyInfo(HttpServletRequest request, ModelMap model)
    throws Exception {
		
		HashMap paramMap = getParameterMap(request);
		
		ArrayList listBuildEnergyInfo = spaceService.listBuildEnergyInfo(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listBuildEnergyInfo);
		
		return "json/response";
    }
	
	@RequestMapping("/space/listSameJusoBuild.do")
    public String listSameJusoBuild(HttpServletRequest request, ModelMap model)
    throws Exception {
		
		HashMap paramMap = getParameterMap(request);
		
		ArrayList listSameJusoBuild = spaceService.listSameJusoBuild(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listSameJusoBuild);
		
		return "json/response";
    }
	
	@RequestMapping("/space/selectArchList.do")
    public String selectArchList(HttpServletRequest request, ModelMap model)
    throws Exception {
		
		HashMap paramMap = getParameterMap(request);
    	
		String[] arr_main_purps_cd = request.getParameterValues("arr_main_purps_cd[]");
		List<String> codeList = new ArrayList<String>();

		if(arr_main_purps_cd != null) {
			for (int i = 0; i < arr_main_purps_cd.length; i++) {
				codeList.add(arr_main_purps_cd[i]);
			}
		    paramMap.put("codeList", codeList);
		}

		ArrayList listArch = spaceService.selectArchList(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("listArch", listArch);
		
		return "space/selectArchHtml";
    }
	
	@RequestMapping("/space/listArch.do")
    public String listArch(HttpServletRequest request, ModelMap model)
    throws Exception {
		
		HashMap paramMap = getParameterMap(request);
    	
		String[] arr_main_purps_cd = request.getParameterValues("arr_main_purps_cd[]");
		List<String> codeList = new ArrayList<String>();

		if(arr_main_purps_cd != null) {
			for (int i = 0; i < arr_main_purps_cd.length; i++) {
				codeList.add(arr_main_purps_cd[i]);
			}
		    paramMap.put("codeList", codeList);
		}

		ArrayList listArch = spaceService.listArch(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listArch);
		
		return "json/response";
    }
	
	@RequestMapping("/space/selectDistrict.do")
	public String selectDistrict(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);
		model.addAttribute("paramMap", paramMap);
		return "space/selectDistrict";
	}
	
	@RequestMapping("/space/selectDistrictList.do")
    public String openDistrictLocation(HttpServletRequest request, ModelMap model)
    throws Exception {
		
		HashMap paramMap = getParameterMap(request);
    	
		ArrayList listArch = spaceService.selectDistrictList(paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("listArch", listArch);
		
		return "space/selectDistrictHtml";
    }
	
	@RequestMapping("/space/selectDetail.do")
	public String selectDetail(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);
		model.addAttribute("paramMap", paramMap);
		return "space/selectDetail";
	}
	
	@RequestMapping("/space/listJuso.do")
	public String listJuso(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);

		ArrayList listJuso = spaceService.listJuso(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listJuso);
		return "json/response";
	}
	
	@RequestMapping("/space/listBuildInfoByJuso.do")
	public String listBuildInfoByJuso(HttpServletRequest request, ModelMap model) throws Exception {

		HashMap paramMap = getParameterMap(request);

		ArrayList listBuildInfoByJuso = spaceService.listBuildInfoByJuso(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listBuildInfoByJuso);

		return "json/response";
	}
	
	@RequestMapping("/space/viewBuildInfoByMgmBldPk.do")
	public String viewBuildInfoByMgmBldPk(HttpServletRequest request, ModelMap model) throws Exception {

		HashMap paramMap = getParameterMap(request);

		HashMap viewBuildInfoByMgmBldPk = spaceService.viewBuildInfoByMgmBldPk(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", viewBuildInfoByMgmBldPk);

		return "json/response";
	}
	
	@RequestMapping("/space/listBuildEnergyInfoByMonth.do")
	public String listBuildEnergyInfoByMonth(HttpServletRequest request, ModelMap model) throws Exception {

		HashMap paramMap = getParameterMap(request);

		ArrayList listBuildEnergyInfoByMonth = spaceService.listBuildEnergyInfoByMonth(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", listBuildEnergyInfoByMonth);

		return "json/response";
	}
	
	@RequestMapping("/space/viewJusoInfo.do")
	public String viewJusoInfo(HttpServletRequest request, ModelMap model) throws Exception {

		HashMap paramMap = getParameterMap(request);

		ArrayList viewJusoInfo = spaceService.viewJusoInfo(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", viewJusoInfo);

		return "json/response";
	}
	
	
	@RequestMapping("/space/fnViewBuildByInfoMainPurpsNm.do")
	public String fnViewBuildByInfoMainPurpsNm(HttpServletRequest request, ModelMap model) throws Exception	{
	
		HashMap paramMap = getParameterMap(request);
		
		HashMap fnViewBuildByInfoMainPurpsNm = spaceService.fnViewBuildByInfoMainPurpsNm();

		System.out.println(fnViewBuildByInfoMainPurpsNm);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", fnViewBuildByInfoMainPurpsNm.get(paramMap.get("main_purps_code")));
		
		return "json/response";
	}
	
	
	@RequestMapping("/individual/openIndividual.do")
	public String openIndividual(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);
		model.addAttribute("paramMap", paramMap);
		return "individual/openIndividual";
	}
	
	@RequestMapping("/individual/checkUserLikeBuild.do")
	public String checkUserLikeBuild(HttpServletRequest request, ModelMap model) throws Exception {

		HashMap paramMap = getParameterMap(request);
		
		Integer count = spaceService.checkUserLikeBuild(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", count);

		return "json/response";
	}
	
	@RequestMapping("/individual/setUserLikeBuild.do")
	public String setUserLikeBuild(HttpServletRequest request, ModelMap model) throws Exception {

		HashMap paramMap = getParameterMap(request);

		spaceService.setUserLikeBuild(paramMap);

		model.addAttribute("paramMap", paramMap);
		model.addAttribute("result", paramMap.get("userLikeBuildStatus"));

		return "json/response";
	}
	
	@RequestMapping("/individual/selectListUserLikeBuild.do")
	public String selectListUserLikeBuild(HttpServletRequest request, ModelMap model)throws Exception {
		
		HashMap paramMap = getParameterMap(request);
		
		ArrayList selectListUserLikeBuild = spaceService.selectListUserLikeBuild(paramMap);
	
		
		model.addAttribute("paramMap",paramMap);
		model.addAttribute("result",selectListUserLikeBuild);
		return "json/response";
	}
	
	
}
