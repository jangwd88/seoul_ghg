package egovframework.seoul.main.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import egovframework.seoul.cmmn.service.EgovFileScrty;

@Service
@Repository
public class MainServiceImpl implements MainService {

	@Autowired
	private MainMapper mainMapper;

	@Override
	public Map<String, Object> actionLogin(Map<String, Object> paraMap) throws Exception {
		paraMap.put("PASSWORD", EgovFileScrty.encryptPassword((String) paraMap.get("PASSWORD"), (String) paraMap.get("ADMIN_ID")));
		
		Map<String, Object> loginInfo = mainMapper.actionLogin(paraMap);
		
		return loginInfo;
	}

	@Override
	public int changePassword(Map<String, Object> paraMap) throws Exception {
		paraMap.put("PASSWORD", EgovFileScrty.encryptPassword((String) paraMap.get("PASSWORD"), (String) paraMap.get("ADMIN_ID")));
		return mainMapper.changePassword(paraMap);
	}

}
