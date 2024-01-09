package com.shinhan.controller;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shinhan.dto.MyReviewDTO;
import com.shinhan.dto.OwnerReviewDTO;
import com.shinhan.model.PaymentService;
import com.shinhan.model.StoreReviewService;

@Controller
public class StoreReviewController {

	@Autowired
	StoreReviewService srService;

	@Autowired
	PaymentService pService;

	Logger logger = LoggerFactory.getLogger(MainController.class);

	MyReviewDTO myReview;

	@GetMapping("/storeReview.do")
	public String selectReviewByStore(HttpSession session, Model model) {

		int storeId = (int) session.getAttribute("owner_store_id");

		/*
		 * List<Date> paymentDate = srService.selectPaymentDate(storeId);
		 * model.addAttribute("paymentDate", paymentDate);
		 */

		List<MyReviewDTO> myReviewList = srService.selectReviewByStore(storeId);
		// System.out.println(myReviewList.get(0));

		model.addAttribute("myReviewList", myReviewList);
		System.out.println(storeId);
		System.out.println(myReviewList);
		return "storeReview";

	}

	@PostMapping("/addOwnerReview.do")
	public String addOwnerReview(@RequestParam("payment_seq") int paymentSeq,
			@RequestParam("ownerReviewContent") String ownerReviewContent) {
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		OwnerReviewDTO dto = OwnerReviewDTO.builder().payment_seq(paymentSeq).owner_review_content(ownerReviewContent)
				.owner_review_date(currentTime).build();
		
		srService.addOwnerReview(dto);

		return "redirect:storeReview.do";
	}

	/*
	 * 
	 * System.out.println("확인2차" + storeId); List<PushAlarmVO> pushAlarmList =
	 * pService.PushAlarmList(storeId); System.out.println("확인" + pushAlarmList);
	 * List<ArrayList<PushAlarmVO>> result_AlarmList = new
	 * ArrayList<ArrayList<PushAlarmVO>>(); int cnt=0; int index = 0;
	 * result_AlarmList.add(new ArrayList<PushAlarmVO>());
	 * 
	 */
}
