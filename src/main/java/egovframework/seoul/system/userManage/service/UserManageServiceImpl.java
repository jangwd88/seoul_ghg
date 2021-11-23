package egovframework.seoul.system.userManage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import egovframework.seoul.cmmn.service.EgovFileScrty;

@Service
@Repository
public class UserManageServiceImpl implements UserManageService {

	@Autowired
	UserManageMapper userManageMapper;

	@Override
	public List<Map<String, Object>> userManage_search(Map<String, Object> paraMap) throws Exception {
		return userManageMapper.userManage_search(paraMap);
	}

	@Override
	public List<Map<String, Object>> selectOfficerCodeList() {
		return userManageMapper.selectOfficerCodeList();
	}

	@Override
	public int userManage_create(Map<String, Object> paraMap) throws Exception {
		paraMap.put("PASSWORD", EgovFileScrty.encryptPassword((String)paraMap.get("PASSWORD"), (String)paraMap.get("ADMIN_ID")));
		return userManageMapper.userManage_create(paraMap);
	}

	@Override
	public int userManage_delete(Map<String, Object> paraMap) {
		int resultInt = 0;
		String[] deleteList = String.valueOf(paraMap.get("DELETE_LIST")).split(",");
		for(int i =0;i<deleteList.length;i++) {
			String deleteId = deleteList[i];
			paraMap.put("ADMIN_ID", deleteId);
			resultInt += userManageMapper.userManage_delete(paraMap);
		}
		
		return resultInt;
	}

	@Override
	public int userManage_update(Map<String, Object> paraMap) {
		return userManageMapper.userManage_update(paraMap);
	}

	@Override
	public int userManage_initPassword(Map<String, Object> paraMap) throws Exception {
		int resultInt = 0;
		String[] deleteList = String.valueOf(paraMap.get("UPDATE_LIST")).split(",");
		for(int i =0;i<deleteList.length;i++) {
			String deleteId = deleteList[i];
			paraMap.put("ADMIN_ID", deleteId);
			paraMap.put("PASSWORD", EgovFileScrty.encryptPassword((String)paraMap.get("ADMIN_ID"), (String)paraMap.get("ADMIN_ID")));
			resultInt += userManageMapper.userManage_initPassword(paraMap);
		}
		
		return resultInt;
	}

}
