package com.shinhan.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.shinhan.dto.LoginDTO;
import com.shinhan.dto.MemberVO;
import com.shinhan.dto.OwnerVO;
import com.shinhan.dto.SearchIdDTO;
import com.shinhan.dto.SearchPasswordDTO;
import com.shinhan.dto.SignUpDTO;
import com.shinhan.dto.StoreImgPathVO;
import com.shinhan.dto.StoreVO;
import com.shinhan.dto.kakaoLoginOwnerDTO;
import com.shinhan.model.LoginService;
import com.shinhan.model.OwnerService;
import com.shinhan.model.StoreService;
import com.shinhan.util.S3Upload;

@Controller
public class LoginController {
	Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	LoginService login_service;
	@Autowired
	StoreService sService;

	@Autowired
	OwnerService oService;

	@Autowired
	S3Upload s3upload;

	@RequestMapping("/onwerlogin.do")
	public String gohome() {
		return "jsp/onwerlogin.jsp";
	}
	
	
	
	@GetMapping("/naverEmpty.do")
	public String naverempty() {
		return "jsp/naverEmpty";
	}
	@GetMapping("/open.do")
	public String open(HttpSession session) {
		StoreVO store = (StoreVO)session.getAttribute("store");
		OwnerVO owner = (OwnerVO)session.getAttribute("owner");
		
		int result=sService.close(store);
		
		if(result==1) {
			List<StoreVO> store_list = sService.selectStoreByOwnerId(owner.getOwner_id());
			int index = 0;
			for(StoreVO store_vo :store_list) {
				if(store_vo.getStore_name().equals(store.getStore_name())) {
					break;
				}
				index++;
			}
			session.setAttribute("store",store_list.get(index));
			session.setAttribute("owner_store_id",store_list.get(index).getStore_id());
			session.setAttribute("owner_store_list", store_list);
		}
		
		System.out.println(result+"open++++");
		return "redirect:/main.do";
	}
	@GetMapping("/close.do")
	public String close(HttpSession session) {
		StoreVO store = (StoreVO)session.getAttribute("store");
		OwnerVO owner = (OwnerVO)session.getAttribute("owner");
		
		int result=sService.open(store);
		if(result==1) {
			List<StoreVO> store_list = sService.selectStoreByOwnerId(owner.getOwner_id());
			int index = 0;
			for(StoreVO store_vo :store_list) {
				if(store_vo.getStore_name().equals(store.getStore_name())) {
					break;
				}
				index++;
			}
			session.setAttribute("store",store_list.get(index));
			session.setAttribute("owner_store_id",store_list.get(index).getStore_id());
			session.setAttribute("owner_store_list", store_list);
		}
		System.out.println(result+"close++++");
		return "redirect:/main.do";
	}
	@PostMapping(value = "/naverlogin.do")
	public String naverlogin(String email, String nickname,HttpServletResponse response, HttpServletRequest request,
			RedirectAttributes attr, HttpSession session) {

		System.out.println("네이버 로그인 빈페이지 다음 ??");

		OwnerVO result = login_service.naverId_check(email);
		if (result != null) {
			System.out.println("Email" + email);
			//session.setAttribute("member", result);
			
			logger.info(result.toString());
			//session.setAttribute("member", result);
			
			logger.info(result.toString());
			List<StoreVO> store_list = sService.selectStoreByOwnerId(result.getOwner_id());
			
			session.setAttribute("owner", result);
			session.setAttribute("owner_id", result.getOwner_id());
			
			if(store_list.size()>0) {
				session.setAttribute("store",store_list.get(0));
				session.setAttribute("owner_store_id",store_list.get(0).getStore_id());
				session.setAttribute("owner_store_list", store_list);
			}else {
				return "redirect:/storeInsert.do";
			}
			
		} else {
			attr.addFlashAttribute("message", "해당 계정의 아이디가 없습니다.");
			attr.addFlashAttribute("email", email);
			attr.addFlashAttribute("nickname", nickname);
			return "redirect:/signUp.do";
		}
		return "redirect:/";

	}
	
	
	
	
	@GetMapping("/login.do")//, method=RequestMethod.GET)
	public String login(Model model,HttpServletRequest request, 
			@CookieValue(value = "id_save_owner",required = false) String id_save) {
		logger.info("요기왔어요2");
		logger.info("==================");
		
		Map<String,?> flashData = RequestContextUtils.getInputFlashMap(request);
		if(flashData!=null) {
			for(String key:flashData.keySet()) {
				logger.info(key+"==>"+flashData.get(key));
				model.addAttribute(key,flashData.get(key));
			}
		}
		if(id_save!=null) {
			model.addAttribute("id_save",id_save);
		}
		return "jsp/onwerlogin";
	}
	
	
	@GetMapping("/logout.do")
	String logout(HttpSession session) {
		session.removeAttribute("owner");
		session.removeAttribute("owner_id");
		session.removeAttribute("store");
		session.removeAttribute("owner_store_id");
		session.removeAttribute("owner_store_list");
		
		return "redirect:/";
	}
	
