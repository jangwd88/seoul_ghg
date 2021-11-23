package egovframework.seoul.standInfo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Mapper
@Repository
public class StandInfoMapper extends EgovAbstractMapper {

	@SuppressWarnings("rawtypes")
	public List standInfo001_search(HashMap<String, Object> searchMap) {
		return selectList("standInfoMapper.standInfo001_search", searchMap);
	}

	@SuppressWarnings("rawtypes")
	public List standInfo002_search(HashMap<String, Object> paraMap) {
		return selectList("standInfoMapper.standInfo002_search", paraMap);
	}

	@SuppressWarnings("rawtypes")
	public List standInfo003_search(HashMap<String, Object> paraMap) {
		return selectList("standInfoMapper.standInfo003_search", paraMap);
	}

	public List<Map<String, Object>> selectYearList(HashMap<String, Object> searchMap) {
		return selectList("standInfoMapper.selectYearList", searchMap);
	}

	public List standInfo003_searchDetail(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		return selectList("standInfoMapper.standInfo003_searchDetail", paraMap);
	}

	public List standInfo003_searchDetailTalbe(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		return selectList("standInfoMapper.standInfo003_searchDetailTalbe", paraMap);
	}

	public List<Map<String, Object>> selectGubunList(HashMap<String, Object> searchMap) {
		// TODO Auto-generated method stub
		return selectList("standInfoMapper.selectGubunList", searchMap);
	}

	public List standInfo004_search(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		return selectList("standInfoMapper.standInfo004_search", paraMap);
	}

	public List standInfo004_getPreYearData(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		return selectList("standInfoMapper.standInfo004_getPreYearData", paraMap);
	}

	public void setpreYearData(HashMap<String, Object> insertMap) {
		// TODO Auto-generated method stub
		insert("standInfoMapper.setpreYearData", insertMap);
	}

	public List<Map<String, Object>> getDataInfo(HashMap<String, Object> searchMap) {
		// TODO Auto-generated method stub
		return selectList("standInfoMapper.getDataInfo", searchMap);
	}

	public void standInfo003_deleteRow(HashMap<String, Object> deleteMap) {
		// TODO Auto-generated method stub
		delete("standInfoMapper.standInfo003_deleteRow", deleteMap);
	}

	public void standInfo003_addRow(HashMap<String, Object> insertMap) {
		// TODO Auto-generated method stub
		insert("standInfoMapper.standInfo003_addRow", insertMap);
	}

	public void standInfo004_save(Map<String, Object> insertMap) {
		// TODO Auto-generated method stub
		update("standInfoMapper.standInfo004_save", insertMap);
	}

	public void standInfo003_updateRow(HashMap<String, Object> updateMap) {
		// TODO Auto-generated method stub
		update("standInfoMapper.standInfo003_updateRow", updateMap);
	}

	public int standInfo004_insertYearData(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		return insert("standInfoMapper.standInfo004_insertYearData", paraMap);
	}

	public List standInfo004_checkYearData(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		return selectList("standInfoMapper.standInfo004_checkYearData", paraMap);
	}

}
