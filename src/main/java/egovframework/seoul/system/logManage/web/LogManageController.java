package egovframework.seoul.system.logManage.web;

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

import egovframework.seoul.system.logManage.service.LogManageService;

/**
 * 사용자 로그
 *
 * @author ghg 개발
 * @since 2020.11 ~ 2020.12
 *
 */

@Controller
@RequestMapping("/logManage")
@SuppressWarnings({"rawtypes", "unchecked"})
public class LogManageController {
	private static final Logger logger = LoggerFactory.getLogger(LogManageController.class);

	@Autowired
	LogManageService logManageService;

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

	/**
	 *
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping("/logManage.do")
	public String logManage(HttpServletRequest request, ModelMap model) throws Exception {
		Map paramMap = getParameterMap(request);

		// old 소스
//		ArrayList logInfo = logManageService.logInfo(paramMap);
//		model.addAttribute("paramMap", paramMap);
//		model.addAttribute("logInfo", logInfo);

		String pnoVal   = (String)paramMap.get("pno");
        pnoVal          = (pnoVal != null && pnoVal.trim().length() > 0) ? pnoVal.trim() : "1";

        // 페이징을 위한 기본 설정
		int  navsize    = 10;
        int  pageSize   = 15;
        int  pno        = 1;
        try {
            pno        = Integer.valueOf(pnoVal);
        }catch(Exception e) {
            logger.error(e.getMessage());
            pno        = 1;
        }

        // 조회조건 설정
        paramMap.put("pagesize",   pageSize);
        paramMap.put("pno",        pno);

		// 접속 로그 리스트 조회
		List accLogList = logManageService.listAccessLog(paramMap);
	    int  count      = logManageService.listAccessLogCount(paramMap);

		model.addAttribute("paramMap",   paramMap);
		model.addAttribute("accLogList", accLogList);

		// 페이징 공통에 적용될 값 설정
		model.addAttribute("count",      count);
		model.addAttribute("navsize",    navsize);
		model.addAttribute("pagesize",   pageSize);
		model.addAttribute("pno",        pno);

		return "logManage/logManage";
	}


}
