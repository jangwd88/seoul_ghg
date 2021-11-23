package egovframework.seoul.standInfo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.seoul.entity.SpaceVO;

@SuppressWarnings("unused")
public interface StandInfoService {

	@SuppressWarnings("rawtypes")
	List standInfo001_search(HashMap<String, Object> searchMap) throws Exception;

	@SuppressWarnings("rawtypes")
	List standInfo002_search(HashMap<String, Object> paraMap) throws Exception;

	@SuppressWarnings("rawtypes")
	List standInfo003_search(HashMap<String, Object> paraMap) throws Exception;

	List<Map<String, Object>> selectYearList(HashMap<String, Object> searchMap) throws Exception;

	List standInfo003_searchDetail(HashMap<String, Object> paraMap) throws Exception;

	List standInfo003_searchDetailTalbe(HashMap<String, Object> paraMap) throws Exception;

	List<Map<String, Object>> selectGubunList(HashMap<String, Object> searchMap) throws Exception;

	List standInfo004_search(HashMap<String, Object> paraMap) throws Exception;

	String standInfo004_getPreYearData(HashMap<String, Object> paraMap) throws Exception;

	List<Map<String, Object>> getDataInfo(HashMap<String, Object> searchMap) throws Exception;

	void standInfo003_saveRow(HashMap<String, Object> paraMap) throws Exception;

	String standInfo004_save(HashMap<String, Object> paraMap) throws Exception;

	int standInfo004_insertYearData(HashMap<String, Object> paraMap);

	List standInfo004_checkYearData(HashMap<String, Object> paraMap);

}
