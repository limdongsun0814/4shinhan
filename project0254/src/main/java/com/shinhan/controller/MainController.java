package com.shinhan.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shinhan.dto.OwnerVO;
import com.shinhan.model.OwnerService;
import com.shinhan.model.StoreService;

@Controller
public class MainController {

	@Autowired
	OwnerService oService;
	@Autowired
	StoreService sService;
	
	Logger logger = LoggerFactory.getLogger(MainController.class);
	
	
	// @Autowired

	// public class EmpController {

	// @GetMapping("/")

	
	//(ID랑 비밀번호의 결과인 객체를 받는다)
	//Login PostMapping
	@GetMapping("/main.do")
	public String ownerMainDisplay(  Model model, HttpSession session){
//		System.out.println("메인화면");
//		OwnerVO owner = oService.selectByOwnerId("owner02");
//		System.out.println(owner.toString());
//		logger.info("메인화면 진입",owner.toString());
//		model.addAttribute("owner", owner);
//		session.setAttribute("owner_id", owner.getOwner_id());
//		sService.selectStoreByOwnerId(owner.getOwner_id());
//		session.setAttribute("store", sService.selectStoreByOwnerId(owner.getOwner_id()));
//		session.setAttribute("owner_store_id", sService.selectStoreByOwnerId(owner.getOwner_id()).getStore_id());
//		System.out.println(session.getAttribute("owner_store_id"));
		return "main";
	}
	

}
