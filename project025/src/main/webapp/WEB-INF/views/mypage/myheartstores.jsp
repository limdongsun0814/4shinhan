<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/myheartstores.css">
<script src="https://kit.fontawesome.com/f719d238b7.js" crossorigin="anonymous"></script>
<c:set var="total" value="${fn:length(storeList)}" />
<div class="head">${member.member_name}님이 찜하신 동네 빵집은 <span class="total_heart"></span>입니다.</div>
<div class="heartList">
	
		<c:forEach items="${storeList}" var="store">
		<div class="one_heart_list" id="store${store.store_id}">
			<!-- 가게 이미지 칸 -->
			<img class="storeImage" src="${store.store_img_thumbnail_path}" alt="가게 이미지"></img>
		
		<!-- 가게 정보 칸 -->
			<div class="heart_store_info">
				<div class="first_line">
					<a class="storeName" href="${pageContext.request.contextPath}/store/getStoreDetail.do/${store.store_id}"> ${store.store_name} </a> 
					<div class="checkHeart"><i class="fa-solid fa-heart" onclick = "updateHeart(${store.store_id})" style = "cursor: pointer"></i></div>
				</div>

				<div class="storeAddress">${store.store_address}, ${store.store_address_detail}</div>

				<div class="third_line">
					<div class="storePhone">☎ ${store.store_phone}</div>
					<div class="storeTime">${store.store_operation_hour}</div>
				</div>

			</div>
			</div>
		</c:forEach>
</div>

<script>
	function aa() {
		var total_heart = <c:out value="${total}" />
		$('.total_heart').text("총 " + total_heart + "개");
	}
	// 페이지 로드 시 자동으로 함수 호출
	aa(); 
	

	function updateHeart(store_id) {
		console.log('가게 번호: ', store_id);

		var flag = confirm('찜 해제 하시겠습니까?');
		if(flag){
			$.ajax({
				url: "${pageContext.request.contextPath}/store/deleteHeartStore.do?store_id="+store_id,
				success:function(responseData){
						console.log(flag);
						$("#store" + store_id).remove();
					// total_heart 갱신
			            var total_heart = parseInt($('.total_heart').text().replace(/\D/g, ''), 10); // 현재 total_heart 값 가져오기
			            total_heart = total_heart - 1; // 1 감소
			            $('.total_heart').text("총 " + total_heart + "개");
				},
				error:function(){
					console.log("ajax 오류");
				}
			});
		}
		
	}
</script>