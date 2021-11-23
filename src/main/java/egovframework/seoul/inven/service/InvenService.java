package egovframework.seoul.inven.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import egovframework.seoul.entity.SpaceVO;

@SuppressWarnings("unused")
public interface InvenService {

	@SuppressWarnings("rawtypes")
	List inven001_search(HashMap<String, Object> searchMap) throws Exception;

	@SuppressWarnings("rawtypes")
	List inven002_search(HashMap<String, Object> paraMap) throws Exception;

	@SuppressWarnings("rawtypes")
	List inven003_search(HashMap<String, Object> paraMap) throws Exception;

	@SuppressWarnings("rawtypes")
	List inven004_search(HashMap<String, Object> paraMap) throws Exception;

	List<Map<String, Object>> selectYearList(HashMap<String, Object> searchMap);

	List<Map<String, Object>> selectMinMaxYear(HashMap<String, Object> searchMap);

	List<Map<String, Object>> inven001_search_chart(HashMap<String, Object> paraMap) throws Exception;

	String inven001_saveIMage(Map<String, MultipartFile> files, Map<String, Object> loginInfo, String type) throws IllegalStateException, IOException;
}
