package egovframework.seoul.dash.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Mapper
@Repository
public class DashMapper extends EgovAbstractMapper {

	public ArrayList listSeoulOwnTarget1(HashMap paramMap) {
		return (ArrayList) selectList("dashMapper.listSeoulOwnTarget1", paramMap);
	}
	public HashMap nextViewSeoulOwnTarget1(HashMap paramMap) {
		return (HashMap) selectOne("dashMapper.nextViewSeoulOwnTarget1", paramMap);
	}
	public void updtNextSeoulOwnTarget1(HashMap paramMap) {
		update("dashMapper.updtNextSeoulOwnTarget1", paramMap);
	}	
	public HashMap viewSeoulOwnTarget1(HashMap paramMap) {
		return (HashMap) selectOne("dashMapper.viewSeoulOwnTarget1", paramMap);
	}

	public ArrayList listSeoulOwnTarget1EnergyLedger(HashMap paramMap) {
		return (ArrayList) selectList("dashMapper.listSeoulOwnTarget1EnergyLedger", paramMap);
	}
	public HashMap dashBoardFacilityInfo(HashMap paramMap) {
		return (HashMap) selectOne("dashMapper.dashBoardFacilityInfo", paramMap);
	}
	public ArrayList dashBoardListInfo(HashMap paramMap) {
		return (ArrayList) selectList("dashMapper.dashBoardListInfo", paramMap);
	}
	
	public ArrayList specDashboardSeoulOwnTarget1(HashMap paramMap) {
		return (ArrayList) selectList("dashMapper.specDashboardSeoulOwnTarget1", paramMap);
	}
}
