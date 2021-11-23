package egovframework.seoul.standInfo.service;

import java.util.Arrays;
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
public class StandInfoServiceImpl implements StandInfoService {

	@Autowired
	StandInfoMapper standInfoMapper;

	@SuppressWarnings("rawtypes")
	@Override
	public List standInfo001_search(HashMap<String, Object> searchMap) throws Exception {
		String gridDataArr = searchMap.get("util") == null ? "" : (String) searchMap.get("util");
		List<String> list = Arrays.asList(gridDataArr.split(","));
		searchMap.put("utilList", list);

		return standInfoMapper.standInfo001_search(searchMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List standInfo002_search(HashMap<String, Object> paraMap) throws Exception {
		String gridDataArr = paraMap.get("util") == null ? "" : (String) paraMap.get("util");
		List<String> list = Arrays.asList(gridDataArr.split(","));
		paraMap.put("utilList", list);

		return standInfoMapper.standInfo002_search(paraMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List standInfo003_search(HashMap<String, Object> paraMap) throws Exception {
		String gridDataArr = paraMap.get("util") == null ? "" : (String) paraMap.get("util");
		List<String> list = Arrays.asList(gridDataArr.split(","));
		paraMap.put("utilList", list);

		return standInfoMapper.standInfo003_search(paraMap);
	}

	@Override
	public List standInfo003_searchDetail(HashMap<String, Object> paraMap) throws Exception {
		// TODO Auto-generated method stub
		return standInfoMapper.standInfo003_searchDetail(paraMap);
	}
	
	@Override
	public List standInfo003_searchDetailTalbe(HashMap<String, Object> paraMap) throws Exception {
		// TODO Auto-generated method stub
		return standInfoMapper.standInfo003_searchDetailTalbe(paraMap);
	}
	
	@Override
	public void standInfo003_saveRow(HashMap<String, Object> paraMap) throws Exception {
		// TODO Auto-generated method stub
		
		String deleteRow = String.valueOf( paraMap.get("DELETE") );
		JSONArray jsonArr = new JSONArray(deleteRow);
		JSONObject jsonObj = new JSONObject();
		HashMap<String, Object> deleteMap = new HashMap<String, Object>();
		for(int i =0;i<jsonArr.length();i++) {
			jsonObj = jsonArr.getJSONObject(i);
			deleteMap = (HashMap<String, Object>) GridDataUtil.toMap(jsonObj);
			standInfoMapper.standInfo003_deleteRow(deleteMap);
		}
		
		String updateRow = String.valueOf( paraMap.get("OLD") );
		jsonArr = new JSONArray(updateRow);
		jsonObj = new JSONObject();
		HashMap<String, Object> updateMap = new HashMap<String, Object>();
		for(int i =0;i<jsonArr.length();i++) {
			jsonObj = jsonArr.getJSONObject(i);
			updateMap = (HashMap<String, Object>) GridDataUtil.toMap(jsonObj);
			standInfoMapper.standInfo003_updateRow(updateMap);
		}
		
		String saveRow = String.valueOf( paraMap.get("SAVE") );
		jsonArr = new JSONArray(saveRow);
		jsonObj = new JSONObject();
		HashMap<String, Object> insertMap = new HashMap<String, Object>();
		for(int i =0;i<jsonArr.length();i++) {
			jsonObj = jsonArr.getJSONObject(i);
			insertMap = (HashMap<String, Object>) GridDataUtil.toMap(jsonObj);
			standInfoMapper.standInfo003_addRow(insertMap);
		}
		
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List standInfo004_search(HashMap<String, Object> paraMap) throws Exception {
		String gridDataArr = paraMap.get("util") == null ? "" : (String) paraMap.get("util");
		List<String> list = Arrays.asList(gridDataArr.split(","));
		paraMap.put("utilList", list);

		return standInfoMapper.standInfo004_search(paraMap);
	}
	
	@Override
	public List<Map<String, Object>> selectYearList(HashMap<String, Object> searchMap) {
		return standInfoMapper.selectYearList(searchMap);
	}
	
	@Override
	public List<Map<String, Object>> selectGubunList(HashMap<String, Object> searchMap) throws Exception {
		// TODO Auto-generated method stub
		return standInfoMapper.selectGubunList(searchMap);
	}

	@Override
	public String standInfo004_getPreYearData(HashMap<String, Object> paraMap) throws Exception {
		// TODO Auto-generated method stub
		List list = standInfoMapper.standInfo004_getPreYearData(paraMap);
		JSONArray jsonArr = new JSONArray(list);
		JSONObject jsonObj = new JSONObject();
		HashMap<String, Object> insertMap = new HashMap<String, Object>();
		for(int i =0;i<jsonArr.length();i++) {
			jsonObj = jsonArr.getJSONObject(i);
			insertMap = (HashMap<String, Object>) GridDataUtil.toMap(jsonObj);
			standInfoMapper.setpreYearData(insertMap);
		}
		
		return null;
	}
	
	@Override
	public List<Map<String, Object>> getDataInfo(HashMap<String, Object> searchMap) throws Exception {
		// TODO Auto-generated method stub
		return standInfoMapper.getDataInfo(searchMap);
	}
	
	@Override
	public String standInfo004_save(HashMap<String, Object> paraMap) throws Exception {
		// TODO Auto-generated method stub
		String data = String.valueOf("["+paraMap.get("data")+"]");
		JSONArray jsonArr = new JSONArray(data);
		JSONObject jsonObj = new JSONObject();
		
		String CEF_TYPE = String.valueOf(paraMap.get("CEF_TYPE"));
		
		Map<String, Object> insertMap = new HashMap<String, Object>();
		for(int i =0;i<jsonArr.length();i++) {
			jsonObj = jsonArr.getJSONObject(i);
			
			Iterator<Integer> itr = jsonObj.keys();
			
			while( itr.hasNext() )
			{
				String keyname  = String.valueOf(itr.next());
				
				String year = keyname.split("_")[0];
				String cef = keyname.split("_")[1];
				String fuel = keyname.split("_")[2]; //GWP 일 경우 해당 값은 GWP_GHG
				
				JSONArray depthArr = new JSONArray( String.valueOf(jsonObj.get(keyname)));
				JSONObject depthObj = new JSONObject();
				for(int d =0;d<depthArr.length();d++) {
					depthObj = depthArr.getJSONObject(d);
					insertMap = GridDataUtil.toMap(depthObj);
					
					insertMap.put("YEAR", year);
					insertMap.put("CEF_GUBUN", cef);
					insertMap.put("FUEL_DIV", fuel); //GWP 일 경우 해당 값은 GWP_GHG
					insertMap.put("VALUE", String.valueOf(insertMap.get("VALUE")).replaceAll(",", ""));
					
					if(CEF_TYPE.equals("1")) {
						insertMap.put("COLUMN", String.valueOf(insertMap.get("NAME")).split("_")[0] + "_" + String.valueOf(insertMap.get("NAME")).split("_")[1]  );
						insertMap.put("GUBUN", "FUEL_DIV");
					}else if(CEF_TYPE.equals("2")) {
						insertMap.put("COLUMN", String.valueOf(insertMap.get("NAME")).split("_")[0]);
						insertMap.put("GUBUN", "FUEL_DIV");
					}else if(CEF_TYPE.equals("4")) {
						insertMap.put("COLUMN", String.valueOf(insertMap.get("NAME")).split("_")[0] + "_" + String.valueOf(insertMap.get("NAME")).split("_")[1]  );
						insertMap.put("GUBUN", "GWP_GHG");
					}else if(CEF_TYPE.equals("5")) {
						insertMap.put("COLUMN", String.valueOf(insertMap.get("NAME")).split("_")[0] + "_" + String.valueOf(insertMap.get("NAME")).split("_")[1]  );
						insertMap.put("GUBUN", "FUEL_DIV");
					}
					
					standInfoMapper.standInfo004_save(insertMap);
					
				}
			}
		}
		return "저장되었습니다"; 
	}

	@Override
	public int standInfo004_insertYearData(HashMap<String, Object> paraMap) {
		return standInfoMapper.standInfo004_insertYearData(paraMap);
	}

	@Override
	public List standInfo004_checkYearData(HashMap<String, Object> paraMap) {
		return standInfoMapper.standInfo004_checkYearData(paraMap);
	}
	
}
