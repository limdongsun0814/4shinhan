<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/common/header.jsp"%>


<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/testlogin.css">

<title>Insert title here</title>
</head>


<body>


	<div class="backcalss">
		<div class="container">
			<div class="box">
				<div class="SingUp_Text">빵이오 회원가입</div>


				<form action="memberjoin.do" id="form" method="post"
					class="form-data-box">

					<div class="form-group">
						<lable for="user_pw">아이디 <span>*</span></lable>
						</br> <input name="id" id="id" class="input-id" required
							placeholder="Id" /> <input type="button" id="id_check"
							value="중복 확인" /><br>
					</div>


					<!-- 비밀번호  -->
					<div class="form-group">
						<lable for="user_pw">비밀번호 <span>*</span></lable>
						</br> <input name="password" id="password" class="input-id" required
							placeholder="PASSWORD" />
						<div class="check_font" id="pw_check"></div>
					</div>
					<div class="form-group">
						<label>비밀번호 확인</label> <span>*</span></br> <input name="password_check"
							id="password_check" class="input-id" class="test1"
							placeholder="Confirm Password" />
						<div class="check_font" id="pw2_check"></div>
					</div>
					<!-- <input name="password" id="password" class="input-id" required placeholder="*비밀번호" /><br> -->
					<!--  <input name="password_check" id="password_check" class="input-id" class="test1" placeholder="*비밀번호 확인" /> -->
					<div class="form-group">
						<p id="password_check_result"></p>
						<br>
					</div>

					<div class="form-group">
						<label>이름</label> <span>*</span></br> <input name="name" id="name"
							class="input-id" required placeholder="Name" /><br>
					</div>

					<div class="form-group">
						<label>닉네임</label> <span>*</span></br> <input name="nickname"
							id="nickname" class="input-id" required placeholder="NickName" /><br>
					</div>

					<div class="form-group">
						<label>비밀번호 확인</label> <span>*</span></br> <input name="email"
							class="input-id" id="email" required placeholder="Email" /><br>
					</div>

					<div class="form-group">
						<label>전화번호</label> <span>*</span></br> <input name="phone"
							class="input-id" id="phone" type="text" required
							placeholder="Phone" /><br>
					</div>

					<div class="form-group">
						<label>주소</label> <span>*</span></br> <input type="text"
							name="postcode" class="input-id" id="postcode"
							placeholder="Address" readonly /> <input type="button"
							onclick="get_address()" value="주소 찾기" required /> <br>
					</div>

					<div class="form-group">
						<label>도로명 주소</label> <span>*</span></br> <input type="text"
							name="address" id="address" class="input-id"
							placeholder="Street name address" readonly required />
					</div>

					<div class="form-group">
						<label>상세 주소</label> <span>*</span></br> <input type="text"
							name="address_detail" class="input-id" id="detail_address"
							placeholder="Detailed Address" required /><br>
					</div>


					<input id="address_latitude" name="address_latitude"
						style="display: none;" /> <input id="address_longitude"
						name="address_longitude" style="display: none;" />

					<div class="form-group">
						<label>생년월일</label> <span>*</span></br> <input id="birthday"
							name="birthday" type="date" class="input-id" required /><br>
					</div>
					<input type="submit" class="join_btn" value="JOIN US" id="join"
						disabled /> <br>
				</form>
			</div>
		</div>
	</div>
	<%@include file="/resources/jsp/find_address.jsp"%>
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</html>

