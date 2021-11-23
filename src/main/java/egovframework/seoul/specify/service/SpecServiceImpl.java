package egovframework.seoul.specify.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import egovframework.seoul.space.service.SpaceMapper;


@Service
@Repository
public class SpecServiceImpl implements SpecService {
	
	@Autowired
	SpecMapper specMapper;

	@Override
	public ArrayList listEmd(HashMap paramMap) {
		return (ArrayList)specMapper.listEmd(paramMap);
	}

	@Override
	public ArrayList specArchList(HashMap paramMap) {
		return (ArrayList) specMapper.specArchList(paramMap);
	}
	
	@Override
	public ArrayList listOfficer(HashMap paramMap) {
		return (ArrayList) specMapper.listOfficer(paramMap);
	}
	
	@Override
	public ArrayList listSpecArch(Map param) {
		return (ArrayList) specMapper.listSpecArch(param);
	}
	
	@Override
	public ArrayList selectOfficerList(Map param) {
		return (ArrayList) specMapper.selectOfficerList(param);
	}

	@Override
	public ArrayList listCons(HashMap paramMap) {
		return (ArrayList) specMapper.listCons(paramMap);
	}

	@Override
	public ArrayList selectConsList(Map param) {
		return (ArrayList) specMapper.selectConsList(param);
	}

	@Override
	public HashMap getTotalAmtTarget(HashMap paramMap) {
		return (HashMap) specMapper.getTotalAmtTarget(paramMap);
	}
	
	@Override
	public void updtTotalAmtTarget(HashMap paramMap) {
		specMapper.updtTotalAmtTarget(paramMap);
	}
	
	
	
}
