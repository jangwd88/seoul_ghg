package egovframework.seoul.log.service;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Mapper
@Repository
@SuppressWarnings("rawtypes")
public class AccessLogMapper extends EgovAbstractMapper{

    // 접속 로그 저장 처리
    public int regiAccessLog(Map paramMap) {
        return insert("accessLogMapper.regiAccessLog", paramMap);
    }
}
