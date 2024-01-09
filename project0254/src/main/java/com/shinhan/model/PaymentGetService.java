package com.shinhan.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.PaymentGetVO;

@Service
public class PaymentGetService {
	
	@Autowired
	PaymentGetDAO dao;
	
	public List<PaymentGetVO> sellectAllPaymentGet(){
		return dao.sellectAllPaymentGet();
	}
}
