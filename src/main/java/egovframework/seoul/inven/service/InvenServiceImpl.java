package egovframework.seoul.inven.service;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.seoul.cmmn.util.EgovWebUtil;

@Service
@Repository
public class InvenServiceImpl implements InvenService {

	private static final Logger logger = LoggerFactory.getLogger(InvenServiceImpl.class);

	@Autowired
	InvenMapper invenMapper;

	@SuppressWarnings("rawtypes")
	@Override
	public List inven001_search(HashMap<String, Object> searchMap) throws Exception {
		String gridDataArr = searchMap.get("util") == null ? "" : (String) searchMap.get("util");
		List<String> list = Arrays.asList(gridDataArr.split(","));
		searchMap.put("utilList", list);

		return invenMapper.inven001_search(searchMap);
	}

	@Override
	public List<Map<String, Object>> inven001_search_chart(HashMap<String, Object> paraMap) throws Exception {
		String gridDataArr = paraMap.get("util") == null ? "" : (String) paraMap.get("util");
		List<String> list = Arrays.asList(gridDataArr.split(","));
		paraMap.put("utilList", list);

		return invenMapper.inven001_search_chart(paraMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List inven002_search(HashMap<String, Object> paraMap) throws Exception {
		String gridDataArr = paraMap.get("util") == null ? "" : (String) paraMap.get("util");
		List<String> list = Arrays.asList(gridDataArr.split(","));
		paraMap.put("utilList", list);

		return invenMapper.inven002_search(paraMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List inven003_search(HashMap<String, Object> paraMap) throws Exception {
		String gridDataArr = paraMap.get("util") == null ? "" : (String) paraMap.get("util");
		List<String> list = Arrays.asList(gridDataArr.split(","));
		paraMap.put("utilList", list);

		return invenMapper.inven003_search(paraMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List inven004_search(HashMap<String, Object> paraMap) throws Exception {
		String gridDataArr = paraMap.get("util") == null ? "" : (String) paraMap.get("util");
		List<String> list = Arrays.asList(gridDataArr.split(","));
		paraMap.put("utilList", list);

		return invenMapper.inven004_search(paraMap);
	}

	@Override
	public List<Map<String, Object>> selectYearList(HashMap<String, Object> searchMap) {
		return invenMapper.selectYearList(searchMap);
	}

	@Override
	public List<Map<String, Object>> selectMinMaxYear(HashMap<String, Object> searchMap) {
		return invenMapper.selectMinMaxYear(searchMap);
	}

	@Override
	public String inven001_saveIMage(Map<String, MultipartFile> files, Map<String, Object> loginInfo, String type)
			throws IllegalStateException, IOException {
		String storePathString = "/seoul_m/upload/ai65/temp";

		File saveFolder = new File(EgovWebUtil.filePathBlackList(storePathString));
		if (!saveFolder.exists() || saveFolder.isFile()) {
			// 2017.02.07 이정은 시큐어코딩(ES)-부적절한 예외 처리[CWE-253, CWE-440, CWE-754]
			if (saveFolder.mkdirs()) {
				logger.debug("[file.mkdirs] saveFolder : Creation Success ");
			} else {
				logger.error("[file.mkdirs] saveFolder : Creation Fail ");
			}
		}

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		String filePath = "";

		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			file = entry.getValue();
			String orginFileName = file.getOriginalFilename();

			// --------------------------------------
			// 원 파일명이 없는 경우 처리
			// (첨부가 되지 않은 input file type)
			// --------------------------------------
			if ("".equals(orginFileName)) {
				continue;
			}
			//// ------------------------------------

			int index = orginFileName.lastIndexOf(".");
			// String fileName = orginFileName.substring(0, index);
			String fileExt = orginFileName.substring(index + 1);

			String newName = loginInfo.get("ADMIN_ID") + "_" + type + "_" + getTimeStamp();
			long size = file.getSize();

			if (!"".equals(orginFileName)) {
				// 2017.02.07 이정은 시큐어코딩(ES)-경로 조작 및 자원 삽입[CWE-22, CWE-23, CWE-95, CWE-99]
				newName = EgovWebUtil.fileInjectPathReplaceAll(newName);
				filePath = storePathString + File.separator + newName + ".png";
				file.transferTo(new File(EgovWebUtil.filePathBlackList(filePath)));
			}
		}
		return "SUCCESS";
	}

	private static String getTimeStamp() {

		String rtnStr = null;

		// 문자열로 변환하기 위한 패턴 설정(년도-월-일 시:분:초:초(자정이후 초))
		String pattern = "MMddHHmmss";

		SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
		Timestamp ts = new Timestamp(System.currentTimeMillis());

		rtnStr = sdfCurrent.format(ts.getTime());

		return rtnStr;
	}

}
