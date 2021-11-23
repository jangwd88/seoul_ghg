package egovframework.seoul.invenCal.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.seoul.entity.SpaceVO;

@SuppressWarnings("unused")
public interface InvenCalService {

	@SuppressWarnings("rawtypes")
	List invenCal001_search(HashMap<String, Object> searchMap) throws Exception;

	@SuppressWarnings("rawtypes")
	List invenCal002_search(HashMap<String, Object> paraMap) throws Exception;

	@SuppressWarnings("rawtypes")
	List invenCal003_search(HashMap<String, Object> paraMap) throws Exception;

	List<Map<String, Object>> selectYearList(HashMap<String, Object> searchMap);

}
