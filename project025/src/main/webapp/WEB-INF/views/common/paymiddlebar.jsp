<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<c:set var="path" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>Insert title here</title>


<link href="${path}/resources/css/paymiddlebar.css" type="text/css"
	rel="stylesheet" />
</head>
<body>
	<div class="containermiddle">
		<!-- <div class="middle_bar"> -->
			<div class="middele_box">
				<div class="text1">주문 결제</div>
			    <div class="text2"><a href="${path}/cart.do">01 장바구니 ></a><a href="${path}/paymentInsert.do" > 02 주문/결제 ></a><a> 03 결제완료</a></div>
				<div class="front">
					<img class="pay01" id="pay01" src="/app/resources/images/pay01.png"
						alt="pay01img">
				</div>
				<div class="back">
					<img class="pay02" id="pay02" src="/app/resources/images/pay02.png"
						alt="pay02img">
				</div>
			</div>
		<!-- </div> -->
	</div>
</body>
</html>