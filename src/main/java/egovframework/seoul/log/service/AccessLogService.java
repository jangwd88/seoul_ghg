package egovframework.seoul.log.service;

import java.util.Map;

@SuppressWarnings("rawtypes")
public interface AccessLogService {

    // 접속 로그 저장 처리
    public int regiAccessLog(Map paramMap);
}
