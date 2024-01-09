package com.shinhan.model;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.MyReviewDTO;
import com.shinhan.dto.OwnerReviewDTO;

@Repository
public class StoreReviewDAO {

	@Autowired
	SqlSession sqlSession;
	String namespace = "net.firstzone.ownerReview.";

	/*
	 * public List<MyReviewVO> selectReviewByStoreId(int payment_store_id) {
	 * List<MyReviewVO> ownerReview = sqlSession.selectList(namespace +
	 * "selectReviewByStoreId", payment_store_id); return ownerReview;
	 * 
	 * }
	 */

	public List<MyReviewDTO> selectReviewByStore(int payment_store_id) {
		List<MyReviewDTO> ownerReview = sqlSession.selectList(namespace + "selectReviewByStore", payment_store_id);
		return ownerReview;

	}

	public List<Date> selectPaymentDate(int payment_seq) {
		List<Date> paymentDate = sqlSession.selectList(namespace + "selectPaymentDate", payment_seq);
		return paymentDate;
	}

	public int addOwnerReview(OwnerReviewDTO ownerReviewDTO) {
		int ownerReview = sqlSession.update(namespace + "addOwnerReview", ownerReviewDTO);
		return ownerReview;
	}

}
