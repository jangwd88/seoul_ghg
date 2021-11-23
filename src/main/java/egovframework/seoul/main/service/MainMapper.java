package egovframework.seoul.main.service;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Mapper
@Repository
public class MainMapper extends EgovAbstractMapper {

	public Map<String, Object> actionLogin(Map<String, Object> paraMap) {
		return selectOne("actionLogin", paraMap);
	}

	public int changePassword(Map<String, Object> paraMap) {
		return update("changePassword", paraMap);
	}

}
