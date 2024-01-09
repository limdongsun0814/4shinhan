<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- portOne SDK 가져오기 -->
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<script>
		IMP.init('imp47436353');
		function requestPay() {
		    IMP.request_pay({
		      pg: "kcp.{상점ID}",
		      pay_method: "card",
		      merchant_uid: "ORD20180131-0000011",   // 주문번호
		      name: "노르웨이 회전 의자",
		      amount: 64900,                         // 숫자 타입
		      buyer_email: "gildong@gmail.com",
		      buyer_name: "홍길동",
		      buyer_tel: "010-4242-4242",
		      buyer_addr: "서울특별시 강남구 신사동",
		      buyer_postcode: "01181"
		    }, function (rsp) { // callback
		      //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
		      
		    })
		};
	</script>
</body>
</html>
