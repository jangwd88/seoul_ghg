package egovframework.seoul.inven.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Mapper
@Repository
public class InvenMapper extends EgovAbstractMapper {

	@SuppressWarnings("rawtypes")
	public List inven001_search(HashMap<String, Object> searchMap) {
		return selectList("invenMapper.inven001_search", searchMap);
	}

	public List<Map<String, Object>> inven001_search_chart(HashMap<String, Object> paraMap) {
		return selectList("invenMapper.inven001_search_chart", paraMap);
	}

	@SuppressWarnings("rawtypes")
	public List inven002_search(HashMap<String, Object> paraMap) {
		return selectList("invenMapper.inven002_search", paraMap);
	}

	@SuppressWarnings("rawtypes")
	public List inven003_search(HashMap<String, Object> paraMap) {
		return selectList("invenMapper.inven003_search", paraMap);
	}

	@SuppressWarnings("rawtypes")
	public List inven004_search(HashMap<String, Object> paraMap) {
		return selectList("invenMapper.inven004_search", paraMap);
	}

	public List<Map<String, Object>> selectYearList(HashMap<String, Object> searchMap) {
		return selectList("invenMapper.selectYearList", searchMap);
	}

	public List<Map<String, Object>> selectMinMaxYear(HashMap<String, Object> searchMap) {
		return selectList("invenMapper.selectMinMaxYear", searchMap);
	}

}
