package com.shinhan.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shinhan.dto.MemberVO;
import com.shinhan.dto.PaymentGetVO;
import com.shinhan.dto.PaymentOrderDTO;
import com.shinhan.dto.PaymentVO;
import com.shinhan.dto.StoreVO;
import com.shinhan.dto.paymentProductVO;
import com.shinhan.model.CartService;
import com.shinhan.model.MemberService;
import com.shinhan.model.PayMentService;
import com.shinhan.util.NowPath;

@Controller
@RequestMapping("/payment")
public class PaymentController {
	
	@Autowired
	PayMentService pService;
	
	@Autowired
	MemberService mService;

	
	@GetMapping("/orderStatus.do")
	public String displayOrderList(Model model, HttpServletRequest request, HttpSession session) {
//		List<PaymentVO> paymentList=pService.selectPaymentByMemberId(((MemberVO) session.getAttribute("member")).getMember_id());
//		model.addAttribute("paymentList", paymentList);
		
		NowPath nowPath = new NowPath(request);
		//path 다를 경우 session에 set
		MemberVO member = (MemberVO) session.getAttribute("member");
		if(member.getMember_ip_path() == null || !member.getMember_ip_path().equals(nowPath.getNowPath())) {
			mService.updateMemberPathById(member.getMember_id(), nowPath.getNowPath());
			member.setMember_ip_path(nowPath.getNowPath());
			session.setAttribute("member", member);
		}
		
		return "orderStatus";
	}
	
	@GetMapping("/orderStatusList.do")
	public String displayOrderStatusList(Model model, HttpSession session) {
		List<PaymentOrderDTO> paymentList=pService.selectPaymentByMemberId(((MemberVO) session.getAttribute("member")).getMember_id());
		List<PaymentGetVO> paymentGetList = pService.sellectAllPaymentGet();
		
		
		Map<Integer, List<paymentProductVO>> paymentProductMap = new HashMap<Integer, List<paymentProductVO>>();
		
		//처리용 임시 변수명
		List<paymentProductVO> paymentProductList;
		
		List<Integer> paySeqList = new ArrayList<Integer>();
		//주문 별 품목 불러와서 map에 넣기
		for(PaymentOrderDTO payment : paymentList) {
			paySeqList.add(payment.getPayment_seq());
		}

		paymentProductList = pService.selectAllProductByPaymentIdList(paySeqList);
		
		for(PaymentOrderDTO payment : paymentList) {
			List<paymentProductVO> tempProductList = new ArrayList<paymentProductVO>();
			for(paymentProductVO paymentProduct:paymentProductList) {
				if(payment.getPayment_seq() == paymentProduct.getPayment_product_payment_id()) {
					tempProductList.add(paymentProduct);
				}
			}
			paymentProductMap.put(payment.getPayment_seq(), tempProductList);
		}
		System.out.println(paymentProductMap);
		
		
		
		
		model.addAttribute("paymentProductMap", paymentProductMap);
		model.addAttribute("paymentList", paymentList);
		model.addAttribute("paymentGetList", paymentGetList);
		
		
		
		return "orderStatusList";
	}
	
	
	@PostMapping("/updatePaymentStatus.do")
	public String updatePaymentStatus(HttpServletRequest request, Model model) {
		int status = Integer.parseInt(request.getParameter("status"));
		int seq = Integer.parseInt(request.getParameter("seq"));
		if(status==4) {
			status = 5;
			pService.updatePaymentStatus(seq, status);
		}
		
		return "redirect:/payment/orderStatus.do";
	}
}
