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


<link href="${pageContext.request.contextPath}/resources/css/store.css"
	type="text/css" rel="stylesheet" />
	

<title>join page</title>
</head>
<body>
	<div class="backcalss">
		<div class="container">
			<div class="box">
				<div class="SingUp_Text">빵이오4 가게 추가</div>
				<form action="${pageContext.request.contextPath}/storeUpdate.do" id="form" method="post"
					class="form-data-box" enctype="multipart/form-data">
					<div class="form-group">
						<lable for="user_pw">가게 이름 <span>*</span></lable>
						</br> <input name="store_name" id="store_name" class="input-id" required value="${sessionScope.store.store_name}"
							placeholder="store name" readonly="readonly" /> <br>
							
							<!-- <input type="button"
							id="store_name_check" name="store_name_check" value="중복 확인" ><br> -->
					</div>
					<div class="form-group">
						<label>주소</label> <span>*</span></br>
						<label>도로명 주소</label> <span>*</span></br> <input type="text"  value="${sessionScope.store.store_address}"
							name="store_address" id="address_line" class="input-id"
							placeholder="Street name address" readonly required />
							<input type="button"
							onclick="get_address()" value="주소 찾기"  /> <br>
					</div>
					<div class="form-group"> <input type="text"
							name="postcode" class="input-id" id="postcode"
							placeholder="Address" readonly required style="display: none "/> 
					</div>
					<div class="form-group">
						<label>상세 주소</label> <span>*</span></br> <input type="text"
							name="store_address_detail" class="input-id" id="detail_address" value="${sessionScope.store.store_address_detail}"
							placeholder="Detailed Address" required /><br>
					</div>
					<div class="form-group">
						<label>최소 주문 금액</label> <span>*</span></br> <input name="store_min_delivery_price" id="store_min_delivery_price"  value="${sessionScope.store.store_min_delivery_price}"
							class="input-id" required placeholder="Name" /><br>
					</div>
					<div class="form-group">
						<label>영업 시간</label> <span>*</span></br> 
						<input name="store_operation_hour" class="input-id" required placeholder="08:00" value="${store_open_hour}"/>
						<input name="store_operation_hour" class="input-id" required placeholder="20:00" value="${store_close_hour}"//><br>
					</div>
					<div class="form-group">
						<label>정기 휴무일</label> <span>*</span></br> <!-- placeholder="예) 월,화"  -->
						<input name="store_closed_date" class="input-id" required value="${sessionScope.store.store_closed_date}" />
					</div>
					<div class="form-group">
						<label>전화 번호</label> <span>*</span></br> <input name="store_phone"
							class="input-id" id="phone" type="text" required value="${sessionScope.store.store_phone}"
							placeholder="Phone" /><br>
					</div>
					<input id="address_latitude" name="store_address_latitude" value="${sessionScope.store.store_address_latitude}"
						style="display: none;" /> <input id="address_longitude" value="${sessionScope.store.store_address_longitude}"
						name="store_address_longitude" style="display: none;" />

					<div class="form-group">
						<label>가게 소개</label> <span>*</span></br> <input name="store_introduce" class="input-id" required placeholder="Registe Number" value="${sessionScope.store.store_introduce}" /> 
						<br>
					</div>
					
					<div class="form-group" id="origin_div">
						<label>원산지</label> <span>*</span></br> 
						<c:forEach items="${made_in_arr}" var="made_in" varStatus="status">
							<input  name="store_made_in_arr" class="input-origin" required value="${fn:split(made_in,':')[0]}" id="store_made_in_left_${status.index}"
							placeholder="Registe Number" /> <span id="span_${status.index}">:</span>
							<input name="store_made_in_arr" class="input-origin" required  value="${fn:split(made_in,':')[1]}" id="store_made_in_right_${status.index}"
							placeholder="Registe Number" /><br>
						</c:forEach>
						<!-- <input  name="store_made_in_arr" class="input-origin" required
							placeholder="Registe Number" /> : 
							<input name="store_made_in_arr" class="input-origin" required
							placeholder="Registe Number" /> <br>  -->
					</div>
					<div class="form-group" ><br>
							<input type="button" onclick="add_origin()" value="원산지 추가">
							<input type="button" onclick="remove_origin()" value="원산지 제거">
					</div>
					<div class="form-group">
						<label>요금제</label> <span>*</span></br> 
							<br>
							<select class="input-id" form="form" name="store_pay_tier">
								<option value="0">기본 요금</option>
								<option value="1">기본 요금+</option>
							</select>
							<br>
							<br>
					</div>
					
					<div class="form-group">
						<span>*</span><label>배달 가능</label> <input name="store_is_delivery" type="checkbox"  ${sessionScope.store.store_is_delivery?"checked":""}>
						<span>*</span><label>픽업 가능</label> <input name="store_is_pickup" type="checkbox" ${sessionScope.store.store_is_pickup?"checked":""}>
						<span>*</span><label>구독 가능</label> <input name="store_is_subscribe" type="checkbox" ${sessionScope.store.store_is_subscribe?"checked":""}> 
							<br> 
							<br>
							
					</div>
					<div class="form-group">
						<!-- <label for="pic">썸네일 이미지:</label> -->
						<br>
						
						<!-- <input type="button"
							id="add_img" name="add_img" onclick="add_img_function()" value="이미지 추가" > -->
						<div id="file">
							 <input type="file" name="img_thumbnail_path_multipart" id="0_img_input" onchange="setThumbnail(event)" 
							  value="resources/images/notStoreImg.png" style="display: none;">
							  <label for="0_img_input"><div>썸네일 이미지 수정하기</div></label>
							  <input type="hidden" name="store_img_thumbnail_path" value="${sessionScope.store.store_img_thumbnail_path}">
						</div>
						<div id="img_thumbnail_path">
							<img src="${sessionScope.store.store_img_thumbnail_path!=null?sessionScope.store.store_img_thumbnail_path:'resources/images/notStoreImg.png'}" id="0_img" >	
						</div>
						
						<!-- <label for="pic">대표 이미지:</label> -->
						<div id="file">
							 <input type="file" name="imgs_path_multipart" id="1_img_input" style="display: none;" onchange="setImgPath(event)" >
							<label for="1_img_input"><div>대표 이미지 수정하기</div></label>		
							  <input type="hidden" name="store_img_path" value="${sessionScope.store.store_img_path}">
						</div>
						<div id="imgs_path">
							<img src="${sessionScope.store.store_img_path!=null?sessionScope.store.store_img_path:'resources/images/notStoreImg.png'}" id="1_img">
						</div>
					</div>
					<input type="submit" class="join_btn" value="JOIN US" id="join"
						 /> <br>
				</form>
			</div>
		</div>
	</div>
</body>
<%@ include file="/resources/jsp/storeUpdate.jsp" %>
<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
</html>