package egovframework.seoul.invenCal.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Service
@Repository
public class InvenCalServiceImpl implements InvenCalService {

	@Autowired
	InvenCalMapper invenCalMapper;

	@SuppressWarnings("rawtypes")
	@Override
	public List invenCal001_search(HashMap<String, Object> searchMap) throws Exception {
		String gridDataArr = searchMap.get("year") == null ? "" : (String) searchMap.get("year");
		List<String> list = Arrays.asList(gridDataArr.split(","));
		searchMap.put("utilList", list);

		return invenCalMapper.invenCal001_search(searchMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List invenCal002_search(HashMap<String, Object> paraMap) throws Exception {
		String gridDataArr = paraMap.get("year") == null ? "" : (String) paraMap.get("year");
		List<String> list = Arrays.asList(gridDataArr.split(","));
		paraMap.put("utilList", list);

		return invenCalMapper.invenCal002_search(paraMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List invenCal003_search(HashMap<String, Object> paraMap) throws Exception {
		String gridDataArr = paraMap.get("year") == null ? "" : (String) paraMap.get("year");
		List<String> list = Arrays.asList(gridDataArr.split(","));
		paraMap.put("utilList", list);

		return invenCalMapper.invenCal003_search(paraMap);
	}

	@Override
	public List<Map<String, Object>> selectYearList(HashMap<String, Object> searchMap) {
		return invenCalMapper.selectYearList(searchMap);
	}

}
