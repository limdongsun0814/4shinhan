<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyOrder | 빵이오</title>
<style>
@font-face {
    font-family: 'SeoulNamsanM';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/SeoulNamsanM.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

* {
	font-family: 'SeoulNamsanM';
}

.total_container {
	padding:2% 8%;
	min-height: 900px;
    height: auto;
}
.payment_header{
	display:flex;
	justify-content:space-between;
	align-items:center;
	padding:0 3%;
}
#paymentOn {
	background-Color:#FFEC9F;
	font-size:1.3rem;
	font-weight:600;
	border:0.5px solid #94CA1F;
	border-radius:5px;
	padding:5px 5px;
	margin-left:3%;
	width:10rem;
	cursor:pointer;
}
#paymentOn:hover{
	background-color:#D4C570;
}
.payment_wrapper{
	width:70%;
	margin:0 auto;
}
 .paymentStatus, .orderDelete{
 	font-size:1.5rem;
 	border-radius:5px;
 	border:1px solid black;
 	padding:8px 15px;
 }

 .payment_header > h3 {
 	font-size:1.5rem;
 }
 
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="payment_wrapper">
  <div class="payment_header">
    <h3>주문 현황</h3>
    <button id="paymentOn">주문 새로 고침</button>
  </div>
  
  <div class="total_container" id="total_ajax"></div>
</div>
</body>
<script>
window.onload = getPaymentData();
document.querySelector("#paymentOn").addEventListener('click', getPaymentData);
function getPaymentData(){
	console.log("주문현황 새로고침");
	$.ajax({
		url:"${pageContext.request.contextPath}/payment/orderStatusList.do",
		success: function(responseData){
			$("#total_ajax").html(responseData);
			console.log("success");
		},
		error: function(){
			console.log("error");
		}
	})
}
</script>
<script>
	const eventSource = new EventSource('${member.member_ip_path}/notifications/subscribe/paymentStatus${member.member_id}');
	eventSource.addEventListener('sse', event => {
		console.log(event);
		const decodedString = decodeURIComponent(event.data);
		//수신 시 console 출력
		console.log("decoded", decodedString);
		helloWorld(decodedString);
	});
	
	function isJSON(str) {
		jsonString = str.replace(/=/g, ':');

		console.log("뭐가 들어왔나", jsonString);
	    try {
	        JSON.parse(jsonString);
	    } catch (e) {
	    	console.log('not json');
	        return false;
	    }
	    console.log("json");
	    return true;
	}
	
	
	function helloWorld(str){
        let date = new Date().toLocaleString();
        let notification;
        let notificationPermission = Notification.permission;
        
        if (notificationPermission === "granted") {
            //Notification을 이미 허용한 사람들에게 보여주는 알람창
            //맨 위 제목
            if(isJSON(str)){
            	str = str.replace(/=/g, ':');
            	data = `주문 번호: `+${JSON.parse(str).payment_id} +`주문 현황을 확인하세요!`;
            	notification = new Notification(`빵이오 주문알림!`, {
                    body: data,
                });
            	//해당 부분 redirect로?
            	notification.onclick = function(e){
            		e.preventDefault();
            		getPaymentData();
            		notification.close();
            	}
            	console.log(notification);

            } else{
            	notification = new Notification(`빵이오 주문알림!`, {
            		icon:'../resources/images/025logo.svg',
                    body: str,
                });
            	notification.onclick = function(e){
            		e.preventDefault();
            		getPaymentData();
            		notification.close();
            	}
            	console.log(notification);
            }
        } else if (notificationPermission !== 'denied') {
            //Notification을 거부했을 경우 재 허용 창 띄우기
            Notification.requestPermission(function (permission) {
                if (permission === "granted") {
                    notification = new Notification(`빵이오 현황 확인!`, {
                    	icon:'./resources/images/025logo.png',
                        body: `지금부터 알림을 받습니다 : ${date}`,
                    });
                }else {
                    alert("알람 허용이 거부되었습니다.")
                }
            });
        }
    } 
	</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</html>