<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- <%@ include file="/WEB-INF/views/common/ownerHeader.jsp" %> --%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home2.css">
<script src="https://kit.fontawesome.com/f719d238b7.js" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/common/prepareModal.jsp"%>
<aside class="side-bar">
	<div class="sidebar">
		<div class="container">
			<div class="owner">${owner.owner_name} 사장님</div>
			
			<div class="edit">
				<img src="${pageContext.request.contextPath}/resources/images/edit.png">
			</div>
		</div>
		<div class="whitebox">
			<div class="updateStatus">
				<i class="fa-solid fa-clipboard-list" onclick="location.href='payment.do'"></i>
				<div class="now_order">주문현황</div>
			</div>
			<div class="updateStatus">
				<i class="${store.store_is_open?'fa-solid fa-store':'fa-solid fa-store-slash'}" onclick="location.href='${store.store_is_open?'open.do':'close.do'}'"></i>
				<div class="open_close_store">${store.store_is_open?'영업시작':'영업종료'}</div>
			</div>
		</div>
		<br><br>
		<div id="nav">
		 <ul class="menu">
		  <li>내 가게 관리
		   <ul class="sub">
		    <li><a href="${pageContext.request.contextPath}/storeUpdate.do">가게 정보/수정</a></li>
		    <li><a href="storeReview.do">가게 리뷰</a></li>
		    <li><a href="storeNotice.do">가게 공지사항</a></li>
		   </ul>
		  </li>
		 </ul>
		</div>
		<div id="nav">
		 <ul class="menu">
		  <li>메뉴 관리
		   <ul class="sub">
		    <li><a href="menuInsertNoCategory.do">메뉴 등록/수정</a></li>
		    <li><a href="registDiscount.do">할인 등록</a></li>
		   </ul>
		  </li>
		 </ul>
		</div>
		<div id="nav">
		 <ul class="menu">
		  <li>주문 관리
		   <ul class="sub">
		    <li><a href="payment.do">주문 접수</a></li>
		    <li><a href="paymentHistory.do">주문 이력</a></li>
		   </ul>
		  </li>
		 </ul>
		</div>
		<!-- <div id="nav">
		 <ul class="menu">
		  <li>구독 관리
		   <ul class="sub">
		    <li onclick="modalToggle()"><a href="#">구독 현황</a></li>
		    <li onclick="modalToggle()"><a href="#">구독 이력</a></li>
		    <li onclick="modalToggle()"><a href="#">구독 프로그램 관리</a></li>
		   </ul>
		  </li>
		 </ul>
		</div> -->
		<div id="nav">
		 <ul class="menu">
		  <li>알림 관리
		   <ul class="sub">
		    <li><a href="pushAlarmList.do">알림 이력</a></li>
		    <li><a href="pushAlarmInsert.do">알림 새로보내기</a></li>
		   </ul>
		  </li>
		 </ul>
		</div>
		<!-- <div id="nav">
		 <ul class="menu">
		  <li onclick="modalToggle()">원데이클래스</li>
		 </ul>
		</div> -->
		<div id="nav">
		 <ul class="menu">
		  <li>가게 분석
		   <ul class="sub"><!-- onclick="modalToggle()"    <a href="#" >매출 관리</a> -->
		    <li><a href="storeCalculate.do">매출 관리</a></li>
		    <!-- <li onclick="modalToggle()"><a href="#">하루 정산</a></li> -->
		   </ul>
		  </li>
		 </ul>
		</div>
		<!-- <div id="nav">
		 <ul class="menu">
		  <li onclick="modalToggle()">이벤트 등록</li>
		 </ul>
		</div> -->
		<!-- <div id="nav">
		 <ul class="menu">
		  <li onclick="modalToggle()">요금제</li>
		 </ul>
		</div> -->
		<br><br>
	</div>
	
	
	</aside>
</body>
<%-- <%@ include file="/WEB-INF/views/common/ownerFooter.jsp" %> --%>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#nav ul.sub").hide();
		$("#nav ul.menu li").click(function(){
			$("ul",this).slideToggle("fast");
		});
	});
</script>
</html>