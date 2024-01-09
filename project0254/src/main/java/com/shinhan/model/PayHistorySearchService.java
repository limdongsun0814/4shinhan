package com.shinhan.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.PayHistorySearchDTO;
import com.shinhan.dto.PaymentDTO;
import com.shinhan.dto.PaymentVO;

@Service
public class PayHistorySearchService {
	@Autowired
	PayHistorySearchDAO dao;
	
	public List<PaymentDTO> payHistorySearchByMonth(PayHistorySearchDTO payHistory){
		return dao.payHistorySearchByMonth(payHistory);
	}
}
