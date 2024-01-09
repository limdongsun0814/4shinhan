<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/mypage/mysublist.css">




	<div class="active_subscribe">
	<div class="title">${mySubscribe[0].subscribe_member_name}님의 현재 구독 상황입니다.</div>

<c:forEach items="${mySubscribe}" var="subscribe">
	
		<div class="title_bottom">
			<div class="store_image">
				<p>${subscribe.subscribe_store_img_path}</p>
			</div>

			<div class="sub_title">
				<p>${subscribe.subscribe_store_name}</p>
				<p>구독 프로그램명</p>
				<p>정기 구독 시간</p>
				<p>구독 결제일</p>
			</div>

			<div class="subscribe_info">
				<p>${subscribe.subscribe_use_count}/6회차 진행중
					(${subscribe.subscribe_total_week}주 결제)</p>
				<p>${subscribe.subscribe_case_content}-
					${subscribe.subscribe_delivery_time}</p>
				<p>${subscribe.subscribe_start_date}</p>
			</div>
		</div>
</c:forEach>
	</div>



<!-- 
<div class="order_list">
	<c:forEach items="${paymentList}" var="order" varStatus="status">
		<div class="order_item">
			<div class="order_date">${order.payment_date}</div>
			<div class="store_image">가게 이미지</div>
			<div class="store_id">${order.store_name}</div>
			<div class="delivery_fee">${order.payment_delivery_fee}</div>
			<div class="order_status">${order.payment_status_id}
				<%-- order_status가 0이면 "배달완료", 1이면 "픽업완료"으로 표시 --%>
                <c:choose>
                    <c:when test="${order.payment_status_id eq 0}">대기</c:when>
                    <c:when test="${order.payment_status_id eq 1}">수락</c:when>
                    <c:when test="${order.payment_status_id eq 2}">준비완료</c:when>
                    <c:when test="${order.payment_status_id eq 3}">배달출발</c:when>
                    <c:when test="${order.payment_status_id eq 4}">수령완료</c:when>
                    <c:when test="${order.payment_status_id eq 10}">주문취소</c:when>
                    <c:when test="${order.payment_status_id eq 11}">거절</c:when>
                    <c:when test="${order.payment_status_id eq 12}">거절완료</c:when>
                </c:choose>
			</div>
		
			<button class="get_detail" id="get_detail" onclick="get_detail(1)">상세보기</button>
		</div>
	</c:forEach>
</div>
-->