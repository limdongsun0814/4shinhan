<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy-mm-dd" /></c:set> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/common/ownerHeader.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>Insert title here</title>
<style>
h1 {
	text-align: center;
}

p {
	text-align: center;
}
span{}







</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>


	<div class="pagetitle">
		<h1>구독 물량이력</h1>
		<p><c:out value="${sysYear}" /></p>
	</div>


	<div></div>

	<c:forEach var="slist" items="${Psproduct}">
		  <div class= "subscribe-form">
		   		<div>
		   		  <p>주문 번호 : ${slist.payment_seq } </p>          <span>여기에회차</span><p>여기에토탈횟수</p>
		   		</div>
		   		
		   		<div>
		   		   <lable>요청 사항 </lable> <p>${slist.payment_request_content }</p>
		   		</div>
		   		<div>
		   		<label>구독자 연락처 </label> <p>${slist.member_phone}</p>
		   		</div>
		   		<div>
		   		    <lable>구독자 주소</lable> <p>${slist.payment_address}</p> 상세주소 : <p>${slist.payment_address_detail}</p>
		   		</div>
		   		
		   		<div>
		   		   <lable>주문 정보</lable> <p>${slist.payment_date }</p>
		   		</div>
		   		
		   		<div>
		   		   <label>메뉴</label>    <label> 수량</label>
		   		</div>
		   		
		   		<div>
		   		  <p>${slist.menu_name}</p>      <p>${slist.payment_product_count }</p>
		   		</div>		  
		  </div>
		  
	</c:forEach>

	
<%-- 	<div>
		<lable>배송지선택 </lable>
		<select id="select_options" onchange="getselect(event)">
			<option>배송지를 선택해주세요.</option>
			<c:forEach var="alist" items="${member_address_list}">
				<option name="select_address" value="${alist.member_address_name}">${alist.member_address_name}</option>
			</c:forEach>
		</select>
	</div> --%>






</body>
<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
</html>