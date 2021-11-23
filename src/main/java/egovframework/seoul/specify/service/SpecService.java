package egovframework.seoul.specify.service;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

@SuppressWarnings("unused")
public interface SpecService {

	ArrayList listEmd(HashMap paramMap);

	ArrayList specArchList(HashMap paramMap);
	
	ArrayList listOfficer(HashMap paramMap);

	ArrayList selectOfficerList(Map<String, Object> requestMap);

	ArrayList listCons(HashMap paramMap);
	
	ArrayList selectConsList(Map<String, Object> requestMap);

	ArrayList listSpecArch(Map param);
	
	HashMap getTotalAmtTarget(HashMap paramMap);
	
	void updtTotalAmtTarget(HashMap paramMap);
	
}
