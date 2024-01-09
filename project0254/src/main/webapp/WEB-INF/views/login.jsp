<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>Login | 빵이오4</title>
<link href="${path}/resources/css/login.css" type="text/css"
	rel="stylesheet" />
</head>
<body>
	<form action="loginCheck.do" method="post">
		아이디:<input name="id" value='${id_save!=null?id_save:""}'/> 
		비밀번호:<input name="password" />
		<!-- <button onclick="location.href='login_check.do'" >로그인</button> -->
		<input type="submit" value="로그인">
		아이디 저장:<input type="checkbox" id="id_save" name="id_save" ${id_save!=null?"checked":""}/>
	</form>
	<button onclick="location.href='signUp.do'">회원가입</button>
	<button id="find_id_button">아이디 찾기</button>
	<div id="find_id" class="hidden">
		<div id="find_id_content">
			<p>아이디 찾기</p>
			<form action="search_id.do" method="post">
				<input id="search_id_name" name="search_id_name" type="text"
					placeholder="이름을 입력해주세요"> <input id="search_id_regist_code"
					name="search_id_regist_code" type="text"
					placeholder="사업자 등록 번호를 입력해 주세요"> <input
					id="search_id_phone" name="search_id_phone" type="text"
					placeholder="휴대전화번호 뒤 7~8자리를 입력해주세요 (01x 제외)"> <input
					type="submit" value="조회 하기">
			</form>
			<button id="find_id_close">닫기</button>
		</div>
	</div>
	<button id="search_password_button">비밀번호 찾기</button>
	<div id="search_password" class="hidden">
		<div id="search_password_content">
			<p>비밀번호 찾기</p>
			<form action="search_password.do" method="post">
				<input id="search_password_id" name="search_password_id" type="text" placeholder="아이디를 입력해주세요"> 
				<input id="search_password_regist_code" name="search_password_regist_code" type="text"		placeholder="사업자 등록 번호를 입력해 주세요"> 
				<input	id="search_password_phone" name="search_password_phone" type="text"placeholder="휴대전화번호 뒤 7~8자리를 입력해주세요 (01x 제외)"> 
				<input type="submit" value="조회 하기">
			</form>
			<button id="search_password_close">닫기</button>
		</div>
	</div>
	
	<button onclick="location.href='onwerlogin.do'"> css를 해보자!</button>
	<%@include file="/resources/jsp/login.jsp"%>
	<script src="${path}/resources/js/login.js"></script>
</body>
</html>
