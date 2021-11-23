package egovframework.seoul.main.service;

import java.util.Map;

public interface MainService {

	Map<String, Object> actionLogin(Map<String, Object> paraMap) throws Exception;

	int changePassword(Map<String, Object> paraMap) throws Exception;

}
