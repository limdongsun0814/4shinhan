package com.shinhan.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.MyReviewSubmitDTO;
import com.shinhan.dto.MyReviewVO;
import com.shinhan.dto.MySubscribeDTO;
import com.shinhan.dto.OrderListDTO;

@Repository
public class MyPageDAO {
	
	@Autowired
	SqlSession sqlSession;
	String namespace = "com.shinhan.mypage.";
	Logger logger = LoggerFactory.getLogger(MyPageDAO.class);
	
	
	//내가 쓴 리뷰 가져오기
	public List<MyReviewVO> selectAllByPaymentId(String mid) {
		List<MyReviewVO> myReview = sqlSession.selectList(namespace + "selectAllByPaymentId", mid);
		return myReview;
	}
	
	//내가 쓴 리뷰 지우기
	public int deleteReview(int payment_id) {
		int result = sqlSession.delete(namespace + "deleteReview", payment_id);
		logger.info("delete review" ,result);
		return result;
	}

	//내 주문 정보 가져오기 (전체(픽업, 배달))
	public List<OrderListDTO> selectAllOrderList(String mid, String period) {
		Map<String, String> search = new HashMap<String, String>();
		search.put("mid", mid);		
		search.put("period", period);		
		List<OrderListDTO> myOrder = sqlSession.selectList(namespace + "selectAllOrderList", search);
		return myOrder;
	}
	
	//내 주문 상세정보 가져오기 (하나의 주문)
	public List<Map<Object, Object>> getOrderDetail(int payment_id) {
		List<Map<Object, Object>> myOrderDetail = sqlSession.selectList(namespace + "selectMyOrderDetail", payment_id);
		return myOrderDetail;
	}

	public List<OrderListDTO> selectPickUpOrder(String mid, String period) {
		Map<String, String> search = new HashMap<String, String>();
		search.put("mid", mid);		
		search.put("period", period);	
		List<OrderListDTO> myPickUp = sqlSession.selectList(namespace + "selectPickUpOrder", search);
		return myPickUp;
	}

	public List<OrderListDTO> selectDeliveryOrder(String mid, String period) {
		Map<String, String> search = new HashMap<String, String>();
		search.put("mid", mid);		
		search.put("period", period);	
		List<OrderListDTO> myDelivery = sqlSession.selectList(namespace + "selectDeliveryOrder", search);
		return myDelivery;
	}

	public List<MySubscribeDTO> getMySubList(String mid) {
		List<MySubscribeDTO> mySubscribe = sqlSession.selectList(namespace + "getMySubList", mid);
		return mySubscribe;
	}

	public int checkReview(int payment_seq) {
		int checkReview = sqlSession.selectOne(namespace + "checkReview", payment_seq);
		return checkReview;
	}

	public int submitReview(MyReviewSubmitDTO myReviewSubmitDTO) {
		int submitReview = sqlSession.insert(namespace + "submitReview", myReviewSubmitDTO);
		return submitReview;
	}

	public int submitReviewImg(Map<String, Object> params) {
		int submitReviewImg = sqlSession.update(namespace + "submitReviewImg", params);
		return submitReviewImg;
	}
}
