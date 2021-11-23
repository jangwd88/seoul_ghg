package egovframework.seoul.system.codeManage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CodeManageService {

	List<Map<String, Object>> masterCodeData(HashMap<String, Object> searchMap) throws Exception;

	List<Map<String, Object>> detailCodeData(HashMap<String, Object> searchMap) throws Exception;

	String addNUpdateCodeMaster(HashMap<String, Object> paraMap) throws Exception;

	String addNUpdateCodeDetail(HashMap<String, Object> paraMap) throws Exception;

	String deleteCodeMaster(HashMap<String, Object> paraMap) throws Exception;

	String deleteCodeDetail(HashMap<String, Object> paraMap) throws Exception;
}
