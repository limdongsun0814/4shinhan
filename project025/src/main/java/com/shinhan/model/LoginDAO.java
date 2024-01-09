package com.shinhan.model;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.LoginDTO;
import com.shinhan.dto.MemberVO;
import com.shinhan.dto.SearchIdDTO;
import com.shinhan.dto.SearchPasswordDTO;
import com.shinhan.dto.kakaoLoginDTO;
import com.shinhan.dto.memberSingUpDTO;

@Repository
public class LoginDAO {
	
	@Autowired
	SqlSession sqlSession;
	String namespace = "com.shinhan.login.";
	
	public MemberVO login_check(LoginDTO login) {
		MemberVO result= sqlSession.selectOne(namespace + "login_check",login);
		System.out.println(result);
		return result;
	}
	
	public MemberVO kakao_login_check(kakaoLoginDTO login) {
		MemberVO result= sqlSession.selectOne(namespace + "kakao_login_check",login);
		System.out.println(result);
		return result;
	}
	//member 회원 가입
	public int sign_up(memberSingUpDTO sign_up) {
		int result=0;
		try {
			result=sqlSession.update(namespace + "sign_up",sign_up);
		}catch(Exception e) {
			
		}
		return result;
	}
	//member 이메일 중복 검사
	public int email(String id) {
		int result = sqlSession.selectOne(namespace + "email_cheak",id);
		System.out.println(result);
		return result;
	}
	//member 아이디 중복 검사
	public int id_cheak(String id) {
		int result = sqlSession.selectOne(namespace + "id_cheak",id);
		System.out.println(result);
		return result;
	}
	//member 아이디 찾기
	public String search_id(SearchIdDTO searchid) {
		String result = sqlSession.selectOne(namespace + "search_id",searchid);
		return result;
	}
	//member 패스워드 찾기
	public String search_password(SearchPasswordDTO searchpassword) {
		String result = sqlSession.selectOne(namespace + "search_password",searchpassword);
		return result;
	}

	public MemberVO naverId_check(String email) {
		MemberVO result = sqlSession.selectOne(namespace + "naver_login_check" , email);
		return result;
	}

}
