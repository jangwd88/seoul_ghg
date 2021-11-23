package egovframework.seoul.system.codeManage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Mapper
@Repository
public class CodeManageMapper extends EgovAbstractMapper {

	public List<Map<String, Object>> masterCodeData(HashMap<String, Object> searchMap) {
		return selectList("codeManageMapper.masterCodeData", searchMap);
	}

	public List<Map<String, Object>> detailCodeData(HashMap<String, Object> searchMap) {
		return selectList("codeManageMapper.detailCodeData", searchMap);
	}

	public void addNUpdateCodeMaster(HashMap<String, Object> paraMap) {
		insert("codeManageMapper.addNUpdateCodeMaster", paraMap);
	}

	public void addNUpdateCodeDetail(HashMap<String, Object> paraMap) {
		insert("codeManageMapper.addNUpdateCodeDetail", paraMap);
	}

	public void deleteCodeMaster(HashMap<String, Object> paraMap) {
		delete("codeManageMapper.deleteCodeDetail", paraMap);
		delete("codeManageMapper.deleteCodeMaster", paraMap);
	}

	public void deleteCodeDetail(HashMap<String, Object> paraMap) {
		delete("codeManageMapper.deleteCodeDetail2", paraMap);
	}

}
