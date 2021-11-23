package egovframework.seoul.invenCal.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Mapper
@Repository
public class InvenCalMapper extends EgovAbstractMapper {

	@SuppressWarnings("rawtypes")
	public List invenCal001_search(HashMap<String, Object> searchMap) {
		return selectList("invenCalMapper.invenCal001_search", searchMap);
	}

	@SuppressWarnings("rawtypes")
	public List invenCal002_search(HashMap<String, Object> paraMap) {
		return selectList("invenCalMapper.invenCal002_search", paraMap);
	}

	@SuppressWarnings("rawtypes")
	public List invenCal003_search(HashMap<String, Object> paraMap) {
		return selectList("invenCalMapper.invenCal003_search", paraMap);
	}

	public List<Map<String, Object>> selectYearList(HashMap<String, Object> searchMap) {
		return selectList("invenCalMapper.selectYearList", searchMap);
	}

}
