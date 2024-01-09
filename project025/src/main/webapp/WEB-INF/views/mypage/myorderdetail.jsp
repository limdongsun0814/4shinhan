<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/myorderdetail.css">


<body>
	<div class="container123">
		<!-- 상세정보 박스 -->
		<div class="order_detail_top">
			<div class="sub_title">상세정보</div>
			
			<div class="top_box">
				<div class="left">주문 일자 : ${joinList[0]['payment_date']}</div>
				|
				<div class="right">주문번호 : ${joinList[0]['payment_seq']}</div>
			</div>
		</div>
		
		<!-- 상품명, 배송 정보 테이블 -->
		<div class="order_detail_middle">
			<div class="sub_title1">
				<div class="left1">
					<div class="isDelivery">배달</div>|<div class="isPickUp">픽업</div>
				</div>
				<div class="store_name">
					<img src="${cpath}/resources/images/mappoint.png" alt="가게 표시"/> ${joinList[0]['store_name']}
				</div>
			</div>
			
			<table class="order_detail_table" border="1">
				
					<thead>
						<tr>
							<th>상품명</th>
							<th>수량</th>
							<th>구매가</th>
							<th>배송현황</th>
						</tr>
					</thead>
				<c:set var="total" value="0"></c:set>
				<c:set var="discount_total" value="0"></c:set>
				<c:forEach items="${joinList}" var="mapData">
					<tbody>
						<tr>
							<td class="menu_name"><img src="${mapData['menu_image_path']}" alt="메뉴 이미지"/>${mapData['menu_name']}</td>
							<td>${mapData['payment_product_count']}</td>
							<td>${mapData['payment_product_price']}</td>
				<c:set var="total" value="${total + mapData['payment_product_price']}" />
				<c:set var="discount_total" value="${discount_total + mapData['payment_product_discount_price']}" />
				</c:forEach>
							<td>
								<c:choose>
				                    <c:when test="${joinList[0]['payment_status_id']== 0}">대기</c:when>
				                    <c:when test="${joinList[0]['payment_status_id']== 1}">수락</c:when>
				                    <c:when test="${joinList[0]['payment_status_id']== 2}">준비완료</c:when>
				                    <c:when test="${joinList[0]['payment_status_id']== 3}">배달출발</c:when>
				                    <c:when test="${joinList[0]['payment_status_id']== 4}">수령완료</c:when>
				                    <c:when test="${joinList[0]['payment_status_id']== 10}">주문취소</c:when>
				                    <c:when test="${joinList[0]['payment_status_id']== 11}">거절</c:when>
				                    <c:when test="${joinList[0]['payment_status_id']== 12}">거절완료</c:when>
				                </c:choose>
							</td>
						</tr>
					</tbody>
				
			</table>
			
		<div id="onlyDelivery" class="onlyDelivery">	
			<div class="sub_title">배송지 정보</div>
			
			<table class="order_address_table" border="1">
				<tbody>
					<tr>
						<th>받는분</th>
						<td>${joinList[0]['member_name']}</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>${joinList[0]['member_phone']}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>${joinList[0]['payment_address']}, ${joinList[0]['payment_address_detail']}</td>
					</tr>
				</tbody>
			</table>
		</div>	
			<div class="order_request">
				<div class="sub_title">주문시 요청사항</div>
				<div class="order_request_area">${joinList[0]['payment_request_content']}</div>
			</div>
		</div>
		
		<!-- 결제 정보 -->
		<div class="pay_info_area">
			<div class="sub_title">결제 정보</div>
			<div class="pay_info">
				<!-- 왼쪽 결제 정보 -->
				<div class="left_pay_info">
					<div class="up_left_pay_info">
						<p style="color: black; font-weight: normal;">주문금액</p>
						<p><span class="product_delivery"></span></p>
					</div>
					<div class="down_left_pay_info">
						<div class="text">
							<p>ㄴ총 상품금액</p>
							<p>ㄴ총 배송비</p>
						</div>
						<div class="number">
							<p class="only_product"><c:out value="${total}" />원</p>
							<p>${joinList[0]['payment_delivery_fee']}원</p>
						</div>
					</div>
				</div>
				<!-- 오른쪽 결제 정보 -->
				<div class="right_pay_info">
					<p style="color: black; font-weight: normal;">총 할인 금액</p>
					<p class="red_bold"><c:out value="${discount_total}" />원</p>
				</div>
			</div>
				<div class="gray_info_area">
				    <p>총 결제금액 <span class="totalAmount"></span></p>
				    <c:choose>
				        <c:when test="${joinList[0]['payment_type'] == 1}">만나서 결제</c:when>
				        <c:when test="${joinList[0]['payment_type'] == 2}">카드 결제</c:when>
				        <c:when test="${joinList[0]['payment_type'] == 3}">카카오페이 결제</c:when>
				        <c:when test="${joinList[0]['payment_type'] == 4}">네이버페이 결제</c:when>
				        <c:when test="${joinList[0]['payment_type'] == 5}">토스페이 결제</c:when>
				        <c:when test="${joinList[0]['payment_type'] == 6}">무통장입금</c:when>
				    </c:choose>
				    
				</div>
			
				<div class="mileage">
					<p>빵이오 마일리지 예상 적립 : <span class="mileage_amount"></span></p>
				</div>
			
		</div>
	</div>
	
	<button class="button123" onclick="redirectToOrderList()">목록</button>
	
