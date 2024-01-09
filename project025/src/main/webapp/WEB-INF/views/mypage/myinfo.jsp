<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/myheartstores.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/myinfo.css">

<div class="head">회원님의 소중한 정보를 안전하게 관리하세요.</div>
<div class="info">
<div id="myinfohere"></div>
	
</div>

<script>
    
    

	
	$(function(){
		$.ajax({
			url: "${cpath}/member/printMember.do",
			success: function(responseData){
				$("#myinfohere").html(responseData);
			},
			error: function (){
				console.log("asdf");
			}
		});
	})

</script>