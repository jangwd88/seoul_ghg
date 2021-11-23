package egovframework.seoul.specify.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Mapper
@Repository
public class SpecMapper  extends EgovAbstractMapper{

	public ArrayList listEmd(HashMap paramMap) {
		return (ArrayList) selectList("specMapper.listEmd",paramMap);
	}

	public ArrayList specArchList(HashMap paramMap) {
		return (ArrayList) selectList("specMapper.specArchList",paramMap);
	}
	
	public ArrayList listOfficer(HashMap paramMap) {
		return (ArrayList) selectList("specMapper.listOfficer",paramMap);
	}

	public ArrayList selectOfficerList(Map param ) {
		return (ArrayList) selectList("specMapper.selectOfficerList",param);
	}

	public ArrayList listCons(HashMap paramMap) {
		return (ArrayList) selectList("specMapper.listCons",paramMap);
	}

	public ArrayList selectConsList(Map param) {
		return (ArrayList) selectList("specMapper.selectConsList",param);
		}

	public ArrayList listSpecArch(Map param) {
		return (ArrayList) selectList("specMapper.listSpecArch",param);
	}
	
	public HashMap getTotalAmtTarget(HashMap paramMap) {
		return (HashMap) selectOne("specMapper.getTotalAmtTarget",paramMap);
	}
	
	public void updtTotalAmtTarget(HashMap paramMap) {
		update("specMapper.updtTotalAmtTarget", paramMap);
	}
	
	
}
