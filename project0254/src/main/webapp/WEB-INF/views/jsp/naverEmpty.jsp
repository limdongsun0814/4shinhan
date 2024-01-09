<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	
</head>
<body>
	<!-- <h1>여기는 네이버 빈 페이지</h1>
           <h1> 111111</h1> -->
           
          <!--  <div id="naver_id_login"></div>  -->
	<script type="text/javascript">

			var naver_id_login = new naver_id_login("hbIoYmlc3t7fBUU6dFmd",
					"http://localhost:9090/app4/naverEmpty.do");//	"http://localhost:9090/app/naverEmpty.do"
			/* var state = naver_id_login.getUniqState();
			naver_id_login.setButton("white", 2, 40);
			naver_id_login.setDomain(".service.com");
			naver_id_login.setState(state);
			naver_id_login.setPopup();
			naver_id_login.init_naver_id_login(); */

			naver_id_login.get_naver_userprofile("naverSignInCallback()");
			// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
			function naverSignInCallback() {
				console.log(naver_id_login);
				/* alert(naver_id_login.getProfileData('email')); */
			
		/* 	console.log(naver_id_login); */
			/* alert(naver_id_login.getProfileData('nickname'));  */
			var email = naver_id_login.getProfileData('email');
			var id = naver_id_login.getProfileData('id');
			var nickname = naver_id_login.getProfileData('nickname');
			/* 		alert(naver_id_login.getProfileData('age')); */

			var form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", "${cpath}/naverlogin.do");
			var input = document.createElement("input");
			input.setAttribute("type", "hidden");
			input.setAttribute("name", "email");
			input.setAttribute("value", email);
			form.appendChild(input);
			var input1 = document.createElement("input");
			input1.setAttribute("type", "hidden");
			input1.setAttribute("name", "nickname");
			input1.setAttribute("value", nickname + '#' + id.substr(0, 5));
			form.appendChild(input1);

			document.body.appendChild(form);
			form.submit();
		}
	</script>
</body>
</html>