	@PostMapping("/kakaologinCheck.do")
	String kakao_login_check(Model model,kakaoLoginOwnerDTO login, HttpServletResponse response ,RedirectAttributes attr,HttpSession session) {
		//요기 수정해야함
		OwnerVO owner = login_service.kakao_login_check(login);
		if(owner!=null) {
			logger.info(owner.toString());
			session.setAttribute("member", owner);
			
			logger.info(owner.toString());
			List<StoreVO> store_list = sService.selectStoreByOwnerId(owner.getOwner_id());
			
			session.setAttribute("owner", owner);
			session.setAttribute("owner_id", owner.getOwner_id());
			
			if(store_list.size()>0) {
				session.setAttribute("store",store_list.get(0));
				session.setAttribute("owner_store_id",store_list.get(0).getStore_id());
				session.setAttribute("owner_store_list", store_list);
			}else {
				return "redirect:/storeInsert.do";
			}
		}else {
			attr.addFlashAttribute("message","해당 계정의 아이디가 없습니다.");
		    attr.addFlashAttribute("email",login.getEmail());
			return "redirect:/signUp.do";
		}
		return "redirect:/";
	}
	@GetMapping("/storeInsert.do")
	String storeInsert() {
		return "storeInsert/storeInsert";
	}
	@GetMapping("/storeUpdate.do")
	String storeUpdate(HttpSession session,Model model) {
		if(session.getAttribute("store")==null) {
			return "redirect:/";
		}
		StoreVO store=(StoreVO)session.getAttribute("store");	
		System.out.println(store);
		if(store.getStore_operation_hour()!=null) {
			String[] store_operation_hour = store.getStore_operation_hour().split("-");
			model.addAttribute("store_open_hour",store_operation_hour[0]);
			model.addAttribute("store_close_hour",store_operation_hour[1]);
		}
		if(store.getStore_made_in()!=null) {
			String made_in_str = store.getStore_made_in();
			String[] made_in_arr = made_in_str.split(",");
			model.addAttribute("made_in_arr",made_in_arr);
			model.addAttribute("made_in_index",made_in_arr.length);
		}
		return "storeInsert/storeUpdate";
	}
	
