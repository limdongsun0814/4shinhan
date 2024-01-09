<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ORDER&PAY | 빵이오</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/paymentend.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>
<style>
.hiden_area{
	display:none;
}
</style>
<body>
	

	<div class="">
	
		<div class="all_div">

			<div class="all-div-container">
				<div class="all-div-text1">
					<a>01 장바구니 ></a><a> 02 주문/결제 ></a><a style="color:black;"> 03 결제완료</a>
				</div>
				<div class="all-div-text2">주문 완료</div>
				<div class="all-div-text3" id="payment_seq" data-seq="${payment_seq}">주문 번호 ${payment_seq}</div>
				<div class="all-div-text4">${member.member_id}님의 주문이 완료 되었습니다</div>
				<div class="all-div-text5">감사합니다</div>
				<div class="store_ip_path hiden_area" data-path="${store_ip_path}"></div>
				<div class="store_id hiden_area" data-id="${store_id}"></div>
				<button  class="go-home-btn" onclick="location.href='${pageContext.request.contextPath}'">홈 으로 가기</button>
			</div>





		<div class="animate__animated animate__fadeInUp">
			<div class="detail-page-left">
				<div class="title">
					<div class="left-title">
						${paymentProduct_list.payment_get_id.equals('delivery')?'배달 정보':"픽업 정보"}
					</div>
					<div>
						<div class="content123" style="margin-top: 30px;">
							<div>주문 일시</div>
							<div>
								${paymentProduct_list.payment_date}
								<!-- 2023년 11월 25일 오후 8시 03분 -->
							</div>
						</div>
					</div>
					<div>
						<div class="content123">
							<div>주문 번호</div>
							<div>${paymentProduct_list.payment_seq}</div>
						</div>
					</div>
					<div class="content123" style="margin-top: 50px;">
						${paymentProduct_list.payment_get_id.equals('delivery')?'배송지 정보':"배송지 정보"}
					</div>
					<div>
						<div class="content123">
							<div style="color: gray;">이름</div>
							<div>${paymentProduct_list.member_name}</div>
						</div>
					</div>
					<div>
						<div class="content123">
							<div style="color: gray;">전화번호</div>
							<div>${paymentProduct_list.member_phone}</div>
						</div>
					</div>
					<div
						${paymentProduct_list.payment_get_id.equals('delivery')?"":'style="display: none"'}>
						<div class="content123">
							<div style="color: gray;">배달 주소</div>
							<div>${paymentProduct_list.payment_address!=null?paymentProduct_list.payment_address:""} ${paymentProduct_list.payment_address_detail}</div>
						</div>
					</div>
					<div>
						<div class="content123">
							<div>요청 사항</div>
							<div style="font-size: 14px; margin-top: 3px;">${paymentProduct_list.payment_request_content}</div>
						</div>
					</div>
				</div>
			</div>







			<div class="detail-page-right">
				<div class="title">
					<div class="right-title">결제 정보</div>
					<div>
						<div class="content123" style="margin-top: 30px;">
							<div>총 주문 상품수</div>
							<div>${paymentProduct_list.tatal_cnt} 개</div>
						</div>
					</div>
					<div>
						<div class="content123">
							<ul style="margin-top: -5px; line-height: 30px; font-size: 15px;">
								<c:forEach items="${paymentProduct_list.menu_list}" var="menu">
									<li>${menu.menu_name} X ${menu.payment_product_count}</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div>
						<div class="content123" style="margin-top: 0px;">
							<div>총 상품 금액</div>
							<div>${paymentProduct_list.total_not_discount_price} 원</div>
						</div>
					</div>
					<div>
						<div class="content123">
							<div>총 할인 금액</div>
							<div>-${paymentProduct_list.total_discount_price} 원</div>
						</div>
					</div>
					<div>
						<div class="content123" style="border-bottom: 1px solid #FFEC9F; padding-bottom:20px;">
							<div>총 배송비</div>
							<div>${paymentProduct_list.store_delivery_fee} 원</div>
						</div>
					</div>
					<div>
						<div class="content123">
							<div>총 결제금액</div>
							<div><span style="color: #70B4E4; font-size: 30px; font-weight:bold;">${paymentProduct_list.total_price}</span> 원</div>
						</div>
					</div>
				</div>
			</div>
		</div>
				
					
					<img class="result1-png"
						src="${pageContext.request.contextPath}/resources/images/result1.png">
					<img class="result2-png"
						src="${pageContext.request.contextPath}/resources/images/result2.png">
					<img class="result3-png"
						src="${pageContext.request.contextPath}/resources/images/result3.png">
				
			
	</div>
</div>

<script type="text/javascript">
	window.onload = sendTOStore;
	function sendTOStore(){
		var payment_seq = document.querySelector("#payment_seq");
		if(payment_seq.dataset.seq !== ''){
			var store_ip_path = document.querySelector(".store_ip_path");
			var store_id = document.querySelector(".store_id");
			
			if(store_ip_path.dataset.path !== '' && store_id.dataset.id !== ''){
				var origin = store_ip_path.dataset.path;
				var id = store_id.dataset.id;
				const url = origin+"/notifications/send-data/payment"+id;
				console.log(url);
				var dataToStore = {
						"payment_id" : payment_seq.dataset.seq,
						"member_ip_path" : store_ip_path.dataset.path,
						};
				console.log(url);
				fetch(url, {
			        method: 'POST',
			        headers: {
			            'Content-Type': 'application/json',
			            'charset': 'utf-8'
			        },
			        body: JSON.stringify(dataToStore) // 수정: dataToUser를 전송하도록 수정
			    })
				
			}
		} 
	}
	</script>

</body>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</html>