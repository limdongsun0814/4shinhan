<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/deletemember.css">

</head>
<body>
<div class="all">
	<div class="title">빵이오 회원탈퇴</div>
	<div class="sub_title">회원탈퇴 신청 전 유의 사항을 확인하세요.</div>
	<div class="content_box">
		<div class="text">
			<div class="bold">회원 탈퇴 시 유의사항</div>
			<div class="text_content">
				<ul>
					<li>빵이오 회원 탈퇴 시 30일 이내 재가입이 불가능합니다.
					<li>탈퇴하시면 현재 보유하고 계신 쿠폰과 빵이오 포인트, 빵이오 마일리지는 즉시 자동 소멸합니다.
					<li>진행 중인 전자상거래 이용내역(배송/교환/반품 중인 상태)이 있거나 이용하신 서비스가 완료되지 않은 경우 탈퇴하실 수 없습니다.
					<li>기타 탈퇴와 관련된 모든 정책은 빵이오 회원가입 시 동의하신 빵이오 회원 약관 및 개인정보 제공, 활용 동의 내용에 따릅니다.
					<li>회원 탈퇴를 하시면 해당 아이디는 즉시 탈퇴 처리되며, 해당 아이디에 대한 회원 정보 및 서비스 정보는 모두 삭제됩니다.
					<li>탈퇴한 아이디는 영구적으로 사용이 중지되며, 30일 이후에 가입이 가능합니다.
				</ul>
			</div>
			<br>
			<div class="bold">회원 정보 보존 안내 사항</div>
			<div class="text_content">
				<ul>
					<li>탈퇴 후 30일간 재가입 방지 및 포인트 불법 이용 및 부정 행위를 방지하기 위해 회원님의 아이디를 포함한 회원 정보가 보존됩니다.(회원가입 시 동의하신 개인정보 처리 방침에 명시한 파기절차와 방법에 따라 30일 이후 회원 정보를 지체 없이 파기합니다)
					<li>전자상거래 이용내역이 있는 회원님은 전자상거래 등에서의 소비자보호에 관한 법률에 의거 교환/반품/환불 및 사후처리(A/S)등을 위해 회원 정보가 관리됩니다.
				</ul>
			</div>
		</div>
	</div>
	<div class="sub_title2">유의 및 안내 사항을 모두 확인하였으며, 탈퇴 시 위 사항에 동의한 것으로 간주합니다.</div>
	<div class="buttons">
		<button class="cancel" onclick="call2()">취소</button>
		<form action="${cpath}/member/deleteMember2.do">
		<button class="ok_delete" >탈퇴</button>
		</form>
	</div>
</div>
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script>
     /* function call(){
    	 var mid = "${mid}";
    	 alert('회원탈퇴되었습니다. 빵이오 메인으로 돌아갑니다.');
    	 location.href = '${cpath}/member/deleteMember2.do?mid=' + mid;
     } */
     function call2(){
    	 alert('회원탈퇴가 취소되었습니다. 빵이오 메인으로 돌아갑니다.');
    	 location.href = '${cpath}';
     }
</script>
</html>