package egovframework.seoul.system.logManage.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Service
@Repository
@SuppressWarnings("rawtypes")
public class LogManageServiceImpl implements LogManageService {

	@Autowired
	LogManageMapper logManageMapper;

    @Override
	public ArrayList logInfo(HashMap paramMap) {
		return (ArrayList)logManageMapper.logInfo(paramMap);
	}

    /**
     * 접속 로그 리스트 조회
     */
	@Override
	public List listAccessLog(Map paramMap) {
	    return (List)logManageMapper.listAccessLog(paramMap);
	}

	/**
	 * 접속 로그 개수 조회
	 */
	@Override
	public int listAccessLogCount(Map paramMap) {
	    return logManageMapper.listAccessLogCount(paramMap);
	}

}
