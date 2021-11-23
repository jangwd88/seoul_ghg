package egovframework.seoul.stat.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Mapper
@Repository
public class StatMapper extends EgovAbstractMapper {

	public List<Map<String, Object>> getCode(HashMap<String, Object> searchMap) {
		return selectList("statMapper.getCode", searchMap);
	}

	public List<Map<String, Object>> stat001_search(HashMap<String, Object> paraMap) {
		return selectList("statMapper.stat001_search", paraMap);
	}

	public List<Map<String, Object>> stat002_search(HashMap<String, Object> paraMap) {
		return selectList("statMapper.stat002_search", paraMap);
	}

	public List<Map<String, Object>> selectYearList(HashMap<String, Object> paraMap) {
		return selectList("statMapper.selectYearList", paraMap);
	}

	public Map<String, Object> selectMinMaxYear(HashMap<String, Object> searchMap) {
		return selectOne("statMapper.selectMinMaxYear", searchMap);
	}

	public List<Map<String, Object>> stat003_getBuildingList(HashMap<String, Object> paraMap) {
		return selectList("statMapper.stat003_getBuildingList", paraMap);
	}

	public List<Map<String, Object>> stat003_search(HashMap<String, Object> paraMap) {
		return selectList("statMapper.stat003_search", paraMap);
	}

	public int stat003_getBuildingGoalId(HashMap<String, Object> paraMap) {
		return selectOne("statMapper.stat003_getBuildingGoalId", paraMap);
	}

	public void stat003_saveBuilding(HashMap<String, Object> insertMap) throws Exception {
		insert("statMapper.stat003_saveBuilding", insertMap);
	}

	public int stat003_getYearGoalId(HashMap<String, Object> paraMap) {
		return selectOne("statMapper.stat003_getYearGoalId", paraMap);
	}

	public void stat003_saveBuildingYear(HashMap<String, Object> insertMap) throws Exception {
		insert("statMapper.stat003_saveBuildingYear", insertMap);
	}

	public void stat003_deleteBuilding(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		delete("statMapper.stat003_deleteBuilding", paraMap);
	}

}
