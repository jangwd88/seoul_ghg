package egovframework.seoul.space.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.seoul.entity.SpaceVO;

@SuppressWarnings("unused")
public interface SpaceService {


	ArrayList selectArchList(HashMap paramMap) throws Exception;
	
	ArrayList listArch(HashMap paramMap) throws Exception;
	
	ArrayList listEmd(HashMap paramMap) throws Exception;
	
	ArrayList listAdminHjCode(HashMap paramMap) throws Exception;
	
	ArrayList listMgmBldPk(HashMap paramMap) throws Exception;
		
	ArrayList listBuildInfo(HashMap paramMap) throws Exception;
	
	HashMap viewBuildInfo(HashMap paramMap) throws Exception;
	
	ArrayList listBuildEnergyInfo(HashMap paramMap) throws Exception;
	
	ArrayList listSameJusoBuild(HashMap paramMap) throws Exception;
	
	public ArrayList selectDistrictList(HashMap paramMap);

	public ArrayList listJuso(HashMap paramMap);

	public ArrayList listBuildInfoByJuso(HashMap paramMap);
	
	public HashMap viewBuildInfoByMgmBldPk(HashMap paramMap);

	public ArrayList listBuildEnergyInfoByMonth(HashMap paramMap);
	
	public ArrayList viewJusoInfo(HashMap paramMap);

	public HashMap getAdminCoord(HashMap paramMap) throws Exception;
	
	public Integer checkUserLikeBuild(HashMap paramMap) throws Exception;

	void setUserLikeBuild(HashMap paramMap) throws Exception;

	ArrayList selectListUserLikeBuild(HashMap paramMap);

	HashMap fnViewBuildByInfoMainPurpsNm();


}
