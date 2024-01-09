package com.shinhan.page;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.shinhan.controller.LoginController;

@Controller
public class PageController {
	
	Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	PageService pageService;
	
	@GetMapping("/getPage.do")
	public String itemView(Model model, @ModelAttribute("cri") ItemCriteria cri) throws Exception {
		
		model.addAttribute("menuList", this.pageService.itemList(cri));
		
		ItemPageMaker pageMaker = new ItemPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotal_count(this.pageService.itemCount(cri));
		
		model.addAttribute("pageMaker", pageMaker);
		return "itemView";
	}
}
