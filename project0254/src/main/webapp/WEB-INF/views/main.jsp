<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home | 빵이오4</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css">
<style>

.grid_wrapper {
	width:90%;
}
.grid-container {
	display: grid;
	grid-template-columns: auto auto auto;
	grid-template-rows: 19rem 19rem;
	gap: 20px;
	padding: 25px 30px;
	margin: 1% 4%;
}

.grid-container > .menu_box {
	background-color: #F8EAC7;
	text-align: center;
	line-height: 18rem;
	font-size: 30px;
	border-radius:10px;
	box-shadow:2px 3px 3px rgba(0,0,0,0.2);
	font-size:1.8rem;
	font-weight:600;
}

.grid-container > .menu_box:hover{
	background-color:#D4C570;
}

.content {
	width: 80%; 
	align-items:center;
}

</style>

</head>
<link href="${pageContext.request.contextPath}/resources/css/slide.css" rel="stylesheet" type="text/css">
<body>
	<%@ include file="/WEB-INF/views/common/ownerHeader.jsp"%>
	<div class="all">
		<div class="side">
			<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>
		</div>
		<div class="content">
				<div class="grid_wrapper">
				<div class="grid-container">
					<!-- 6개짜리틀 -->
					<div class="menu_box" onclick="location.href='payment.do'">주문접수</div>
					<div class="menu_box" onclick="location.href='paymentHistory.do'">주문내역</div>
					<div class="menu_box" onclick="location.href='menuList.do'">재고관리</div>
					<div class="menu_box" onclick="location.href='pushAlarmList.do'">알림보내기</div>
					<div class="menu_box" onclick="location.href='storeNotice.do'">가게 공지사항</div>
					<div class="menu_box" onclick="location.href='storeCalculate.do'">가게분석</div>
				</div>
				</div>
				<!-- 큰틀 -->
				
				<div class="notice">
					<%@ include file="/WEB-INF/views/common/slide.jsp"%>
				</div>
				
		</div>
	</div>
	<!-- 이벤트 -->
   
<script src="https://kit.fontawesome.com/f719d238b7.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/slide.js" type="text/javascript"></script>


</body>
<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
</html>