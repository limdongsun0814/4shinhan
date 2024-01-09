<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>	
<title>Home</title>
<link href="${path}/resources/css/login.css"  type="text/css" rel="stylesheet"/> 
</head>
<body>



	<div class="backcalss">
		<div class="container">
			<div class="box">
				<div class="SingUp_Text">빵이오 회원가입</div>


			<form action="signUp.do" id="form" method="post"
					class="form-data-box">

					<div class="form-group">
						<lable for="user_pw">아이디 <span>*</span></lable>
							<input name="id" id="id" required class="input-id"  required 
						placeholder="Id"/>
							<input type="button" id="id_check" value="중복 확인" /><br>
					</div>


					<div class="form-group">
						<lable for="user_pw">비밀번호 <span>*</span></lable></br>
						<input name="password" id="password" required 
						class="input-id" required type="password"
							placeholder="PASSWORD"/><br>
					</div>
					
					
					
					<div class="form-group">
						<label>비밀번호 확인</label> <span>*</span></br> 
						<input name="password_check" id="password_check" class="input-id" class="test1"
							placeholder="Confirm Password" type="password" /><br>
					<!-- 	<div class="check_font" id="pw2_check" ></div> -->
					</div>
				
				<div class="form-group">
				<p style="color:black;" id="password_check_result"></p><br>
				</div>
				
			

					<div class="form-group">
						<label>이름</label> <span>*</span></br> <input name="name" id="name"
							class="input-id" required placeholder="Name" /><br>
					</div>

					<div class="form-group">
						<label>이메일</label> <span>*</span></br> <input name="email"
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

<%@include file="/resources/jsp/find_address.jsp" %>
</body>
</html>
