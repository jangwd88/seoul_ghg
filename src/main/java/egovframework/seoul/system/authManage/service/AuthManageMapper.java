package egovframework.seoul.system.authManage.service;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Mapper
@Repository
public class AuthManageMapper extends EgovAbstractMapper {

	public int authManage_update(Map<String, Object> paraMap) {
		return update("authManage_update", paraMap);
	}

}
