package egovframework.seoul.bbs.web;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import egovframework.seoul.bbs.service.BbsMapper;
import egovframework.seoul.bbs.service.BbsService;
import egovframework.seoul.entity.BbsVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 공지사항
 * 
 * @author ghg 개발
 * @since 2020.11 ~ 2020.12
 *
 */

@Slf4j
@Controller
@RequestMapping("/bbs")
public class BbsController {
	@Autowired
	BbsService bbsService;

	@Autowired
	BbsMapper bbsMapper;

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

	// 게시글 목록
	@RequestMapping(value = "/list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String list(HttpServletRequest req, HttpServletResponse resp, Model model) throws Exception {
		int pagesize = 10;
		int navsize = 10;
		int pno;
		try {
			pno = Integer.parseInt(req.getParameter("pno"));
			if (pno <= 0)
				throw new Exception();
		} catch (Exception e) {
			pno = 1;
		}
		int finish = pno * pagesize;
		int start = finish - (pagesize - 1);

		String type = req.getParameter("type");
		String keyword = req.getParameter("keyword");

		boolean isSearch = type != null && keyword != null;

		List<BbsVO> list;

		if (isSearch) {
			list = bbsService.listAll(type, keyword, start, finish);
		} else {
			list = bbsService.getList(start, finish);
		}
		int count = bbsService.getCount(type, keyword);

		// 뷰에서 필요한 데이터를 첨부(5개)
		// System.out.println(list.size());
		model.addAttribute("pno", pno);
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("pagesize", pagesize);
		model.addAttribute("navsize", navsize);
		return "bbs/list";
	}

	// 게시글 작성 화면
	@RequestMapping(value = "/write.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String write() {
		return "bbs/write";
	}

	// 게시글 작성 처리
	@RequestMapping("/insertBbs.do")
	public String insertBbs(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);
		bbsService.insertBbs(paramMap);
		return "redirect:/bbs/list.do";
	}

	// 게시글 상세내용 조회
	@GetMapping("/view.do")
	public String view(@RequestParam int bbs_no, Model model) throws Exception {
		model.addAttribute("bbsVO", bbsService.read(bbs_no));
		return "bbs/view";
	}

	// 게시글 수정
	@GetMapping("/update.do")
	public String update(@RequestParam int bbs_no, Model model) throws Exception {
		BbsVO view = bbsService.read(bbs_no);
		model.addAttribute("bbsVO", view);
		return "bbs/update";
	}

	// 게시글 수정 처리
	@RequestMapping("/procUpdate.do")
	public String procUpdate(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap paramMap = getParameterMap(request);
		bbsService.procUpdate(paramMap);
		model.addAttribute("paramMap", paramMap);
		return "redirect:/bbs/list.do";
	}

	// 게시글 삭제
	@RequestMapping("/delete.do")
	public String delete(@RequestParam int bbs_no) throws Exception {
		bbsService.delete(bbs_no);
		return "redirect:/bbs/list.do";
	}
}