package com.shinhan.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shinhan.dto.PayHistorySearchDTO;
import com.shinhan.dto.PaymentDTO;
import com.shinhan.dto.PaymentProductVO;
import com.shinhan.dto.PaymentVO;
import com.shinhan.model.PayHistorySearchService;
import com.shinhan.model.PaymentService;

@RestController
public class PaymentHistoryRestController {
	
	@Autowired
	PayHistorySearchService phService;
	
	@Autowired
	PaymentService pService;
	
	@GetMapping(value="/paymentHistoryList.do", produces = "application/json")
	public List<PaymentDTO> paymentHistory(HttpSession session, int webMonth, int webYear) {
		 int store_id = (int) session.getAttribute("owner_store_id");
		 int month = webMonth;
		 int year = webYear;
		 
		 PayHistorySearchDTO payHistory = PayHistorySearchDTO.builder().store_id(store_id).month(month).year(year).build();
		 List<PaymentDTO> paymentList = phService.payHistorySearchByMonth(payHistory);
		 System.out.println(paymentList.toString());
		 
		 Map<Integer, List<PaymentDTO>> map = new HashMap<Integer, List<PaymentDTO>>();
		 
		 List<PaymentDTO> tempList = null;
		 for(PaymentDTO payment : paymentList) {
			 tempList = map.get(payment.getPayment_date().toLocalDateTime().getDayOfMonth());
			 if(tempList!=null) {
				 tempList.add(payment); 
			 } else {
				 tempList = new ArrayList<PaymentDTO>();
				 tempList.add(payment);		 
			 }
			 map.put(payment.getPayment_date().toLocalDateTime().getDayOfMonth(), tempList);
			 
		 }
		 
		return paymentList;
	}
	
	@GetMapping(value="/paymentHistoryProduct.do", produces = "application/json")
	public List<PaymentProductVO> paymentProductHistory(int payment_seq){
		List<PaymentProductVO> ppList = pService.selectProductByPaymentId(payment_seq);
		System.out.println(ppList);
		return ppList;
	}
}
