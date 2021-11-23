package egovframework.seoul.stat.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
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
public class StatServiceImpl implements StatService {

	@Autowired
	StatMapper statMapper;

	@Override
	public List<Map<String, Object>> getCode(HashMap<String, Object> searchMap) {
		return statMapper.getCode(searchMap);
	}

	@Override
	public List<Map<String, Object>> stat001_search(HashMap<String, Object> paraMap) throws Exception {

		String gridDataArr = paraMap.get("util") == null ? "" : (String) paraMap.get("util");
		List<String> list = Arrays.asList(gridDataArr.split(","));
		paraMap.put("utilList", list);

		List<String> energyList = new ArrayList<>();
		if (paraMap.get("energy0") != null) {
			energyList.add((String) paraMap.get("energy0"));
		}
		if (paraMap.get("energy1") != null) {
			energyList.add((String) paraMap.get("energy1"));
		}
		if (paraMap.get("energy2") != null) {
			energyList.add((String) paraMap.get("energy2"));
		}
		paraMap.put("energyList", energyList);

		List<Map<String, Object>> yearList = statMapper.selectYearList(paraMap);
		paraMap.put("yearList", yearList);

		return statMapper.stat001_search(paraMap);
	}

	@Override
	public List<Map<String, Object>> stat002_search(HashMap<String, Object> paraMap) throws Exception {

		String gridDataArr = paraMap.get("bjdong") == null ? "" : (String) paraMap.get("bjdong");
		List<String> list = Arrays.asList(gridDataArr.split(","));
		paraMap.put("bjdongList", list);

		List<String> energyList = new ArrayList<>();
		if (paraMap.get("energy0") != null) {
			energyList.add((String) paraMap.get("energy0"));
		}
		if (paraMap.get("energy1") != null) {
			energyList.add((String) paraMap.get("energy1"));
		}
		if (paraMap.get("energy2") != null) {
			energyList.add((String) paraMap.get("energy2"));
		}
		paraMap.put("energyList", energyList);

		List<Map<String, Object>> yearList = statMapper.selectYearList(paraMap);
		paraMap.put("yearList", yearList);

		return statMapper.stat002_search(paraMap);
	}

	@Override
	public List<Map<String, Object>> stat002_getBjdong(HashMap<String, Object> paraMap) throws Exception {
		String SCAT = String.valueOf(paraMap.get("S_CAT"));
		if (SCAT.equals("")) {
			paraMap.put("TYPE", "LIKE");
			paraMap.put("S_CAT", "BJDONG_");
		}
		return statMapper.getCode(paraMap);
	}

	@Override
	public Map<String, Object> selectMinMaxYear(HashMap<String, Object> searchMap) {
		return statMapper.selectMinMaxYear(searchMap);
	}

	@Override
	public List<Map<String, Object>> stat003_search(HashMap<String, Object> paraMap) throws Exception {
		paraMap.put("acu", 1);
		List<Map<String, Object>> yearList = statMapper.selectYearList(paraMap);
		paraMap.put("yearList", yearList);

		return statMapper.stat003_search(paraMap);
	}

	@Override
	public String stat003_saveBuilding(HashMap<String, Object> paraMap) throws Exception {

		String tableData = String.valueOf(paraMap.get("tableData"));
		int startYear = 0;
		int endYear = 0;

		JSONArray jsonArr = new JSONArray(tableData);
		JSONObject jsonObject = new JSONObject();
		HashMap<String, Object> insertMap = new HashMap<String, Object>();

		String mode = String.valueOf(paraMap.get("mode"));
		if (mode.equals("all")) {
			startYear = Integer.valueOf(String.valueOf(paraMap.get("startYear")));
			endYear = Integer.valueOf(String.valueOf(paraMap.get("endYear")));
		}

		for (int i = 0; i < jsonArr.length(); i++) {
			jsonObject = jsonArr.getJSONObject(i);
			insertMap = (HashMap<String, Object>) GridDataUtil.toMap(jsonObject);

			String isNew = String.valueOf(insertMap.get("ISNEW"));
			if (isNew.equals("old")) {
				insertMap.put("goalId", Integer.valueOf(String.valueOf(insertMap.get("buildingId"))));
			} else {
				insertMap.put("goalId", statMapper.stat003_getBuildingGoalId(paraMap));
			}

			insertMap.put("S_REG_ID", "TEST");
			statMapper.stat003_saveBuilding(insertMap);

			if (mode.equals("all")) {
				for (int y = startYear; y <= endYear; y++) {
					insertMap.put("yearId", statMapper.stat003_getYearGoalId(paraMap));
					insertMap.put("year", y);
					insertMap.put("toe", insertMap.get(y + "_toe"));
					insertMap.put("tco2eq", insertMap.get(y + "_tco2eq"));
					insertMap.put("reduction", insertMap.get(y + "_reduction"));

					statMapper.stat003_saveBuildingYear(insertMap);
				}
			}
		}
		return "저장이 완료되었습니다.";
	}
	@Override
	public String stat003_deleteBuilding(HashMap<String, Object> paraMap) throws Exception {
		
		String[] deleteList = String.valueOf(paraMap.get("DELETELIST")).split(",");
		for(int i =0;i<deleteList.length;i++) {
			paraMap.put("ID_BLD_GOAL_LIST", deleteList[i]);
			statMapper.stat003_deleteBuilding(paraMap);
		}
		
		
		return "삭제가 완료되었습니다.";
	}

	
	
	@Override
	public List<Map<String, Object>> stat003_getBuildingList(HashMap<String, Object> paraMap) throws Exception {
		return statMapper.stat003_getBuildingList(paraMap);
	}

}
