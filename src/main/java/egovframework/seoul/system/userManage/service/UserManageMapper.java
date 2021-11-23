package egovframework.seoul.system.userManage.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Mapper
@Repository
public class UserManageMapper extends EgovAbstractMapper {

	public List<Map<String, Object>> userManage_search(Map<String, Object> paraMap) {
		return selectList("userManageMapper.userManage_search", paraMap);
	}

	public List<Map<String, Object>> selectOfficerCodeList() {
		return selectList("userManageMapper.selectOfficerCodeList", null);
	}

	public int userManage_create(Map<String, Object> paraMap) {
		return insert("userManage_create", paraMap);
	}

	public int userManage_delete(Map<String, Object> paraMap) {
		return update("userManage_delete", paraMap);
	}

	public int userManage_update(Map<String, Object> paraMap) {
		return update("userManage_update", paraMap);
	}

	public int userManage_initPassword(Map<String, Object> paraMap) {
		return update("userManage_initPassword", paraMap);
	}

}
