package com.shinhan.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.PaymentDTO;
import com.shinhan.dto.PaymentGetVO;
import com.shinhan.dto.PaymentOrderDTO;
import com.shinhan.dto.PaymentTypeVO;
import com.shinhan.dto.PaymentVO;
import com.shinhan.dto.getStoreId;
import com.shinhan.dto.paymentProductInsertDTO;
import com.shinhan.dto.paymentProductVO;


@Service
public class PayMentService {
	
	@Autowired
	PayMentDAO dao;
	
	public List<PaymentTypeVO> selectAllPaymentType(){
		return dao.selectAllPaymentType();
	}
	public int insert_payment(PaymentDTO payment,getStoreId storeid) {
		return dao.insert_payment(payment,storeid);
	}

	public void insert_payment_product(paymentProductInsertDTO pay) {
		dao.insert_payment_product(pay);
	}
	public String get_payment_date(int seq) {
		return dao.get_payment_date(seq);
	}
	
	public List<PaymentOrderDTO> selectPaymentByMemberId(String member_id){
		return dao.selectPaymentByMemberId(member_id);
	}
	
	public List<PaymentGetVO> sellectAllPaymentGet(){
		return dao.sellectAllPaymentGet();
	}
	
	public List<paymentProductVO> selectProductByPaymentId(int payment_seq){
		return dao.selectProductByPaymentId(payment_seq);
	}
	
	public List<paymentProductVO> selectAllProductByPaymentIdList(List<Integer> paySeqList){
		return dao.selectAllProductByPaymentIdList(paySeqList);
	}
	public int updatePaymentStatus(int seq, int status) {
		return dao.updatePaymentStatus(seq, status);
		
	}
}
