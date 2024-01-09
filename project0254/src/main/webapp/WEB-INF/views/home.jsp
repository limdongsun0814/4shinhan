<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/ownerHeader.jsp"%>
	<div class="all">
		<div class="side">
			<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>
		</div>

		<div class="content">
			<h1>오너 home.jsp</h1>
			<br> <br>

			<P>The time on the server is ${serverTime}.</P>
			<button onclick="location.href='main.do'">main.do 버튼</button>
			<button onclick="location.href='login.do'">로그인으로 가는 버튼</button>
			<button onclick="location.href='join.do'">회원가입으로가는 버튼</button>
			<button onclick="location.href='main_owner.do'" disabled="disabled" style="display: none;">오너메인화면 버튼</button>

		</div>
	</div>
	<script>

		setTimeout(alert_function,200);
		function alert_function(){
			var message = "${message}";
			console.log(message);
			if (message != "") {
				alert(message);
			}
		}
	</script>
</body>


<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
</html>
