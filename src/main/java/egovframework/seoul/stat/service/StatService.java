package egovframework.seoul.stat.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface StatService {

	List<Map<String, Object>> getCode(HashMap<String, Object> searchMap);

	List<Map<String, Object>> stat001_search(HashMap<String, Object> paraMap) throws Exception;

	List<Map<String, Object>> stat002_search(HashMap<String, Object> paraMap) throws Exception;

	List<Map<String, Object>> stat002_getBjdong(HashMap<String, Object> paraMap) throws Exception;

	Map<String, Object> selectMinMaxYear(HashMap<String, Object> searchMap) throws Exception;

	List<Map<String, Object>> stat003_getBuildingList(HashMap<String, Object> paraMap) throws Exception;

	List<Map<String, Object>> stat003_search(HashMap<String, Object> paraMap) throws Exception;

	String stat003_saveBuilding(HashMap<String, Object> paraMap) throws Exception;

	String stat003_deleteBuilding(HashMap<String, Object> paraMap) throws Exception;

}
