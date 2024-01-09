package com.shinhan.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.MyReviewSubmitDTO;
import com.shinhan.dto.MyReviewVO;
import com.shinhan.dto.MySubscribeDTO;
import com.shinhan.dto.OrderListDTO;

@Service
public class MyPageService {
	
	@Autowired
	MyPageDAO dao;
	
	public List<MyReviewVO> selectAllByPaymentId(String  mid) {
		return dao.selectAllByPaymentId(mid);
	}

	public int deleteReview(int payment_id) {
		return dao.deleteReview(payment_id);
	}

	public List<OrderListDTO> selectAllOrderList(String mid, String period) {
		return dao.selectAllOrderList(mid, period);
	}

	public List<Map<Object, Object>> getOrderDetail(int payment_id) {
		return dao.getOrderDetail(payment_id);
	}

	public List<OrderListDTO> selectPickUpOrder(String mid, String period) {
		return dao.selectPickUpOrder(mid, period);
	}

	public List<OrderListDTO> selectDeliveryOrder(String mid, String period) {
		return dao.selectDeliveryOrder(mid, period);
	}
	
	public List<MySubscribeDTO> getMySubList(String mid) {
		return dao.getMySubList(mid);
	}

	public boolean checkReview(int payment_seq) {
		return dao.checkReview(payment_seq)>0;
	}

	public int submitReview(MyReviewSubmitDTO myReviewSubmitDTO) {
		return dao.submitReview(myReviewSubmitDTO);
	}

	public int submitReviewImg(Map<String, Object> params) {
		return dao.submitReviewImg(params);
		
	}
}
