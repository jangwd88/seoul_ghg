package egovframework.seoul.system.logManage.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SuppressWarnings("rawtypes")
public interface LogManageService {

	ArrayList logInfo(HashMap paramMap);


    // 접속 로그 리스트 조회
	public List listAccessLog(Map paramMap);
	// 접속 로그 개수 조회
	public int listAccessLogCount(Map paramMap);
}
