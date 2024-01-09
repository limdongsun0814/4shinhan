package com.shinhan.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.LoginDTO;
import com.shinhan.dto.MemberVO;
import com.shinhan.dto.SearchIdDTO;
import com.shinhan.dto.SearchPasswordDTO;
import com.shinhan.dto.kakaoLoginDTO;
import com.shinhan.dto.memberSingUpDTO;

@Service
public class LoginService {
	@Autowired
	LoginDAO login_dao;
	
	//member 로그인할 아이디,패스워드 확인
	public MemberVO login_check(LoginDTO login) {
		return login_dao.login_check(login);
	}
	public MemberVO kakao_login_check(kakaoLoginDTO login) {
		return login_dao.kakao_login_check(login);
	}
	
	//member 회원가입
	public int sign_up(memberSingUpDTO sign_up) {
		return login_dao.sign_up(sign_up);
	}
	
	//member 회원가입시 아이디중복 확인
	public int id_cheak(String id) {
		return login_dao.id_cheak(id);
	}
	
	//member 이메일중복 확인
	public int email_cheak(String email) {
		return login_dao.email(email);
	}
	
	//member 아이디 찾기
	public String search_id(SearchIdDTO searchid) {
		return login_dao.search_id(searchid);
	}
	
	//member 패스워드 찾기
	public String search_password(SearchPasswordDTO searchpassword) {
		return login_dao.search_password(searchpassword);
	}
	public MemberVO naverId_check(String email) {
		return login_dao.naverId_check(email);
	}

}
