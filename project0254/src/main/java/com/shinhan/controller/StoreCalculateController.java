package com.shinhan.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shinhan.dto.StoreVO;
import com.shinhan.model.StoreCalculateService;
import com.shinhan.model.StoreService;

@Controller
public class StoreCalculateController {

	@Autowired
	StoreCalculateService scService;
	
	@Autowired
	StoreService sService;
	
	Logger logger = LoggerFactory.getLogger(StoreCalculateController.class);
	
	@GetMapping("/storeCalculate.do")
	public String displayStoreCalculate(HttpSession session, Model model) {
		int storeId = (int) session.getAttribute("owner_store_id");
		StoreVO store = sService.selectStoreByStoreId(storeId);
		model.addAttribute("store", store);
		return "storeCalculateMain";
	}
	
}
