package com.shinhan.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.net.http.HttpRequest;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.shinhan.dto.LoginDTO;
import com.shinhan.dto.MemberVO;
import com.shinhan.dto.SearchIdDTO;
import com.shinhan.dto.SearchPasswordDTO;
import com.shinhan.dto.kakaoLoginDTO;
import com.shinhan.dto.memberSingUpDTO;
import com.shinhan.model.LoginService;
import com.shinhan.model.MemberService;
import com.shinhan.util.Cart;

@Controller
public class LoginController {

	Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	LoginService login_service;
	@Autowired
	Cart cart;
	@Autowired
	MemberService member_service;
	
	
	@GetMapping("/naverEmpty.do")
	public String naverempty() {
		return "jsp/naverEmpty";
	}

	/*
	 * @GetMapping(value = "/naverlogin.do") public String naverRequestGet() {
	 * return "direct:/memberlogin.do"; }
	 */

	@PostMapping(value = "/naverlogin.do")
	public String naverlogin(String email, String nickname,HttpServletResponse response, HttpServletRequest request,
			RedirectAttributes attr, HttpSession session) {

		System.out.println("네이버 로그인 빈페이지 다음 ??");

		MemberVO result = login_service.naverId_check(email);
		if (result != null) {
			System.out.println("Email" + email);
			session.setAttribute("member", result);
		} else {
			attr.addFlashAttribute("message", "해당 계정의 아이디가 없습니다.");
			attr.addFlashAttribute("email", email);
			attr.addFlashAttribute("nickname", nickname);
			return "redirect:/memberjoin.do";
		}
		return "redirect:/home.do";

	}

	/*
	 * @RequestMapping(value = "/naverlogin.do", method = { RequestMethod.GET,
	 * RequestMethod.POST }) public String naverlogin(String email,
	 * HttpServletResponse response, HttpServletRequest request, RedirectAttributes
	 * attr, HttpSession session) {
	 * 
	 * if (email == null) { return "jsp/login";
	 * 
	 * } else { MemberVO result = login_service.naverId_check(email); if (result !=
	 * null) { System.out.println("Email" + email); session.setAttribute("member",
	 * result); } else { attr.addFlashAttribute("message", "해당 계정의 아이디가 없습니다.");
	 * return "redirect:/memberjoin.do"; } return "redirect:/home.do";
	 * 
	 * }
	 * 
	 * }
	 */

	@PostMapping("/kakaologinCheck.do")
	String kakao_login_check(Model model, kakaoLoginDTO login, HttpServletResponse response, RedirectAttributes attr,
			HttpSession session) {
		// 요기 수정해야함
		MemberVO member = login_service.kakao_login_check(login);
		if (member != null) {
			logger.info(member.toString());
			session.setAttribute("member", member);
		} else {
			attr.addFlashAttribute("message", "해당 계정의 아이디가 없습니다.");
			attr.addFlashAttribute("email", login.getEmail());
			attr.addFlashAttribute("nickname", login.getNickname());
			return "redirect:/memberjoin.do";
		}
		return "redirect:/home.do";
	}

	@GetMapping("/home.do") // , method=RequestMethod.GET)
	public String main(Model model, @SessionAttribute("member") MemberVO member, HttpServletRequest request,
			HttpSession session) {
		model.addAttribute("member", member);
		model = cart.mini_cart(model, session);
		System.out.println(member);
		Map<String, ?> flashData = RequestContextUtils.getInputFlashMap(request);
		if (flashData != null) {
			for (String key : flashData.keySet()) {
				logger.info(key + "==>" + flashData.get(key));
				model.addAttribute(key, flashData.get(key));
			}
		}
		return "home";
	}

	/*
	 * @GetMapping("/testlogin.do") public String testlogin(HttpSession session)
	 * throws UnsupportedEncodingException { return "naverloginTest"; }
	 * 
	 * @GetMapping("/Successnaverlogin.do") public String login_Success() { return
	 * "naverCallbackTest"; }
	 */

