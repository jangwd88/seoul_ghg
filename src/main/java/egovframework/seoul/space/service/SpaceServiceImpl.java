package egovframework.seoul.space.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import egovframework.seoul.entity.SpaceVO;


@Service
@Repository
public class SpaceServiceImpl implements SpaceService {
	
	@Autowired
	SpaceMapper spaceMapper;
	
	
	@Override
	public ArrayList selectArchList(HashMap paramMap) throws Exception {
		return (ArrayList) spaceMapper.selectArchList(paramMap);
	}
	
	@Override
	public ArrayList listEmd(HashMap paramMap) throws Exception {
		return (ArrayList) spaceMapper.listEmd(paramMap);
	}
	
	@Override
	public ArrayList listAdminHjCode(HashMap paramMap) throws Exception {
		return (ArrayList) spaceMapper.listAdminHjCode(paramMap);
	}
	
	@Override
	public ArrayList listMgmBldPk(HashMap paramMap) throws Exception {
		return (ArrayList) spaceMapper.listMgmBldPk(paramMap);
	}
	
	@Override
	public ArrayList listBuildInfo(HashMap paramMap) throws Exception {
		return (ArrayList) spaceMapper.listBuildInfo(paramMap);
	}
	
	@Override
	public HashMap viewBuildInfo(HashMap paramMap) throws Exception {
		return (HashMap) spaceMapper.viewBuildInfo(paramMap);
	}
	
	@Override
	public ArrayList listBuildEnergyInfo(HashMap paramMap) throws Exception {
		return (ArrayList) spaceMapper.listBuildEnergyInfo(paramMap);
	}
	
	@Override
	public ArrayList listSameJusoBuild(HashMap paramMap) throws Exception {
		return (ArrayList) spaceMapper.listSameJusoBuild(paramMap);
	}
	
	@Override
	public ArrayList selectDistrictList(HashMap paramMap) {
		return (ArrayList) spaceMapper.selectDistrictList(paramMap);
	}

	@Override
	public ArrayList listJuso(HashMap paramMap) {
		return (ArrayList) spaceMapper.listJuso(paramMap);
	}

	@Override
	public ArrayList listBuildInfoByJuso(HashMap paramMap) {
		return (ArrayList) spaceMapper.listBuildInfoByJuso(paramMap);
	}
	@Override
	public HashMap viewBuildInfoByMgmBldPk(HashMap paramMap) {
		return (HashMap) spaceMapper.viewBuildInfoByMgmBldPk(paramMap);
	}

	@Override
	public ArrayList listBuildEnergyInfoByMonth(HashMap paramMap) {
		return (ArrayList) spaceMapper.listBuildEnergyInfoByMonth(paramMap);
	}
	
	@Override
	public ArrayList viewJusoInfo(HashMap paramMap) {
		return (ArrayList) spaceMapper.viewJusoInfo(paramMap);
	}

	@Override
	public ArrayList listArch(HashMap paramMap) throws Exception {
		return (ArrayList) spaceMapper.listArch(paramMap);
	}

	@Override
	public HashMap getAdminCoord(HashMap paramMap) throws Exception {
		return (HashMap) spaceMapper.getAdminCoord(paramMap);
	}
	
	@Override
	public Integer checkUserLikeBuild(HashMap paramMap) throws Exception {
		return (Integer) spaceMapper.checkUserLikeBuild(paramMap);
	}
	
	@Override
	public void setUserLikeBuild(HashMap paramMap) throws Exception {
		spaceMapper.setUserLikeBuild(paramMap);
	}

	@Override
	public ArrayList selectListUserLikeBuild(HashMap paramMap) {
		
		return (ArrayList) spaceMapper.selectListUserLikeBuild(paramMap);
	}

	@Override
	public HashMap fnViewBuildByInfoMainPurpsNm() {
		// TODO Auto-generated method stub
		return (HashMap) spaceMapper.fnViewBuildByInfoMainPurpsNm();
	}
	
}
