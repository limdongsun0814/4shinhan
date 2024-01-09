package com.shinhan.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.MyReviewDTO;
import com.shinhan.dto.StoreNoticeDTO;
import com.shinhan.dto.StoreNoticeVO;

@Repository
public class StoreNoticeDAO {

	@Autowired
	SqlSession sqlSession;
	String namespace = "net.firstzone.storeNotice.";

	

	public List<StoreNoticeVO> StoreNoticeList(int store_notice_store_id) {
		List<StoreNoticeVO> storeNoticeList = sqlSession.selectList(namespace + "StoreNoticeList", store_notice_store_id);
		return storeNoticeList;

	}


	public StoreNoticeVO StoreNoticeSelect(int store_notice_seq) {
		StoreNoticeVO result = sqlSession.selectOne(namespace + "StoreNoticeSelect", store_notice_seq);
		return result;
	}

	public int StoreNoticeUpdate(StoreNoticeVO storeNotice) {
		int result = sqlSession.update(namespace + "StoreNoticeUpdate", storeNotice);
		return result;
	}
	
	public int StoreNoticeInsert(StoreNoticeDTO storeNotice) {
		int storeNoticeInsert = sqlSession.insert(namespace + "StoreNoticeInsert", storeNotice);
		return storeNoticeInsert;
	}
	
	public int StoreNoticeDelete(int store_notice_seq) {
		int result = sqlSession.delete(namespace + "StoreNoticeDelete", store_notice_seq);
		System.out.println("삭제dao체크");
		return result;
	}
	
}
