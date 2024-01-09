package com.shinhan.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.shinhan.dto.PayStatusDTO;
import com.shinhan.dto.PaymentDTO;
import com.shinhan.dto.PaymentProductVO;
import com.shinhan.dto.PaymentVO;
import com.shinhan.dto.StoreVO;
import com.shinhan.model.PaymentGetService;
import com.shinhan.model.PaymentService;
import com.shinhan.model.StoreService;
import com.shinhan.util.NowPath;

@Controller
public class PaymentController {
	
	@Autowired
	PaymentService pService;
	
	@Autowired
	PaymentGetService pgService;
	
	@Autowired
	StoreService sService;
	
	@GetMapping("/payment.do")
	public String paymentMain(HttpSession session, Model model, HttpServletRequest request) {
		int owner_store_id = (int)session.getAttribute("owner_store_id");
		
		NowPath nowPath = new NowPath(request);
		//path 다를 경우 session에 set
		StoreVO store = sService.selectStoreByStoreId(owner_store_id);
		if(store.getStore_ip_path() == null || !store.getStore_ip_path().equals(nowPath)) {
			sService.updateStorePathById(owner_store_id, nowPath.getNowPath());
			store.setStore_ip_path(nowPath.getNowPath());
			session.setAttribute("store", store);
		}
		return "payment";
	}
	
	
	@GetMapping("/paymentStatus.do")
	public String paymentDisplay(HttpSession session, Model model, HttpServletRequest request) throws UnknownHostException {
		System.out.println("주문접수 페이지");
		
		InetAddress ipAddress = InetAddress.getLocalHost();
		String protocol = request.isSecure()?"https://":"http://";
		String nowPath = protocol+ipAddress.getHostAddress()+":"+request.getServerPort()+request.getContextPath();
		int owner_store_id = (int)session.getAttribute("owner_store_id");
		
		//path 다를 경우 session에 set
		StoreVO store = sService.selectStoreByStoreId(owner_store_id);
		if(store.getStore_ip_path() == null || !store.getStore_ip_path().equals(nowPath)) {
			sService.updateStorePathById(owner_store_id, nowPath);
			store.setStore_ip_path(nowPath);
			session.setAttribute("store", store);
		}
		
		
		List<PaymentDTO> paymentListNow = pService.selectNowPaymentDTOByStoreId((int)session.getAttribute("owner_store_id")); 
		
		Map<Integer, List<PaymentProductVO>> paymantProductMap = new HashMap<Integer, List<PaymentProductVO>>();
		
		
		//주문 별 품목 불러와서 map에 넣기
		int payment_seq = 0;
		for(PaymentDTO payment : paymentListNow) {
			System.out.println(payment.toString());
			payment_seq = payment.getPayment_seq();
			paymantProductMap.put(payment_seq, pService.selectProductByPaymentId(payment_seq));
		}


		System.out.println("map"+paymantProductMap);
		
		//추후에 DTO 만들어서 바꾸기
		model.addAttribute("paymentGetList", pgService.sellectAllPaymentGet());
		model.addAttribute("paymantProductMap", paymantProductMap);
		model.addAttribute("paymentListNow",paymentListNow);
		return "/jsp/storePaymentStatus";
	}
	
	//status만 업데이트? 업데이트된 상태. 받아올 때 
	@PostMapping("/updatePaymentStatus.do")
	public String updatePaymentStatus(HttpServletRequest request, Model model) {
		int seq = Integer.parseInt(request.getParameter("seq"));
		int status = Integer.parseInt(request.getParameter("status"));
		int get = Integer.parseInt(request.getParameter("get"));
		String path = request.getParameter("path");
		String member_id = request.getParameter("member_id");
		System.out.println(member_id);
		//이전 상태 따라 다음 상태로 진행
		switch (status) {
		case 0:
			status = 1;
			break;
		case 1:
			status = 2;
			break;
		case 2:
			if(get == 2){
				//픽업
				status = 4;
			} else {
				status = 3;
			}
			break;
		case 3:
			status = 4;
			break;
		case 4:
			status = 4;
		case 11: //거절 누를 경우 거절 완료로?
			status = 12;
		default:
			break;
		}
		
		PayStatusDTO paystatus = PayStatusDTO.builder().payment_seq(seq).payment_status_id(status).payment_get_id(get).build();
		model.addAttribute("paystatus", paystatus);
		model.addAttribute("path", path);
		model.addAttribute("member_id", member_id);
		return pService.updatePaymentStatus(paystatus)>0?"/jsp/payUpdateSuccess":"payUpdatefail";
	}
	
}
