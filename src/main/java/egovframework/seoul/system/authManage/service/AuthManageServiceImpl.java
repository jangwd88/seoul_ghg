package egovframework.seoul.system.authManage.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Service
@Repository
public class AuthManageServiceImpl implements AuthManageService {

	@Autowired
	AuthManageMapper authManageMapper;

	@Override
	public int authManage_update(Map<String, Object> paraMap) {
		return authManageMapper.authManage_update(paraMap);
	}

}
