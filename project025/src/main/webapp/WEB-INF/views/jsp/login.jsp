
<%@page import="java.net.URLEncoder"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/resources/jsp/login.jsp"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ page import="java.net.URLEncoder"%>
<c:set var="path" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<link
	href="${pageContext.request.contextPath}/resources/css/onwerlogin.css"
	type="text/css" rel="stylesheet" />

<link href="${pageContext.request.contextPath}/resources/css/loginmodal.css"
	type="text/css" rel="stylesheet"/>
<title>LOGIN | 빵이오</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!-- 로그인 -->
<div class="Maincontainer">
	<div class="container_login">
		<div class="loginText">Login</div>

		<div class="detailText">빵이오의 다양한 서비스와 혜택을 누리세요!</div>
		<form action="loginCheck.do" method="post">
			<div class="inputBox">
				<input name="id" value='${id_save!=null?id_save:""}' placeholder="아이디를 입력해주세요." required> 
				<input type="password" name="password" placeholder="비밀번호를 입력해주세요." required style="margin-top: 10px;">
			</div>

			<!-- 아이디 저장/아이디 찾기/비밀번호 찾기 -->
			<div class="rememberId">
				<div style="display: flex; align-items: center;">
					<input type="checkbox" class="checkbox" id="id_save" ${id_save!=null?"checked":""} name="id_save" > 
					<div>아이디 저장</div>
				</div>
				<div class="findIdPass">
					<div style="display: inline-block;" id="find_id_button">
						<a class="findId" style="cursor: pointer">아이디 찾기 </a>
					</div>
					<div style="display: inline-block;" id="search_password_button">
						<a class="findPass" style="cursor: pointer">| 비밀번호 찾기</a>
					</div>
				</div>
			</div>


			<button class="login" type="submit" style="cursor: pointer">Login</button>
		</form>

		<!-- 소셜로그인 -->
		<div class="simpleLogin">
			<div class="simpleLoginTitle">간편로그인</div>
			<div class="socialLogin">
				<!-- 네이버 로그인 -->
				<div id="naver_id_login" style="display: flex; align-items: center; justify-content: center;">
					<a class="naver" href="https://nid.naver.com/oauth2.0/authorize?response_type=token&client_id=z28qtKujeQl7xKP64hWZ&redirect_uri=http%3A%2F%2Flocalhost%3A9090%2Fapp%2FnaverEmpty.do&state=17d96457-86f6-4b13-845b-3f34c491a733" style="padding: 3px; cursor: pointer; font-weight: bold;">
						<img src="${pageContext.request.contextPath}/resources/images/naver.png" alt="네이버"> NAVER
					</a>
				</div>
				<!-- 카카오 로그인 -->
				<div class="kakao_div" style="display: flex; align-items: center;">
					<a class="kakao" onclick="kakaoLogin()" style="padding: 3px; cursor: pointer; font-weight: bold;">
						<img src="${pageContext.request.contextPath}/resources/images/kakao.png" alt="카카오"> KAKAO
					</a>
				</div>
			</div>
		</div>
	</div>
	</div>

	<!-- 아이디 찾기 -->
	<div id="find_id" class="hidden">
		<div id="find_id_content" class="find_modal">
			<span id="find_id_close"><i class="fa-solid fa-xmark"></i></span>
			<!-- <div class="bread_modal_image">
				<img src="${cpath}/resources/images/025logo.png" alt="로고">
			</div> -->
			<div class="find_id_title">아이디 찾기</div>
			<div class="find_id_div">
				<form action="search_id.do" method="post" class="find_id_form">
					<div class="find_id_element">
						<div>이름:&nbsp;</div>
						<input id="search_id_name" name="search_id_name" type="text" placeholder="이름을 입력해주세요." required="required">
					</div>
					<div class="find_id_element">
						<div>전화번호:&nbsp;</div>
						<input id="search_id_phone" name="search_id_phone" type="text" placeholder="전화번호를 입력해주세요." required="required">
					</div>
					<div class="find_id_element">
						<div>생년월일:&nbsp;</div>
						<input id="search_id_birthdate" name="search_id_birthdate" type="date" required="required">
					</div>
				 <div class="find_id_form_submit_div">
					   <label><input type="submit" value="조회하기" class="find_id_form_submit"></label>
				 </div>
				</form>
			</div>
			<!--  <button id="find_id_close">닫기</button> -->
		</div>
	</div>

	<!-- 비밀번호 찾기 -->
	<div id="search_password" class="hidden">
		<div id="search_password_content" class="find_modal">
			<span id="search_password_close"><i class="fa-solid fa-xmark"></i></span>
			<div class="search_password_title">비밀번호 찾기</div>
			<div class="search_password_div">
				<form action="search_password.do" method="post" class="find_id_form">
					<div class="search_password_element">
						<div>아이디:&nbsp;</div>
						<input id="search_password_id" name="search_password_id" type="text" placeholder="아이디를 입력해주세요." required="required">
					</div>
					<div class="search_password_element">
						<div>이름:&nbsp;</div>
						<input id="search_password_name" name="search_password_name" type="text" placeholder="이름을 입력해주세요." required="required">
					</div>
					<div class="search_password_element">
						<div>전화번호:&nbsp;</div>
						<input	id="search_password_phone" name="search_password_phone" type="text" placeholder="전화번호를 입력해주세요." required="required">
					</div>
					<div class="search_password_element">
						<div>생년월일:&nbsp;</div>
						<input id="search_password_brithday" name="search_password_brithday" type="date" required="required">
					</div>
					<div class="find_id_form_submit_div">
					   <label><input type="submit" value="조회하기" class="find_id_form_submit"></label>
				    </div>
				</form>
			</div>
			<!-- <button id="search_password_close">닫기</button> -->
		</div>
	</div>


	<script type="text/javascript">
		/* var url_arr = window.location.href.split('/');
		console.log(url_arr);
		var url = "";
		for(let i=0; i< 3; i++){
			url+=url_arr[i]+'/';
		}
		console.log(url); */
		//var naver_id_login = new naver_id_login("z28qtKujeQl7xKP64hWZ",
		//		url+"app/naverEmpty.do");
		//var state = naver_id_login.getUniqState();
		/* naver_id_login.setButton("white", 2, 40); */
		//naver_id_login.setDomain(".service.com");
		//naver_id_login.setState(state);
		//naver_id_login.setPopup();
		//naver_id_login.init_naver_id_login();

		// 네이버 사용자 프로필 조회
	/* 	naver_id_login.get_naver_userprofile("naverSignInCallback()");
		// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
		function naverSignInCallback() {
			console.log(naver_id_login);
			/* alert(naver_id_login.getProfileData('email'));
			alert(naver_id_login.getProfileData('nickname')); */
			//var email = naver_id_login.getProfileData('email');
			/* 		alert(naver_id_login.getProfileData('age')); 

			var form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", "${path}/naverlogin.do");
			var input = document.createElement("input");
			input.setAttribute("type", "hidden");
			input.setAttribute("name", "email");
			input.setAttribute("value", email);
			form.appendChild(input);

			document.body.appendChild(form);
			form.submit();
		} */
	</script>
	<script src="${pageContext.request.contextPath}/resources/js/login.js"></script>

	<br>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>