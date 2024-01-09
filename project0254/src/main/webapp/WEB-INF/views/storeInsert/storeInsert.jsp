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
	

<title>STORE | 빵이오4</title>
</head>
<body>
<!-- 가게 등록 -->
<div class="Maincontainer">
	<div class="container_store_reg">
		<div class="store_reg_title">가게 등록</div>
		<form action="${pageContext.request.contextPath}/storeInsert.do" id="form" method="post" class="form-data-box" enctype="multipart/form-data">
			<!-- 가게명 -->
			<div class="form-group">
				<label>가게 이름 <span>*</span></label>
				<div class="input_btn">
					<input style="width: 79%;" name="store_name" id="store_name" class="input-id" required placeholder="가게 이름을 입력해주세요." />
					<input type="button" id="store_name_check" name="store_name_check" value="중복 확인" >
				</div>
			</div>
			<!-- 전화번호 -->
			<div class="form-group">
				<label>가게 연락처 <span>*</span></label>
				<input name="store_phone" class="input-id" id="phone" type="text" required placeholder="가게 전화번호를 입력해주세요." />
			</div>
			<!-- 가게 주소  -->
			<div class="form-group">
				<label>가게 주소 <span>*</span></label>
				<div class="input_btn">
					<input style="width: 80%;" type="text" name="store_address" class="input-id" id="address_line" placeholder="주소찾기 버튼을 클릭해주세요." readonly required/> 
					<input type="button" onclick="get_address()" value="주소 찾기" required />
				</div>
			</div>
			<div class="form-group">
				<label>상세 주소 <span>*</span></label>
				<input type="text" name="store_address_detail" class="input-id" id="detail_address" placeholder="상세주소를 입력해주세요." required />
			</div>
			<div class="form-group"> 
				<input type="text" name="postcode" class="input-id" id="postcode" placeholder="Address" readonly required style="display: none "/> 
			</div>
			<input id="store_address_latitude" name="store_address_latitude" style="display: none;" /> 
			<input id="store_address_longitude" name="store_address_longitude" style="display: none;" />
			<!-- 최소 주문 금액 -->
			<div class="form-group">
				<label>최소 주문 금액 <span>*</span></label>
				<div style="display: flex; align-items: center;">
					<input name="store_min_delivery_price" id="store_min_delivery_price" class="input-id" required placeholder="0" />
					<div>&nbsp;원</div>
				</div>
			</div>
			<!-- 영업시간 -->
			<div class="form-group">
				<label>영업 시간 <span>*</span></label>
				<div class="form-detail">24시간제로 작성해주세요. ex) 08:00~18:00</div>
				<div class="form-group2">
					<input name="store_operation_hour" class="input-id" required placeholder="여는 시간" />
					<div>~</div>
					<input name="store_operation_hour" class="input-id" required placeholder="닫는 시간" />
				</div>
			</div>
			<!-- 정기 휴무일 -->
			<div class="form-group">
				<label>정기 휴무일 <span>*</span></label> 
				<div class="form-detail">휴무일이 여러 날인 경우 ','로 구분하여 작성해주세요. ex) 월,화</div>
				<input name="store_closed_date" class="input-id" required placeholder="정기휴무일을 입력해주세요."/>
			</div>
			<!-- 원산지 -->
			<div class="form-group" id="origin_div">
				<label>원산지 <span>*</span></label>
				<div class="form-group2">
					<input  name="store_made_in_arr" class="input-origin" required id="store_made_in_left_0" placeholder="표시품목" /> 
					<span id="span_0">:</span> 
					<input name="store_made_in_arr" class="input-origin" required id="store_made_in_right_0" placeholder="원산지" />
				</div>
			</div>
			<div style="display: flex; margin-top: 5px; justify-content: flex-end;">
				<input type="button" style="margin-right: 5px;" onclick="add_origin()" value="추가">
				<input type="button" onclick="remove_origin()" value="삭제">
			</div>
			<!-- 요금제 -->
			<div class="form-group">
				<label>요금제 <span>*</span></label> 
				<select class="input-id" form="form" name="store_pay_tier">
					<option value="0">기본형 요금제</option>
					<option value="1">플러스+ 요금제</option>
				</select>
			</div>
			<!-- 주문 가능 타입 -->
			<div class="form-group">
				<label>주문타입 <span>*</span></label> 
				<div>
					<label>배달 가능</label> <input name="store_is_delivery" type="checkbox">
					&nbsp;&nbsp;
					<label>픽업 가능</label> <input name="store_is_pickup" type="checkbox">
				</div>
			</div>
			<!-- 가게 소개말 -->
			<div class="form-group">
				<label>가게 소개말 <span>*</span></label>
				<textarea name="store_introduce" class="input-id" rows=5 required placeholder="소개말을 작성해주세요 :)"></textarea>
			</div>
			<div class="form-group">
				<label for="pic" class="img_title">썸네일 이미지를 선택해주세요.</label>
				<div class="file_insert">
					 <input type="file" name="img_thumbnail_path" id="0_img_input" onchange="setThumbnail(event)" >
				</div>
				<div class="img_thumbnail_path">
					<img src="resources/images/notStoreImg.png" id="0_img">						
				</div>
				<br>
				<label for="pic" class="img_title">대표 이미지를 선택해주세요.</label>
				<div class="file_insert">
					 <input type="file" name="imgs_path" id="1_img_input" onchange="setImgPath(event)" >
				</div>
				<div class="imgs_path">
					<img src="resources/images/notStoreImg.png" id="1_img">
				</div>
			</div>
			<input type="submit" class="store_insert_btn" value="등록하기" id="store_insert" disabled />
		</form>
	</div>
</div>
</body>
<%@ include file="/resources/jsp/storeInsert.jsp" %>
<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
<script>
const input = document.querySelector('#store_min_delivery_price');
input.addEventListener('keyup', function(e) {
  let value = e.target.value;
  value = Number(value.replaceAll(',', ''));
  if(isNaN(value)) {
    input.value = 0;
  }else {
    const formatValue = value.toLocaleString('ko-KR');
    input.value = formatValue;
  }
});

//form 전송 시 콤마 제거
$("#store_min_delivery_price").closest("form").submit(function(){
	
	console.log("akjdglkdjfglkdfjklg");
	var obj=$(this);
	
	$(obj).find("#store_min_delivery_price").each(function(){
		var tmp_val=$(this).val();
		
		if(tmp_val==""){
			$(this).val("");
		} else {
			tmp_val=tmp_val.replace(/,/g,'');
			$(this).val(parseInt(tmp_val));
		}
	});
});
</script>
</html>