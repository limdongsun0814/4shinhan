<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/ownerHeader.css">
</head>
<body>
<div class="header">
	<div class="logo">
		<a href="${pageContext.request.contextPath}/">
			<img src="${pageContext.request.contextPath}/resources/images/0254logo.png" alt="로고" />
		</a>
	</div>
	<div class="auth">
		<a href="${pageContext.request.contextPath}/">회원가입</a>
		<a href="${pageContext.request.contextPath}/">로그인</a>
	</div>
</div>
</body>
</html>