	// 로그인시 아이디,패스워드 확인
	@PostMapping("/loginCheck.do")
	String login_check(LoginDTO login, boolean id_save, HttpServletResponse response, RedirectAttributes attr,
			HttpSession session) {
		System.out.println(id_save);
		if (id_save) {
			logger.info("아이디를 저장합니다.");
		} else {
			logger.info("아이디를 저장안함");
		}
		MemberVO member = login_service.login_check(login);
		if (member != null) {
			logger.info(member.toString());
			session.setAttribute("member", member);
			if (id_save) {
				Cookie cookie = new Cookie("id_save", login.getId());
				cookie.setMaxAge(24 * 30 * 60 * 60 * 1000);
				response.addCookie(cookie);
			} else {
				Cookie cookie = new Cookie("id_save", null);
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
		} else {
			attr.addFlashAttribute("message", "아이디와 비밀번호가 일치하지 않습니다.");
			return "redirect:/memberlogin.do";
		}
		return "redirect:/home.do";
	}

	@GetMapping("/memberlogin.do")
	public String login(Model model, HttpServletRequest request, HttpSession session,
			@CookieValue(value = "id_save", required = false) String id_save) {
		Object member = session.getAttribute("member");
		if (member != null) {
			System.out.println(member + "tttttttttttttttttt");
			session.removeAttribute("member");
			return "redirect:/";
		}
		Map<String, ?> flashData = RequestContextUtils.getInputFlashMap(request);
		if (flashData != null) {
			for (String key : flashData.keySet()) {
				logger.info(key + "==>" + flashData.get(key));
				model.addAttribute(key, flashData.get(key));
			}
		}
		if (id_save != null) {
			model.addAttribute("id_save", id_save);
		}
		return "jsp/login";
	}

	@GetMapping("/memberjoin.do")
	String sign_up_get(HttpServletRequest request, Model model) {
		Map<String, ?> flashData = RequestContextUtils.getInputFlashMap(request);
		if (flashData != null) {
			for (String key : flashData.keySet()) {
				logger.info(key + "==>" + flashData.get(key));
				model.addAttribute(key, flashData.get(key));
			}
		}
		return "memberjoin";
	}

	@PostMapping("/kakaoMemberJoin.do")
	String kakao_member_join(Model model, String email, String nickname, RedirectAttributes attr, HttpSession session) {
		int result = login_service.email_cheak(email);
		System.out.println(email);
		if (result > 0) {
			attr.addFlashAttribute("message", "이미 가입된 아이디입니다.");
			return "redirect:/memberlogin.do";
		} else {
			model.addAttribute("email", email);
			model.addAttribute("nickname", nickname);
		}
		kakaoLoginDTO login = new kakaoLoginDTO();
		login.setEmail(email);
		login.setNickname(nickname);
		MemberVO member = login_service.kakao_login_check(login);
		session.setAttribute("member", member);
		return "redirect:/home.do";
	}

	@PostMapping("/memberjoin.do")
	String sign_up_post(memberSingUpDTO signUp, RedirectAttributes attr) {
		logger.info(signUp.toString());
		System.out.println("여기까는 오는것인가?");
		System.out.println(signUp.getId());
		System.out.println(signUp.getAddress_latitude());
		int result = login_service.sign_up(signUp);
		if (result > 0) {
			attr.addFlashAttribute("message", "회원 가입에 성공했습니다.");
			member_service.addBaseMemberAddress(signUp);
		} else {
			attr.addFlashAttribute("message", "회원 가입에 실패했습니다.");
			return "redirect:/memberjoin.do";
		}
		return "redirect:/memberlogin.do";
	}

	// member 로그인 페이지에서 owner 로그인 페이지로 넘어가기
	@GetMapping("/goOnwer.do")
	public String go_user() {
		return "redirect:http://127.0.0.1:9090/app4/login.do";
	}

	// member 아이디 찾기
	@PostMapping("/search_id.do")
	public String search_id(SearchIdDTO sarch_id, RedirectAttributes attr) {
		String result = login_service.search_id(sarch_id);
		if (result == null) {
			attr.addFlashAttribute("message", "일치하는 아이디가 없습니다.");
		} else {
			attr.addFlashAttribute("message", "아이디는 " + result + "입니다.");
		}
		return "redirect:/memberlogin.do";
	}

	// member 패스워드 찾기
	@PostMapping("/search_password.do")
	public String search_password(SearchPasswordDTO search_password, RedirectAttributes attr) {
		logger.info(search_password.toString());
		String result = login_service.search_password(search_password);
		if (result == null) {
			attr.addFlashAttribute("message", "일치하는 비밀번호가 없습니다.");
		} else {
			attr.addFlashAttribute("message", "비밀번호는 " + result + " 입니다.");
		}
		return "redirect:/memberlogin.do";
	}

	// member 회원가입시 아이디 중복 검사
	@PostMapping("/idCheck.do")
	@ResponseBody
	public Map<String, Object> idCheck(String id) {
		int result = login_service.id_cheak(id);
		Map<String, Object> id_check = new HashMap<String, Object>();
		if (result > 0) {
			id_check.put("result", true);
		} else {
			id_check.put("result", false);
		}
		return id_check;
	}
}
