package com.shinhan.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shinhan.model.StoreService;

@Controller
@RequestMapping("/subscribe")
public class SubscribeController {
	
	Logger logger = LoggerFactory.getLogger(StoreController.class);

	
	@Autowired
	StoreService storeService;


	
	@RequestMapping("/subscribeList.do")
	public String subscribeList(Model model) {
		System.out.println("구독 들어왔고");
		List<Map<Object, Object>> subscribeList = storeService.selectSubscribeStore();
		model.addAttribute("subscribeList", subscribeList);
		System.out.println("model 담음 : " + subscribeList);
		return "subscribelist";
	}
}
