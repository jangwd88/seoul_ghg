package egovframework.seoul.bbs.service;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.seoul.entity.BbsVO;

@Service
public class BbsServiceImpl implements BbsService {

	@Autowired
	BbsMapper bbsMapper;

	@Override
	public Integer insertBbs(HashMap paramMap) throws Exception {
		return bbsMapper.insertBbs(paramMap);
	}

	@Override
	public BbsVO read(int bbs_no) throws Exception {
		return bbsMapper.read(bbs_no);
	}

	@Override
	public void update(BbsVO bbsVO) throws Exception {
		bbsMapper.update(bbsVO);
	}
	
	@Override
	public Integer procUpdate(HashMap paramMap) throws Exception {	
		return bbsMapper.procUpdate(paramMap);
	}
	
	@Override
	public void delete(int bbs_no) throws Exception {
		bbsMapper.delete(bbs_no);
	}

	@Override
	public List<BbsVO> listAll(String type, String keyword, int start, int finish) throws Exception {
		return bbsMapper.listAll(type,keyword,start, finish);
	}

	@Override
	public int getCount(String type, String keyword) throws Exception {
		return bbsMapper.getCount(type,keyword);
	}

	@Override
	public List<BbsVO> getList(int start, int finish) {
		return bbsMapper.getList(start,finish);
	}
	
}