package egovframework.seoul.system.userManage.service;

import java.util.List;
import java.util.Map;

public interface UserManageService {

	List<Map<String, Object>> userManage_search(Map<String, Object> paraMap) throws Exception;

	List<Map<String, Object>> selectOfficerCodeList();

	int userManage_create(Map<String, Object> paraMap) throws Exception;

	int userManage_delete(Map<String, Object> paraMap);

	int userManage_update(Map<String, Object> paraMap);

	int userManage_initPassword(Map<String, Object> paraMap) throws Exception;

}
