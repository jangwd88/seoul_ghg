package egovframework.seoul.log.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@SuppressWarnings("rawtypes")
public class AccessLogServiceImpl implements AccessLogService {

    @Autowired
    AccessLogMapper accessLogMapper;

    // 접속 로그 저장 처리
    public int regiAccessLog(Map paramMap) {
        return accessLogMapper.regiAccessLog(paramMap);
    }
}
