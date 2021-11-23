package egovframework.seoul.system.logManage.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Mapper
@Repository
@SuppressWarnings("rawtypes")
public class LogManageMapper extends EgovAbstractMapper {

	public ArrayList logInfo(HashMap paramMap) {
		return (ArrayList) selectList("logManageMapper.logInfo",paramMap);
	}

	/**
	 * 로그 리스트 조회
	 * @param paramMap
	 * @return
	 */
    public List listAccessLog(Map paramMap) {
	    return (List) selectList("logManageMapper.listAccessLog",paramMap);
	}
    /**
     * 로그 리스트 개수 조회
     * @param paramMap
     * @return
     */
    public int listAccessLogCount(Map paramMap) {
        return selectOne("logManageMapper.listAccessLogCount",paramMap);
    }
}
