package com.shinhan.controller;

import java.util.HashMap;
import java.util.Map;

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
		SseEmitter sseObj = notificationService.subscribe(id);
		return sseObj;
	}
	
	
	//해당 id에 주문 현황 받기
	@CrossOrigin
	@ResponseBody
	@PostMapping("/send-data/{id}")
	public Map<String, Object> sendData(@PathVariable String id, @RequestBody Map<String, Object> reqMap){
		Map<String, Object> responseMap = new HashMap<String, Object>();
		
		System.out.println("알람 실횅");
		//id에서 payment_id만 추출
		System.out.println(reqMap.get("payment_id"));
		System.out.println(reqMap.get("status"));
		logger.info("요청 결제 seq",reqMap.get("payment_id"));
		logger.info("요청 결제 seq",reqMap.get("status"));
		
		notificationService.notify(id, reqMap);
		
		responseMap.put("sucessCheck", "주문 현황 변경완료.");		
		return responseMap;
	}
	
	
	
}