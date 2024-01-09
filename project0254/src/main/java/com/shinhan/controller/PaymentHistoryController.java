package com.shinhan.controller;



import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shinhan.model.PayHistorySearchService;
import com.shinhan.model.PaymentService;

@Controller
public class PaymentHistoryController {
	@Autowired
	PaymentService pService;
	
	@Autowired
	PayHistorySearchService phService;
	
	@GetMapping(value="/paymentHistory.do")
	public String displayPaymentHistory(Model model, HttpSession session) {
		
		
		return "paymentHistory";
	}
	
}
