package egovframework.seoul.system.codeManage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Service
@Repository
public class CodeManageServiceImpl implements CodeManageService {

	@Autowired
	CodeManageMapper codeManageMapper;

	@Override
	public List<Map<String, Object>> masterCodeData(HashMap<String, Object> searchMap) throws Exception {
		return codeManageMapper.masterCodeData(searchMap);
	}

	@Override
	public List<Map<String, Object>> detailCodeData(HashMap<String, Object> searchMap) throws Exception {
		return codeManageMapper.detailCodeData(searchMap);
	}

	@Override
	public String addNUpdateCodeMaster(HashMap<String, Object> paraMap) throws Exception {

		paraMap.put("C_DEL_YN", paraMap.get("C_DEL_YN") == null ? "N" : "Y");
		paraMap.put("S_USE_YN", paraMap.get("S_USE_YN") == null ? "N" : "Y");
		paraMap.put("S_EDIT_YN", paraMap.get("S_EDIT_YN") == null ? "N" : "Y");

		codeManageMapper.addNUpdateCodeMaster(paraMap);
		return "코드구분이 저장되었습니다.";
	}

	@Override
	public String addNUpdateCodeDetail(HashMap<String, Object> paraMap) {
		paraMap.put("C_DEL_YN", paraMap.get("C_DEL_YN") == null ? "N" : "Y");

		codeManageMapper.addNUpdateCodeDetail(paraMap);
		return "코드구분이 저장되었습니다.";
	}

	@Override
	public String deleteCodeMaster(HashMap<String, Object> paraMap) {

		String[] deleteList = String.valueOf(paraMap.get("DELETE_LIST")).split(",");
		for (int i = 0; i < deleteList.length; i++) {
			String deleteId = deleteList[i];
			paraMap.put("ID_CAT", deleteId);
			codeManageMapper.deleteCodeMaster(paraMap);

		}
		return "코드가 삭제되었습니다.";
	}

	@Override
	public String deleteCodeDetail(HashMap<String, Object> paraMap) throws Exception {
		String[] deleteList = String.valueOf(paraMap.get("DELETE_LIST")).split(",");
		for (int i = 0; i < deleteList.length; i++) {
			String deleteId = deleteList[i];
			paraMap.put("ID_CODE", deleteId);
			codeManageMapper.deleteCodeDetail(paraMap);

		}
		return "코드가 삭제되었습니다.";
	}

}