<script>
    
    function redirectToOrderList() {
		$.ajax({
			url: "getOrderList.do",
			success: function(responseData){
				console.log(responseData);
				$("#here").html(responseData);
			}
		});
		 //var payment_id = "${payment_id}";
	}
</script>	
<script>
  // JavaScript 함수를 정의하여 총 금액을 계산하고 표시합니다.
  function calculateTotalAmount() {
    // 서버에서 받아온 총 금액
    var totalAmount = <c:out value="${total}" />;
    
    // 서버에서 받아온 discount 금액
    var discountAmount = <c:out value="${discount_total}" />;

    // 서버에서 받아온 delivery fee
    var deliveryFee = ${joinList[0]['payment_delivery_fee']};
    
    // 배송비 제외 총 금액
    var plusDeliveryFee = totalAmount + deliveryFee;

    // 계산된 총 금액
    var calculatedTotal = totalAmount - discountAmount + deliveryFee;
    
    // 마일리지 예상 적립액
    var mileage = calculatedTotal * 0.025;
    
    $('.mileage_amount').text(mileage + "M");
    $('.totalAmount').text(calculatedTotal + "원");
    $('.product_delivery').text(plusDeliveryFee + "원");
  }

  // 페이지 로드 시 자동으로 함수 호출
  calculateTotalAmount(); 
</script>
<script>
	var paymentGetId = ${joinList[0]['payment_get_id']};
	
	//해당 클래스를 가진 요소를 선택
	var isDeliveryElement = document.querySelector('.isDelivery');
	var isPickUpElement = document.querySelector('.isPickUp');
	
	//payment_get_id 값에 따라 스타일 변경
	if (paymentGetId === 1) {
	 // '픽업'에 대한 스타일 변경
	 isPickUpElement.style.color = '#A6A6A6';
	 isDeliveryElement.style.color = ''; // 다른 스타일을 초기화하려면 빈 문자열로 설정
	} else if (paymentGetId === 2) {
	 // '배달'에 대한 스타일 변경
	 isDeliveryElement.style.color = '#A6A6A6';
	 isPickUpElement.style.color = ''; // 다른 스타일을 초기화하려면 빈 문자열로 설정
	}
</script>
<script>
	var paymentGetId = ${joinList[0]['payment_get_id']};
	
	// paymentGetId가 1이면 onlyDelivery 클래스를 가진 div를 보이게 하고, 2이면 감추기
	if (paymentGetId === 1) {
	    document.getElementById("onlyDelivery").style.display = "block";
	} else if (paymentGetId === 2) {
	    document.getElementById("onlyDelivery").style.display = "none";
	}
</script>
</body>

