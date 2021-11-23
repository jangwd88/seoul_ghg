package egovframework.seoul.dataManage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Mapper
@Repository
public class DataManageMapper extends EgovAbstractMapper {

	public List<Map<String, Object>> selectYearList(HashMap<String, Object> searchMap) {
		return selectList("dataManageMapper.selectYearList", searchMap);
	}
	
	public List dataManage001_search(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		return selectList("dataManageMapper.dataManage001_search", paraMap);
	}

	public List dataManage003_search(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		return selectList("dataManageMapper.dataManage003_search", paraMap);
	}

	public void dataManage003_save(Map<String, Object> paraMap) {
		// TODO Auto-generated method stub
		 insert("dataManageMapper.dataManage003_save", paraMap);
	}

	public void dataManage003_saveYear(Map<String, Object> insertMap) {
		// TODO Auto-generated method stub
		 insert("dataManageMapper.dataManage003_saveYear", insertMap);
	}

	public List dataManage001_getCRFMonthData(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		return selectList("dataManageMapper.dataManage001_getCRFMonthData", paraMap);
	}

	public void dataManage001_saveMonth(Map<String, Object> insertMap) {
		// TODO Auto-generated method stub
		 insert("dataManageMapper.dataManage001_saveMonth", insertMap);
	}

	public void dataManage002_close(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		 update("dataManageMapper.dataManage002_close", paraMap);
	}
	
	public void dataManage002_closeCancel(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		 update("dataManageMapper.dataManage002_closeCancel", paraMap);
	}

	public List selectMinYearList(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		return selectList("dataManageMapper.selectMinYearList", paraMap);
	}

	public void dataManage001_execute(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		selectOne("dataManageMapper.dataManage001_execute", paraMap);
	}
	
	public void dataManage003_execute(HashMap<String, Object> paraMap) {
		// TODO Auto-generated method stub
		selectOne("dataManageMapper.dataManage003_execute", paraMap);
	}

	public List<Map<String, Object>> selectListTempList(Map<String, Object> paraMap) {
		// TODO Auto-generated method stub
		return selectList("dataManageMapper.selectListTempList", paraMap);
	}

	public void insertTempData(Map<String, Object> paraMap) {
		// TODO Auto-generated method stub
		insert("dataManageMapper.insertTempData", paraMap);		
	}
}
