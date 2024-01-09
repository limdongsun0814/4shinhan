<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JOIN | 빵이오</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/tesjoin.css">

</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 회원가입 -->
<div class="Maincontainer">
	<div class="container_join">
		<div class=join_title>Join</div>
		<form action="memberjoin.do" id="form" method="post" class="form-data-box">
			<!-- 아이디 -->
			<div class="form-group">
				<label for="user_pw">아이디 <span>*</span></label>
				<div class="input_btn">
					<input style="width: 82%;" name="id" id="id" class="input-id" required placeholder="아이디를 입력해주세요." /> 
					<input type="button" id="id_check" value="중복 확인" />
				</div>
			</div>
			<!-- 비밀번호  -->
			<div class="form-group">
				<label for="user_pw">비밀번호 <span>*</span></label>
				<input name="password" id="password" class="input-id" required placeholder="비밀번호를 입력해주세요." />
				<div class="check_font" id="pw_check"></div>
			</div>
			<div class="form-group">
				<div style="display: flex;">
					<label>비밀번호 확인 <span>*</span></label>
					<p style="color:black;" id="password_check_result" ></p>
				</div>
				<input name="password_check" id="password_check" class="input-id" class="test1" placeholder="비밀번호를 한번 더 입력해주세요." />
				<div class="check_font" id="pw2_check" ></div>
			</div>
			<div class="form-group">
				<label>이름 <span>*</span></label>
				<input name="name" id="name" class="input-id" required placeholder="이름을 입력해주세요." />
			</div>
			<div class="form-group">
				<label>닉네임 <span>*</span></label>
				<input name="nickname" id="nickname" class="input-id" value="${nickname!=null?nickname:''}" ${nickname!=null?'readonly':''}  required placeholder="닉네임을 입력해주세요." />
			</div>
			<div class="form-group">
				<label>이메일 <span>*</span></label>
				<input name="email" value="${email!=null?email:''}" ${email!=null?'readonly':''} class="input-id" id="email" required placeholder="이메일을 입력해주세요." />
			</div>
			<div class="form-group">
				<label>전화번호 <span>*</span></label>
				<input name="phone" class="input-id" id="phone" type="text" required placeholder="전화번호를 입력해주세요." />
			</div>
			<div class="form-group">
				<label>우편번호 <span>*</span></label>
				<div class="input_btn">
					<input style="width: 82%;"  type="text" name="postcode" class="input-id" id="postcode" placeholder="주소찾기 버튼을 클릭해주세요." readonly  required/> 
					<input type="button" onclick="get_address()" value="주소 찾기" required />
				</div>
			</div>
			<div class="form-group">
				<label>주소 <span>*</span></label>
				<input type="text" name="address" id="address" class="input-id" placeholder="주소찾기 버튼을 클릭해주세요." readonly required />
			</div>
			<div class="form-group">
				<label>상세 주소 <span>*</span></label>
				<input type="text" name="address_detail" class="input-id" id="detail_address" placeholder="상세주소를 입력해주세요." required />
			</div>
			<input id="address_latitude" name="address_latitude" style="display: none;" /> 
			<input id="address_longitude" name="address_longitude" style="display: none;" />

			<div class="form-group">
				<label>생년월일 <span>*</span></label>
				<input id="birthday" name="birthday" type="date" class="input-id" required />
			</div>
			<input type="submit" class="join_btn" value="JOIN US" id="join" disabled />
		</form>
	</div>
</div>
<%@include file="/resources/jsp/find_address.jsp"%>
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</html>