	@PostMapping("/storeUpdate.do")
	String storeUpdate_post(String[] store_made_in_arr,StoreVO store, HttpSession session,RedirectAttributes attr,MultipartHttpServletRequest multipart) {
		
		OwnerVO owner=(OwnerVO)session.getAttribute("owner");
		StoreVO now_store=(StoreVO)session.getAttribute("store");
		store.setStore_owner_id(owner.getOwner_id());
		store.setStore_avg_delivery_predict_time(30);
		String[] Store_operation_hour_arr = store.getStore_operation_hour().split(",");
		store.setStore_operation_hour(Store_operation_hour_arr[0]+"-"+Store_operation_hour_arr[1]);
		store.setStore_id(now_store.getStore_id());
		
		String store_made_in ="";
		for(int str_index=0; str_index< store_made_in_arr.length-1;str_index++) {
			if(str_index%2==0) {
				store_made_in += store_made_in_arr[str_index]+":";
			}else {
				store_made_in += store_made_in_arr[str_index]+",";
			}
		}
		store_made_in+=store_made_in_arr[store_made_in_arr.length-1];
		store.setStore_made_in(store_made_in);
		store.setStore_img_path(now_store.getStore_img_path());
		store.setStore_img_thumbnail_path(now_store.getStore_img_thumbnail_path());
		
		List<MultipartFile> fileList = multipart.getFiles("img_thumbnail_path_multipart");
		ServletContext application = session.getServletContext();
		
		long time = System.currentTimeMillis();
		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename(); 
			String saveFileName = String.format("%d_%s_%s", time,"thumbnail", originFileName);
			try {
				if(!originFileName.equals("")) {
					String img_path = s3upload.upload(mf, "store/",saveFileName);
					store.setStore_img_thumbnail_path(img_path);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		List<MultipartFile> fileList_img = multipart.getFiles("imgs_path_multipart");
		
		
		time = System.currentTimeMillis();
		for (MultipartFile mf : fileList_img) {
			String originFileName = mf.getOriginalFilename(); 
			String saveFileName = String.format("%d_%s", time, originFileName);
			try {
				if(!originFileName.equals("")) {
					System.out.println("originFileName"+originFileName+"==============");
					String img_path = s3upload.upload(mf, "store/",saveFileName);
					store.setStore_img_path(img_path);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		System.out.println(store);
		int result = sService.storeUpdate(store);
		if(result==0) {
			attr.addFlashAttribute("message","가게 업데이트가 실패했습니다.");
			return "redirect:/storeInsert.do";
		}
		List<StoreVO> store_list = sService.selectStoreByOwnerId(owner.getOwner_id());
		int index = 0;
		for(StoreVO store_vo :store_list) {
			if(store_vo.getStore_name().equals(store.getStore_name())) {
				break;
			}
			index++;
		}
		
		session.setAttribute("store",store_list.get(index));
		session.setAttribute("owner_store_id",store_list.get(index).getStore_id());
		session.setAttribute("owner_store_list", store_list);
		
		logger.info(store_list.toString());
		attr.addFlashAttribute("message","가게 업데이트가 성공했습니다.");
		
		return "redirect:/";
	}
	
	@PostMapping("/storeInsert.do")
	String storeInsert_post(String[] store_made_in_arr,StoreVO store, HttpSession session,RedirectAttributes attr,MultipartHttpServletRequest multipart) {
		OwnerVO owner=(OwnerVO)session.getAttribute("owner");
		System.out.println(store);
		store.setStore_owner_id(owner.getOwner_id());
		store.setStore_avg_delivery_predict_time(30);
		String[] Store_operation_hour_arr = store.getStore_operation_hour().split(",");
		store.setStore_operation_hour(Store_operation_hour_arr[0]+"-"+Store_operation_hour_arr[1]);
		String store_made_in ="";
		for(int str_index=0; str_index< store_made_in_arr.length-1;str_index++) {
			if(str_index%2==0) {
				store_made_in += store_made_in_arr[str_index]+":";
			}else {
				store_made_in += store_made_in_arr[str_index]+",";
			}
		}
		store_made_in+=store_made_in_arr[store_made_in_arr.length-1];
		store.setStore_made_in(store_made_in);
		
		List<MultipartFile> fileList = multipart.getFiles("img_thumbnail_path");
		ServletContext application = session.getServletContext();
		
		long time = System.currentTimeMillis();
		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename(); 
			String saveFileName = String.format("%d_%s_%s", time,"thumbnail", originFileName);
			try {
				if(!originFileName.equals("")) {
					String img_path = s3upload.upload(mf, "store/",saveFileName);
					store.setStore_img_thumbnail_path(img_path);
				}else {
					store.setStore_img_thumbnail_path(null);
				}
				//mf.transferTo(new File(path, saveFileName));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		List<MultipartFile> fileList_img = multipart.getFiles("imgs_path");
		time = System.currentTimeMillis();
		for (MultipartFile mf : fileList_img) {
			String originFileName = mf.getOriginalFilename(); 
			String saveFileName = String.format("%d_%s", time, originFileName);
			try {
				if(!originFileName.equals("")) {
					String img_path = s3upload.upload(mf, "store/",saveFileName);
					store.setStore_img_path(img_path);
				}else {
					store.setStore_img_path(null);
				}
				//mf.transferTo(new File(path, saveFileName));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		int result = sService.storeInsert(store);
		if(result==0) {
			attr.addFlashAttribute("message","가게 추가가 실패했습니다.");
			return "redirect:/storeInsert.do";
		}
		List<StoreVO> store_list = sService.selectStoreByOwnerId(owner.getOwner_id());
		int index = 0;
		for(StoreVO store_vo :store_list) {
			if(store_vo.getStore_name().equals(store.getStore_name())) {
				break;
			}
			index++;
		}
		session.setAttribute("store",store_list.get(index));
		session.setAttribute("owner_store_id",store_list.get(index).getStore_id());
		session.setAttribute("owner_store_list", store_list);
		attr.addFlashAttribute("message","가게 추가가 추가되었습니다.");
		
		return "redirect:/";
	}
	
	
	
	@PostMapping("/loginCheck.do")
	String login_check(LoginDTO login,boolean id_save,HttpServletResponse response ,RedirectAttributes attr,HttpSession session) {

		System.out.println("옴");
		logger.info("옴");
		logger.info(login.toString());
		if(id_save) {
			logger.info("아이디를 저장합니다.");
		}else{
			logger.info("아이디를 저장안함");
		}
		OwnerVO owner = login_service.login_cheak(login);
		if(owner!=null) {
			logger.info(owner.toString());
			List<StoreVO> store_list = sService.selectStoreByOwnerId(owner.getOwner_id());
			
			session.setAttribute("owner", owner);
			session.setAttribute("owner_id", owner.getOwner_id());
			
			if(store_list.size()>0) {
				session.setAttribute("store",store_list.get(0));
				session.setAttribute("owner_store_id",store_list.get(0).getStore_id());
				session.setAttribute("owner_store_list", store_list);
			}else {
				return "redirect:/storeInsert.do";
			}
			
			if(id_save) {
				Cookie cookie = new Cookie("id_save_owner",login.getId());
				cookie.setMaxAge(24 * 30 * 60 * 60 * 1000);
				response.addCookie(cookie);
			}else {
				Cookie cookie = new Cookie("id_save_owner",null);
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
		}else {
			attr.addFlashAttribute("message","아이디와 비밀번호가 일치하지 않습니다.");
			return "redirect:/login.do";
		}
		return "redirect:/main.do";
	}
	
	@GetMapping("/signUp.do")
	String sign_up_get(HttpServletRequest request,Model model) {
		Map<String,?> flashData = RequestContextUtils.getInputFlashMap(request);
		if(flashData!=null) {
			for(String key:flashData.keySet()) {
				logger.info(key+"==>"+flashData.get(key));
				model.addAttribute(key,flashData.get(key));
			}
		}
		return "jsp/join";
	}
	@PostMapping("/signUp.do")
	String sign_up_post(SignUpDTO signUp,RedirectAttributes attr) {
		logger.info(signUp.toString());
		int result=login_service.sign_up(signUp);
		if(result>0) {
			attr.addFlashAttribute("message", "회원 가입에 성공했습니다.");
		}else {
			attr.addFlashAttribute("message", "회원 가입에 실패했습니다.");
			return "redirect:/signUp.do";
		}
		return "redirect:/login.do";
	}
	
//	@GetMapping("/main.do")//, method=RequestMethod.GET)
//	public String main(Model model,@SessionAttribute("owner") OwnerVO owner) {
//		model.addAttribute("owner",owner);
//		return "main";
//	}
	
	@PostMapping("/search_id.do")
	public String search_id(SearchIdDTO search_id,RedirectAttributes attr) {
		logger.info(search_id.toString());
		String result=login_service.search_id(search_id);
		if(result == null) {
			attr.addFlashAttribute("message", "일치하는 아이디가 없습니다.");
		}else {
			attr.addFlashAttribute("message", "아이디는 "+result+" 입니다.");
		}
		return "redirect:/login.do";
	}
	@PostMapping("/search_password.do")
	public String search_password(SearchPasswordDTO search_password ,RedirectAttributes attr) {
		logger.info(search_password.toString());
		String result=login_service.search_password(search_password);
		if(result == null) {
			attr.addFlashAttribute("message", "일치하는 비밀번호가 없습니다.");
		}else {
			attr.addFlashAttribute("message", "비밀번호는 "+result+" 입니다.");
		}
		return "redirect:/login.do";
	}
	
	@PostMapping("storeNameCheck.do")
	@ResponseBody
	Map<String, Object> storeNameCheck(String store_name) {
		Map<String, Object> store = new HashMap<String, Object>();
		int result = sService.storeNameCheck(store_name);
		System.out.println(store_name + result);
		if(result>0) {
			store.put("result", true);
		}else {
			store.put("result", false);
		}
		return store;
	}
	
	@PostMapping("/registCodeCheck.do")
	@ResponseBody
	public Map<String, Object> registCodeCheck(String regist_code) {
		logger.info(regist_code);
		int result=login_service.regist_code_cheak(regist_code);
		Map<String, Object> regist_code_check = new HashMap<String, Object>();
		if(result>0) {
			regist_code_check.put("result", true);
		}else{
			regist_code_check.put("result", false);
		}
		return regist_code_check;
	}
	
	@PostMapping("/idCheck.do")
	@ResponseBody
	public Map<String, Object> idCheck(String id) {
		logger.info(id);
		int result=login_service.id_cheak(id);
		Map<String, Object> id_check = new HashMap<String, Object>();
		if(result>0) {
			id_check.put("result", true);
		}else{
			id_check.put("result", false);
		}
		return id_check;
	}

	@PostMapping("chageAddress.do")
	public String chageAddress(int index,HttpSession session) {
		List<StoreVO> store_list = (List<StoreVO>)session.getAttribute("owner_store_list");
		logger.info(store_list.toString());
		
		int owner_store_id = store_list.get(index).getStore_id();
		StoreVO store = store_list.get(index);
		
		session.setAttribute("owner_store_id", owner_store_id);
		session.setAttribute("store", store);
		
		// int owner_store_id = session.getAttribute("owner_store_id");
		// StoreVO store = session.getAttribute("store");
		
		return "redirect:main.do";
	}
	/*
	 * @PostMapping("/emailCheck.do")
	 * 
	 * @ResponseBody public Map<String, Object> emailCheck(String email) {
	 * logger.info(email); int result=login_service.email_cheak(email); Map<String,
	 * Object> email_check = new HashMap<String, Object>(); if(result>0) {
	 * email_check.put("result", true); }else{ email_check.put("result", false); }
	 * return email_check; }
	 * 
	 * @PostMapping("/phoneCheck.do")
	 * 
	 * @ResponseBody public Map<String, Object> phoneCheck(String phone) {
	 * logger.info(phone); int result=login_service.phone_cheak(phone); Map<String,
	 * Object> phone_check = new HashMap<String, Object>(); if(result>0) {
	 * phone_check.put("result", true); }else{ phone_check.put("result", false); }
	 * return phone_check; }
	 */
	/*
	 * @PostMapping("/registCodeCheck.do")
	 * 
	 * @ResponseBody public Map<String, Object> registCodeCheck(String regist_code)
	 * { logger.info(regist_code); int
	 * result=login_service.regist_code_cheak(regist_code); Map<String, Object>
	 * regist_code_check = new HashMap<String, Object>(); if(result>0) {
	 * regist_code_check.put("result", true); }else{ regist_code_check.put("result",
	 * false); } return regist_code_check; }
	 */
	
	
}
