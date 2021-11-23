package egovframework.seoul.space.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import egovframework.seoul.entity.SpaceVO;

@Mapper
@Repository
public class SpaceMapper extends EgovAbstractMapper{
	
	public ArrayList selectArchList(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.selectArchList",paramMap);
	}

	public ArrayList listEmd(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.listEmd",paramMap);
	}
	
	public ArrayList listAdminHjCode(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.listAdminHjCode",paramMap);
	}
	
	public ArrayList listMgmBldPk(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.listMgmBldPk",paramMap);
	}
	
	public ArrayList listBuildInfo(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.listBuildInfo",paramMap);
	}
	
	public HashMap viewBuildInfo(HashMap paramMap) {
		return (HashMap) selectOne("spaceMapper.viewBuildInfo",paramMap);
	}
	
	public ArrayList listBuildEnergyInfo(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.listBuildEnergyInfo",paramMap);
	}
	
	public ArrayList listSameJusoBuild(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.listSameJusoBuild",paramMap);
	}
	
	public ArrayList selectDistrictList(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.selectDistrictList",paramMap);
	}

	public ArrayList listJusoSearch(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.listJusoSearch",paramMap);
	}

	public ArrayList spaceArchList(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.spaceArchList",paramMap);
	}
	
	public ArrayList listJuso(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.listJuso", paramMap);
	}

	public ArrayList listBuildInfoByJuso(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.listBuildInfoByJuso", paramMap);
	}
	public HashMap viewBuildInfoByMgmBldPk(HashMap paramMap) {
		return (HashMap) selectOne("spaceMapper.viewBuildInfoByMgmBldPk", paramMap);
	}
	public ArrayList listBuildEnergyInfoByMonth(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.listBuildEnergyInfoByMonth", paramMap);
	}

	public ArrayList viewJusoInfo(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.viewJusoInfo", paramMap);
	}

	public ArrayList listArch(HashMap paramMap) {
		return (ArrayList) selectList("spaceMapper.listArch", paramMap);
	}
	
	public HashMap getAdminCoord(HashMap paramMap) {
		return (HashMap) selectOne("spaceMapper.getAdminCoord", paramMap);
	}
	
	public Integer checkUserLikeBuild(HashMap paramMap) {
		return (Integer) selectOne("spaceMapper.checkUserLikeBuild", paramMap);
	}
	
	public void setUserLikeBuild(HashMap paramMap) {
		
		String userLikeBuildStatus = paramMap.get("userLikeBuildStatus").toString();
		if("like".equals(userLikeBuildStatus)) {
			
			delete("spaceMapper.setUserUnlikeBuild", paramMap);
		} else {
			
			insert("spaceMapper.setUserLikeBuild", paramMap);
		}
		
	}

	public ArrayList selectListUserLikeBuild(HashMap paramMap) {

		return (ArrayList) selectList("spaceMapper.selectListUserLikeBuild", paramMap);
	}

	public HashMap fnViewBuildByInfoMainPurpsNm() {
		return (HashMap) selectOne("spaceMapper.fnViewBuildByInfoMainPurpsNm");
	}
	
}
