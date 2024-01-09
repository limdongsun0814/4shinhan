<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="select1">
<div class="ptage">
	<p>
	<li></li>배달 정보를 입력해주세요.
	</p>
</div>
<div class="select1_info" style="display: flex;">
	<label>배송지선택 </label>
	<select id="select_options" onchange="getselect(event)">
		<option style="font-size: 20px;">배송지를 선택해주세요.</option>
		<c:forEach var="alist" items="${member_address_list}">
			<option name="select_address"
				value="${alist.member_address_name}">${alist.member_address_name}</option>
		</c:forEach>
	</select>
	<input type="button" id="add_address_btn"
		name="add_address_btn"  value="주소 추가">
</div>
<!--  위도 경도 정보  -->
<input id="address_latitude" name="address_latitude"
	value="${alist.member_address_latitude }" style="display: none;" />
<input id="address_longitude" name="address_longitude"
	value="${alist.member_address_longitude}" style="display: none;" />
<div class="select1_info">
	<div>
		<lable>전화 번호</lable>
		<div class="phonefull">
			<small id="phone1"></small> - <small id="phone2"></small> - <small
				id="phone3"></small>
		</div>
	</div>
	<input type="tel" id="phone" name="phone"
		placeholder="예: 010-123-4567" readonly style="display: none;"
		value="${ login_member_phone}">
</div>
<div class="select1_info">
	<div class="nameSamll">
		<label>이름</label> <small>${login_member_id}</small>
	</div>
	<input type="text" id="name" name="name"
		value="${login_member_id}" style="display: none;" readonly>
</div>
<div class="select1_info">
	<label >주소</label> 


	<div class="alterInfo">
		<c:forEach items="${member_address_map}" var="member_address">
			<div id="${member_address.key}" style="display: none;"
				class="key">

				<input type="text" id="address1" name="addresspay"
					value="${member_address.value.member_address }" readonly><br>
				<input type="text" id="address2" name="addresspay"
					value="${member_address.value.member_address_detail }"
					readonly>
			</div>
		</c:forEach>
		</div>


	</div>
</div>