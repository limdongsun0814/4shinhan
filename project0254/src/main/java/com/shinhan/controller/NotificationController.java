package com.shinhan.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.shinhan.dto.PaymentIpDTO;
import com.shinhan.dto.StoreVO;
import com.shinhan.model.NotificationService;
import com.shinhan.model.StoreService;

import lombok.RequiredArgsConstructor;

@Async
@RestController
@RequiredArgsConstructor
@RequestMapping("/notifications")
public class NotificationController {
	private final NotificationService notificationService;
	private static final Logger logger = LoggerFactory.getLogger(NotificationController.class);
	
	@Autowired
	StoreService sService;
	
	//구독 시작
	@CrossOrigin
	@GetMapping(value="/subscribe/{id}", produces="text/event-stream;charset=utf-8")
	public SseEmitter subscribe(@PathVariable String id) {
		String storeid = id.substring(7);
		StoreVO store = sService.selectStoreByStoreId(Integer.parseInt(storeid));

		System.out.println("구독 시작");
		SseEmitter sseObj = notificationService.subscribe(id, store);
		return sseObj;
	}
	
	
	//해당 id에 주문 공지 보내기
	@CrossOrigin
	@ResponseBody
	@PostMapping("/send-data/{id}")
	public Map<String, Object> sendData(@PathVariable String id, @RequestBody PaymentIpDTO pidto){
		Map<String, Object> responseMap = new HashMap<String, Object>();
		
		logger.info("요청 결제 seq",pidto.getPayment_id());
		notificationService.notify(id, pidto);
		
		responseMap.put("payment_seq", pidto.getPayment_id());
		responseMap.put("successCheck", "주문 확인 중입니다.");		
		return responseMap;
	}
	
}
