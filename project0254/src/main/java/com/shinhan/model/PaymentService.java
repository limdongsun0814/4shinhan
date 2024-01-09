package com.shinhan.model;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.MemberIpDTO;
import com.shinhan.dto.PayStatusDTO;
import com.shinhan.dto.PaymentDTO;
import com.shinhan.dto.PaymentProductVO;
import com.shinhan.dto.PaymentVO;

@Service
public class PaymentService {
	@Autowired
	PaymentDAO dao;
	
	public List<PaymentVO> selectNowPaymentByStoreId(int store_id){
		return dao.selectNowPaymentByStoreId(store_id);
	}
	
	public List<PaymentProductVO> selectProductByPaymentId(int payment_id){
		return dao.selectProductByPaymentId(payment_id);
	}
	
	public List<MemberIpDTO> selectMemberPathByid(String ids){
		return dao.selectMemberPathByid(ids);
	}
	
	public List<PaymentDTO> selectNowPaymentDTOByStoreId(int store_id){
		return dao.selectNowPaymentDTOByStoreId(store_id);
	}
	
	public int updatePaymentStatus(PayStatusDTO payStatus) {
		return dao.updatePaymentStatus(payStatus);
	}

}
