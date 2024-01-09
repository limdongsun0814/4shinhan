package com.shinhan.model;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.MyReviewDTO;
import com.shinhan.dto.MyReviewVO;
import com.shinhan.dto.OwnerReviewDTO;
import com.shinhan.dto.PaymentVO;
import com.shinhan.dto.StoreNoticeDTO;
import com.shinhan.dto.StoreNoticeVO;

@Service
public class StoreReviewService {

	@Autowired
	StoreReviewDAO srdao;
	
	MyReviewDTO mrdto;
	PaymentVO payment;

	/*
	 * public List<MyReviewVO> selectReviewByStoreId(int payment_store_id) { return
	 * srdao.selectReviewByStoreId(payment_store_id); }
	 */

	public List<Date> selectPaymentDate(int payment_seq) {
		return srdao.selectPaymentDate(payment_seq);
	
	}

	public MyReviewVO selectReviewById(int payment_seq) {
		// TODO Auto-generated method stub
		return null;
	}

	public int addOwnerReview(OwnerReviewDTO dto) {
		return srdao.addOwnerReview(dto);
    }
	
	public List<MyReviewDTO> selectReviewByStore(int payment_store_id) {
		return srdao.selectReviewByStore(payment_store_id);
}
}
