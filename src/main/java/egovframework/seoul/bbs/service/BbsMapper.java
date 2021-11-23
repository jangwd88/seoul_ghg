package egovframework.seoul.bbs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import egovframework.seoul.entity.BbsVO;

@Mapper
@Repository
public class BbsMapper extends EgovAbstractMapper{

	public Integer insertBbs(HashMap paramMap) {
		return insert("bbsMapper.insertBbs", paramMap);
	}

	public BbsVO read(int bbs_no) {
		return selectOne("bbsMapper.read",bbs_no);
	}

	public void update(BbsVO bbsVO) {
		update("bbsMapper.update",bbsVO);
		
	}

	public Integer procUpdate(HashMap paramMap) {
		return update("bbsMapper.procUpdate",paramMap);
	}
	
	public void delete(int bbs_no) {
		delete("bbsMapper.delete",bbs_no);
	}

	public List<BbsVO> listAll(String type, String keyword, int start, int finish) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("type",type);
		map.put("keyword",keyword);
		map.put("start",start);
		map.put("finish",finish);
		return selectList("bbsMapper.listAll",map);
	}

	public int getCount(String type, String keyword) {
		Map<String, String> map = new HashMap<String,String>();
		map.put("type",type);
		map.put("keyword",keyword);
		return selectOne("bbsMapper.getCount",map);
	}

	public List<BbsVO> getList(int start, int finish) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("start",start);
		map.put("finish",finish);
		return selectList("bbsMapper.getList",map);
	}
}
