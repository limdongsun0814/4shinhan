<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/orderlist.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/myorderlist.css">



			
<div class="order_list">
<table border="1">
	<thead>
		<tr>
	      <th>주문 일자</th>
	      <th>가게명</th>
	      <th>결제 금액</th>
	      <th>주문 현황</th>
	    </tr>
	</thead>
	<c:forEach items="${paymentList}" var="order" varStatus="status">

	<tbody>
		<tr>
			<td>
			<div class="order_date">${order.order_payment_date}</div>
			<button class="get_detail" id="get_detail" onclick="get_detail(${order.order_id})">상세보기</button>
			<button class="write_review" id="write_review" onclick="write_review(${order.order_id})">리뷰쓰기</button>
			</td>
			<td class="store_name">
				<img class="store_image" src="${order.order_store_image}" width="180px" height="120px" alt="가게 이미지"></img>
				<div class="store_id">${order.order_store_name}</div>
			</td>
			<td>${order.order_amount + order.order_delivery_fee - order.order_discount_price}원
			</td>
			<td>
				<div class="order_status">
					<%-- order_status가 0이면 "대기", 1이면 "수락"으로 표시 --%>
	                <c:choose>
	                    <c:when test="${order.order_status_id eq 0}">대기</c:when>
	                    <c:when test="${order.order_status_id eq 1}">수락</c:when>
	                    <c:when test="${order.order_status_id eq 2}">준비완료</c:when>
	                    <c:when test="${order.order_status_id eq 3}">배달출발</c:when>
	                    <c:when test="${order.order_status_id eq 4}">완료대기</c:when>
	                    <c:when test="${order.order_status_id eq 5}">수령완료</c:when>
	                    <c:when test="${order.order_status_id eq 10}">주문취소</c:when>
	                    <c:when test="${order.order_status_id eq 11}">거절</c:when>
	                    <c:when test="${order.order_status_id eq 12}">거절완료</c:when>
	                </c:choose>
				</div>
			</td>
		</tr>
		
	</tbody>
	</c:forEach>	
</table>
</div>


<script>


//	document.getElementById('get_detail')
//	.addEventListener('click', function() {
//	window.location.href = '${cpath}/mypage/getOrderDetail.do?payment_seq=${order.payment_seq}';
//	});
	
	
	function get_detail(e){
		$.ajax({
			url: "${cpath}/mypage/getOrderDetail.do?payment_seq=" + e,
			success: function(responseData){
				//console.log(responseData);
				alert("주문 상세내역 페이지로 이동합니다.");
				$("#here").html(responseData);
			}
		});
		 //var payment_id = "${payment_id}";
	}
	
	
	function write_review(e){
		
		$.ajax({
			url: "${cpath}/mypage/checkReview.do?payment_seq=" + e,
			success: function(responseData) {
				$("#here").html(responseData);
			}
			
		});
		
	}
	

</script>