package egovframework.seoul.dash.service;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;


@SuppressWarnings("unused")
public interface DashService{

	ArrayList listSeoulOwnTarget1(HashMap paramMap);

	HashMap nextViewSeoulOwnTarget1(HashMap paramMap);
	
	HashMap viewSeoulOwnTarget1(HashMap paramMap);

	ArrayList listSeoulOwnTarget1EnergyLedger(HashMap paramMap);

	void updtNextSeoulOwnTarget1(HashMap paramMap);

	HashMap dashBoardFacilityInfo(HashMap paramMap);

	ArrayList dashBoardListInfo(HashMap paramMap);
	
	ArrayList specDashboardSeoulOwnTarget1(HashMap paramMap);
	

}
