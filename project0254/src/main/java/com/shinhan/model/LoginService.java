package com.shinhan.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.LoginDTO;
import com.shinhan.dto.MemberVO;
import com.shinhan.dto.OwnerVO;
import com.shinhan.dto.SearchIdDTO;
import com.shinhan.dto.SearchPasswordDTO;
import com.shinhan.dto.SignUpDTO;
import com.shinhan.dto.kakaoLoginOwnerDTO;
import com.shinhan.dto.testVO;

@Service
public class LoginService {
	@Autowired
	LoginDAO login_dao;

	
	
	public OwnerVO naverId_check(String email) {
		return login_dao.naverId_check(email);
	}
	
	public OwnerVO login_cheak(LoginDTO login) {
		return login_dao.login_cheak(login);
	}
	
	public int id_cheak(String id) {
		return login_dao.id_cheak(id);
	}

	public OwnerVO kakao_login_check(kakaoLoginOwnerDTO login) {
		return login_dao.kakao_login_check(login);
	}
	
	/*
	 * public int email_cheak(String email) { return login_dao.email_cheak(email); }
	 */
	/*
	 * public int phone_cheak(String phone) { return login_dao.phone_cheak(phone); }
	 * public int regist_code_cheak(String regist_code) { return
	 * login_dao.regist_code_cheak(regist_code); }
	 */
	
	public int regist_code_cheak(String regist_code) {
		return login_dao.regist_code_cheak(regist_code);
	}
	
	public int sign_up(SignUpDTO sign_up) {
		return login_dao.sign_up(sign_up);
	}
	public String search_id(SearchIdDTO searchid) {
		return login_dao.search_id(searchid);
	}
	public String search_password(SearchPasswordDTO searchpassword) {
		return login_dao.search_password(searchpassword);
	}
	
	
}
