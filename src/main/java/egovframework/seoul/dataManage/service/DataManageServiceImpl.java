package egovframework.seoul.dataManage.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import egovframework.seoul.util.GridDataUtil;
import twitter4j.JSONArray;
import twitter4j.JSONObject;

@Service
@Repository
public class DataManageServiceImpl implements DataManageService {

	@Autowired
	DataManageMapper dataManageMapper;

	@Override
	public List<Map<String, Object>> selectYearList(HashMap<String, Object> searchMap) {
		return dataManageMapper.selectYearList(searchMap);
	}
	
	@Override
	public List dataManage001_getCRFMonthData(HashMap<String, Object> paraMap) throws Exception {
		// TODO Auto-generated method stub
		return dataManageMapper.dataManage001_getCRFMonthData(paraMap);
	}
	
	@Override
	public List dataManage001_search(HashMap<String, Object> paraMap) throws Exception {
		// TODO Auto-generated method stub
		return dataManageMapper.dataManage001_search(paraMap);
	}
	
	@Override
	public List dataManage003_search(HashMap<String, Object> paraMap) throws Exception {
		// TODO Auto-generated method stub
		return dataManageMapper.dataManage003_search(paraMap);
	}
	
	@Override
	public String dataManage001_saveMonth(HashMap<String, Object> paraMap) throws Exception {
		// TODO Auto-generated method stub
		String data = String.valueOf("["+paraMap.get("data")+"]");
		JSONArray jsonArr = new JSONArray(data);
		JSONObject jsonObj = new JSONObject();
		Map<String, Object> insertMap = new HashMap<String, Object>();
		for(int i =0;i<jsonArr.length();i++) {
			jsonObj = jsonArr.getJSONObject(i);
			
			Iterator<Integer> itr = jsonObj.keys();
			
			while( itr.hasNext() )
			{
				String keyname  = String.valueOf(itr.next());
				
				String pointId = keyname.split("_")[0];
				String year = keyname.split("_")[1];
				String unit = keyname.split("_")[2];
				String vitalYn = keyname.split("_")[3];
				
				JSONArray depthArr = new JSONArray( String.valueOf(jsonObj.get(keyname)));
				JSONObject depthObj = new JSONObject();
				for(int d =0;d<depthArr.length();d++) {
					depthObj = depthArr.getJSONObject(d);
					insertMap = GridDataUtil.toMap(depthObj);
					
					insertMap.put("FUEL_DIV", pointId);
					insertMap.put("YEAR", year);
					insertMap.put("UNIT", unit);
					insertMap.put("VITAL_YN", vitalYn);
					insertMap.put("VALUE", String.valueOf(insertMap.get("VALUE")).replaceAll(",", ""));
					
					boolean isMonthData = String.valueOf(insertMap.get("NAME")).indexOf("N_ENG") > -1;
					String mon = "";
					mon = String.valueOf(insertMap.get("NAME")).split("_")[4];
					insertMap.put("MON", mon);
					insertMap.put("POINT_CODE", paraMap.get("POINT_CODE"));
					dataManageMapper.dataManage001_saveMonth(insertMap);
					
					List<Map<String, Object>> tempList = dataManageMapper.selectListTempList(insertMap);
					Iterator tempIt = tempList.iterator();
					while(tempIt.hasNext()) {
						Map<String, Object> tempMap = (HashMap<String, Object>) tempIt.next();
						dataManageMapper.insertTempData(tempMap);
					}
				}
			}
		}
		return "저장되었습니다"; 
	}
	
	@Override
	public String dataManage002_close(HashMap<String, Object> paraMap) throws Exception {
		// TODO Auto-generated method stub
		
		dataManageMapper.dataManage002_close(paraMap);
		
		return "마감 되었습니다.";
	}
	
	@Override
	public String dataManage002_closeCancel(HashMap<String, Object> paraMap) throws Exception {
		// TODO Auto-generated method stub
		
		dataManageMapper.dataManage002_closeCancel(paraMap);
		
		return "마감 취소되었습니다.";
	}
	
	@Override
	public String dataManage003_save(HashMap<String, Object> paraMap) throws Exception {
		// TODO Auto-generated method stub
		
		String data = String.valueOf("["+paraMap.get("data")+"]");
		JSONArray jsonArr = new JSONArray(data);
		JSONObject jsonObj = new JSONObject();
		Map<String, Object> insertMap = new HashMap<String, Object>();
		for(int i =0;i<jsonArr.length();i++) {
			jsonObj = jsonArr.getJSONObject(i);
			
			Iterator<Integer> itr = jsonObj.keys();
			
			while( itr.hasNext() )
			{
				String keyname  = String.valueOf(itr.next());
				
				String pointId = keyname.split("_")[0];
				String year = keyname.split("_")[1];
				
				JSONArray depthArr = new JSONArray( String.valueOf(jsonObj.get(keyname)));
				JSONObject depthObj = new JSONObject();
				System.out.println(jsonObj.get(keyname));
				for(int d =0;d<depthArr.length();d++) {
					depthObj = depthArr.getJSONObject(d);
					insertMap = GridDataUtil.toMap(depthObj);
					
					insertMap.put("POINT_ID", pointId);
					insertMap.put("YEAR", year);
					insertMap.put("VALUE", String.valueOf(insertMap.get("VALUE")).replaceAll(",", ""));
					System.out.println(insertMap);
					
					boolean isMonthData = String.valueOf(insertMap.get("NAME")).indexOf("MON") > -1;
					String mon = "";
					if(isMonthData) {
						mon = String.valueOf(insertMap.get("NAME")).split("_")[1];
						insertMap.put("MON", mon);
						dataManageMapper.dataManage003_save(insertMap);
					}else {
						dataManageMapper.dataManage003_saveYear(insertMap);
					}
				}
			}
		}
		
		
		
		return "저장되었습니다"; 
	}

	@Override
	public void dataManage001_execute(HashMap<String, Object> paraMap) {
		dataManageMapper.dataManage001_execute(paraMap);
	}
	
	@Override
	public void dataManage003_execute(HashMap<String, Object> paraMap) {
		dataManageMapper.dataManage003_execute(paraMap);
	}
	
}
