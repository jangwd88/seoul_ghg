package egovframework.seoul.dataManage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.seoul.entity.SpaceVO;

@SuppressWarnings("unused")
public interface DataManageService {
	
	@SuppressWarnings("rawtypes")
	List<Map<String, Object>> selectYearList(HashMap<String, Object> searchMap) throws Exception;

	List dataManage001_search(HashMap<String, Object> paraMap) throws Exception;

	List dataManage003_search(HashMap<String, Object> paraMap) throws Exception;

	String dataManage003_save(HashMap<String, Object> paraMap)throws Exception;

	List dataManage001_getCRFMonthData(HashMap<String, Object> paraMap) throws Exception;

	String dataManage001_saveMonth(HashMap<String, Object> paraMap) throws Exception;

	String dataManage002_close(HashMap<String, Object> paraMap) throws Exception;
	
	String dataManage002_closeCancel(HashMap<String, Object> paraMap) throws Exception;

	void dataManage001_execute(HashMap<String, Object> paraMap);

	void dataManage003_execute(HashMap<String, Object> paraMap);
	
}
