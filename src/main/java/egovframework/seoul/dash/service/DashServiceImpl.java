package egovframework.seoul.dash.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;


@Service
@Repository
public class DashServiceImpl implements DashService {

		
		@Autowired
		private DashMapper dashMapper;

		@Override
		public ArrayList listSeoulOwnTarget1(HashMap paramMap) {
			return (ArrayList) dashMapper.listSeoulOwnTarget1(paramMap);
		}
		
		@Override
		public HashMap nextViewSeoulOwnTarget1(HashMap paramMap) {
			return (HashMap) dashMapper.nextViewSeoulOwnTarget1(paramMap);
		}
		
		@Override
		public void updtNextSeoulOwnTarget1(HashMap paramMap) {
			dashMapper.updtNextSeoulOwnTarget1(paramMap);
		}
		
		@Override
		public HashMap viewSeoulOwnTarget1(HashMap paramMap) {
			return (HashMap) dashMapper.viewSeoulOwnTarget1(paramMap);
		}
		
		@Override
		public ArrayList listSeoulOwnTarget1EnergyLedger(HashMap paramMap) {
			return (ArrayList) dashMapper.listSeoulOwnTarget1EnergyLedger(paramMap);
		}
		
		@Override
		public HashMap dashBoardFacilityInfo(HashMap paramMap) {
			return (HashMap) dashMapper.dashBoardFacilityInfo(paramMap);
		}
		
		@Override
		public ArrayList dashBoardListInfo(HashMap paramMap) {
			return (ArrayList) dashMapper.dashBoardListInfo(paramMap);
		}

		@Override
		public ArrayList specDashboardSeoulOwnTarget1(HashMap paramMap) {
			return (ArrayList) dashMapper.specDashboardSeoulOwnTarget1(paramMap);
		}
		
		
}
