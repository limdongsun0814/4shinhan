package com.shinhan.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.PaymentDTO;
import com.shinhan.dto.PaymentGetVO;
import com.shinhan.dto.PaymentOrderDTO;
import com.shinhan.dto.PaymentTypeVO;
import com.shinhan.dto.PaymentVO;
import com.shinhan.dto.getStoreId;
import com.shinhan.dto.paymentProductInsertDTO;
import com.shinhan.dto.paymentProductVO;



@Repository
public class PayMentDAO {
	
	
	@Autowired
	SqlSession sqlSession;
	String namespace = "com.shinhan.payment.";
	
	String namespace_member = "com.shinhan.member.";
	Logger logger = LoggerFactory.getLogger(PayMentDAO.class);
	
	
	//결제 타입 가져오기
	public List<PaymentTypeVO> selectAllPaymentType(){
		List<PaymentTypeVO> paymentType = sqlSession.selectList(namespace +"selectAllPaymentType");
		return paymentType;
	}
	public int insert_payment(PaymentDTO payment, getStoreId storeid) {
		System.out.println(payment.toString());
//		PaymentDTO payment_next = new PaymentDTO();payment_next=
		System.out.println(storeid);
		int Store_id=sqlSession.selectOne(namespace_member+"get_store_id", storeid);
		System.out.println("store_id++++"+Store_id);
		payment.setPayment_store_id(Store_id);
		sqlSession.selectOne(namespace + "insert_payment", payment);
		if(payment.getPayment_merchant_uid() != null) {
			int result=sqlSession.update(namespace + "paymentMerchantUidUpdate", payment);
			System.out.println(result+"paymentMerchantUidUpdate");
		}
		
		System.out.println(0);
		System.out.println(payment.toString());
		//System.out.println(payment_next.getPayment_seq());
		return payment.getPayment_seq();
	}
	public void insert_payment_product(paymentProductInsertDTO pay) {
		int result=sqlSession.insert(namespace+"insert_payment_product", pay);
		sqlSession.update(namespace+"menu_update",pay);
		System.out.println(result);
	}
	public String get_payment_date(int seq) {
		String result=sqlSession.selectOne(namespace+"get_payment_date", seq);
		System.out.println(result);
		return result;
	}
	public List<PaymentOrderDTO> selectPaymentByMemberId(String member_id){
		List<PaymentOrderDTO> paymentList = sqlSession.selectList(namespace + "selectPaymentByMemberId", member_id);
		return paymentList;
	}
	
	public List<PaymentGetVO> sellectAllPaymentGet(){
		List<PaymentGetVO> paymentGetList = sqlSession.selectList(namespace+"sellectAllPaymentGet");
		return paymentGetList;
	}
	
	public List<paymentProductVO> selectProductByPaymentId(int payment_seq){
		List<paymentProductVO> paymentProductList = sqlSession.selectList(namespace+"selectProductByPaymentId", payment_seq);
		return paymentProductList;
	}
	
	public List<paymentProductVO> selectAllProductByPaymentIdList(List<Integer> paySeqList){
		List<paymentProductVO> paymentProductList = sqlSession.selectList(namespace+"selectAllProductByPaymentIdList", paySeqList);
		return paymentProductList;
	}
	public int updatePaymentStatus(int seq, int status) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("seq", seq);
		map.put("status", status);
		
		int result = sqlSession.update(namespace+"updatePaymentStatus", map);
		return result;
	}
	
	
}
