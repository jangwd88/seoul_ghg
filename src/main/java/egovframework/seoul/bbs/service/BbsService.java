package egovframework.seoul.bbs.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import egovframework.seoul.entity.BbsVO;
import egovframework.seoul.entity.SpaceVO;

@SuppressWarnings("unused")
public interface BbsService {
		
		//게시글 작성 
		Integer insertBbs(HashMap paramMap) throws Exception;
		//게시글 상세보기
		BbsVO read(int bbs_no) throws Exception;
		//게시글 수정
		void update(BbsVO bbsVO) throws Exception;
		//게시글 수정 2
		Integer procUpdate(HashMap paramMap) throws Exception;
		//게시글 삭제
		void delete(int bbs_no) throws Exception;
		//게시글 검색목록 조회
		List<BbsVO> listAll(String type, String keyword, int start, int finish) throws Exception;
		//게시글 레코드 갯수
		public int getCount(String type, String keyword) throws Exception;
		//게시글 목록
		List<BbsVO> getList(int start, int finish);
	}
