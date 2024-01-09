package com.shinhan.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shinhan.dto.BestMenuDTO;
import com.shinhan.dto.MemberVO;
import com.shinhan.model.LoginService;
import com.shinhan.model.MenuService;
import com.shinhan.model.StoreService;
import com.shinhan.model.testDAO;
import com.shinhan.util.Cart;
import com.shinhan.util.S3Upload;


@Controller
public class HomeController {

	Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	testDAO test;

	@Autowired
	StoreService storeService;

	@Autowired
	MenuService menuService;

	@Autowired
	LoginService login_service;
	
	@Autowired
	Cart cart;

	@Autowired
	S3Upload s3upload;


	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);
		if(session.getAttribute("lng")==null) {
			session.setAttribute("lng", 126.92263631540145);
		}
		if(session.getAttribute("lat")==null) {
			session.setAttribute("lat", 37.55935630326601);
		}
		MemberVO member=(MemberVO)session.getAttribute("member");
		if(member!=null) {
			model = cart.mini_cart(model, session);
		}
		return "home";
	}

	@GetMapping("/sessionUpdateAddress.do")
	@ResponseBody
	public Map<String, Object> sessionUpdateAddress(Double lng, Double lat,HttpSession session){
		Map<String, Object> result = new HashMap<String, Object>();
		session.setAttribute("lng", lat);
		session.setAttribute("lat", lng);
		result.put("result", "업로드 성공");
		return result;
	}
	
	@RequestMapping("/memberjoinpage.do")
	public String join() {
		return "memberjoin";
	}

	@RequestMapping("/login.do")
	public String login() {
		return "jsp/login";
	}

	@GetMapping("/getBestMenuList.do")
	@ResponseBody
	public List<BestMenuDTO> getBestMenuList() {

		List<BestMenuDTO> menuList = menuService.getBestMenuList();

		return menuList;
	}

	@GetMapping("/uploadtest.test")
	public String uploadtest() {
		return "test2ㄷㅈㄱㄷㅈㅉ12-12-25";
	}


	@PostMapping("/uploadtest.test")
	public String uploadtestpost(MultipartHttpServletRequest multipart) {
		List<MultipartFile> fileList = multipart.getFiles("chooseFile");
		long time = System.currentTimeMillis();
		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename();
			String saveFileName = String.format("%d_%s", time, originFileName);
			try {
				s3upload.upload(mf, "store/", saveFileName);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "test2ㄷㅈㄱㄷㅈㅉ12-25";
	}
	@GetMapping("filter.do")
	public String filter(RedirectAttributes attr) {
		attr.addFlashAttribute("message","로그인이 필요한 기능입니다.");
		return "redirect:/memberlogin.do";
	}
}
