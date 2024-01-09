<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div>
	<p>1.배달 정보를 입력해주세요.</p>

</div>

<div>
	<lable>배송지선택 </lable>
	<select id="select_options" onchange="getselect(event)">
		<option>배송지를 선택해주세요.</option>
		<c:forEach var="alist" items="${member_address_list}">
			<option name="select_address"
				value="${alist.member_address_name}">${alist.member_address_name}</option>
		</c:forEach>
	</select>
</div>

<!--  위도 경도 정보  -->
<input id="address_latitude" name="address_latitude"
	value="${alist.member_address_latitude }" style="display: none;" />
<input id="address_longitude" name="address_longitude"
	value="${alist.member_address_longitude}" style="display: none;" />


<div>

	<div>
		<lable>전화 번호</lable>
		<small id="phone1"></small> - <small id="phone2"></small> - <small
			id="phone3"></small>
	</div>
	<input type="tel" id="phone" name="phone"
		placeholder="예: 010-123-4567" readonly style="display: none;"
		value="${ login_member_phone}">
</div>

<div>
	<label>이름</label> <input type="text" id="name" name="name"
		value="${login_member_id}" readonly>
</div>



<div>
	주소
	<c:forEach items="${member_address_map}" var="member_address">
		<div id="${member_address.key}" style="display: none;" class="key">
			<label> 주소 </label> <input type="text" id="address1"
				name="addresspay" value="${member_address.value.member_address }"
				readonly><br> <input type="text" id="address2"
				name="addresspay"
				value="${member_address.value.member_address_detail }" readonly>
		</div>
	</c:forEach>
	</div>
	<input type="button" id="add_address_btn" name="add_address_btn"
		value="주소 추가" onclick="open_add_address_function()">
