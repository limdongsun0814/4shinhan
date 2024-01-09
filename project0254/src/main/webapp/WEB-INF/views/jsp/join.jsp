<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/common/ownerHeader.jsp"%>


<link href="${pageContext.request.contextPath}/resources/css/join.css"
	type="text/css" rel="stylesheet" />
	

<title>JOIN | 빵이오4</title>
</head>
<body>
<!-- 회원가입 -->
<div class="Maincontainer">
	<div class="container_join">
		<div class=join_title>Join</div>
		<form action="signUp.do" id="form" method="post" class="form-data-box">
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
			<!-- 비밀번호 확인 -->
			<div class="form-group">
				<div style="display: flex;">
					<label>비밀번호 확인 <span>*</span></label>
					<p style="color:black;" id="password_check_result" ></p>
				</div>
				<input name="password_check" id="password_check" class="input-id" class="test1" placeholder="비밀번호를 한번 더 입력해주세요." />
				<div class="check_font" id="pw2_check" ></div>
			</div>
			<!-- 이름 -->
			<div class="form-group">
				<label>이름 <span>*</span></label>
				<input name="name" id="name" class="input-id" required placeholder="이름을 입력해주세요." />
			</div>
			<!-- 이메일 -->
			<div class="form-group">
				<label>이메일 <span>*</span></label>
				<input name="email" value="${email!=null?email:''}" ${email!=null?'readonly':''} class="input-id" id="email" required placeholder="이메일을 입력해주세요." />
			</div>
			<!-- 전화번호 -->
			<div class="form-group">
				<label>전화번호 <span>*</span></label>
				<input name="phone" class="input-id" id="phone" type="text" required placeholder="전화번호를 입력해주세요." />
			</div>
			<!-- 주소 -->
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
			<!-- 사업자등록번호 -->
			<div class="form-group">
				<label>사업자 등록번호 <span>*</span></label> 
				<div class="input_btn">
					<input name="regist_code" style="width: 82%;" id="regist_code" class="input-id" required placeholder="시업자등록번호를 입력해주세요." /> 
					<input type="button" id="regist_code_check" name="regist_code_check" value="중복 확인">
				</div>
			</div>
			<input type="submit" class="join_btn" value="JOIN US" id="join" disabled />
		</form>
	</div>
</div>
<%@include file="/resources/jsp/find_address.jsp"%>
</body>
<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
</html>