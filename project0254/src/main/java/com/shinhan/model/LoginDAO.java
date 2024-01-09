package com.shinhan.model;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.LoginDTO;
import com.shinhan.dto.MemberVO;
import com.shinhan.dto.OwnerVO;
import com.shinhan.dto.SearchIdDTO;
import com.shinhan.dto.SearchPasswordDTO;
import com.shinhan.dto.SignUpDTO;
import com.shinhan.dto.kakaoLoginOwnerDTO;

@Repository
public class LoginDAO  {
	@Autowired
	SqlSession sqlSession;
	String namespace = "com.shinhan.login.";
	
	public OwnerVO login_cheak(LoginDTO login) {
		OwnerVO result = sqlSession.selectOne(namespace + "login_cheak",login);
		System.out.println(result);
		return result;
	}
	public int id_cheak(String id) {
		int result = sqlSession.selectOne(namespace + "id_cheak",id);
		System.out.println(result);
		return result;
	}
	
	public OwnerVO kakao_login_check(kakaoLoginOwnerDTO login) {
		OwnerVO result= sqlSession.selectOne(namespace + "owner_kakao_login_check",login);
		System.out.println(result);
		return result;
	}
	
	/*
	 * public int email_cheak(String email) { int result =
	 * sqlSession.selectOne(namespace + "email_cheak",email);
	 * System.out.println(result); return result; }
	 */
	/*
	 * public int phone_cheak(String phone) { int result =
	 * sqlSession.selectOne(namespace + "phone_cheak",phone);
	 * System.out.println(result); return result; }
	 */
	public int regist_code_cheak(String regist_code) {
		int result = sqlSession.selectOne(namespace + "regist_code_cheak",regist_code);
		System.out.println(result);
		return result;
	}
	
	public int sign_up(SignUpDTO sign_up) {
		int result = 0;
		try{
		result=sqlSession.update(namespace + "sign_up",sign_up);
		}catch (Exception e) {
		}
		System.out.println(result);
		return result;
	}
	public String search_id(SearchIdDTO searchid) {
		String result = sqlSession.selectOne(namespace + "search_id",searchid);
		return result;
	}
	public String search_password(SearchPasswordDTO searchpassword) {
		String result = sqlSession.selectOne(namespace + "search_password",searchpassword);
		return result;
	}
	public OwnerVO naverId_check(String email) {
		OwnerVO onwer = sqlSession.selectOne(namespace + "naver_check" ,email);
		return onwer;
	}
	
}
