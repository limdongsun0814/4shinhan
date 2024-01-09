<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment | 빵이오4</title>
<style>
.total_container {
	padding:2% 8%;
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
	padding:10px 20px;
	margin-left:3%;
	width:12rem;
	cursor:pointer;
}
#paymentOn:hover{
	background-color:#D4C570;
}
.payment_wrapper{
	width:80%;
	margin:0 3%;
}
 .paymentStatus{
 	font-size:1.5rem;
 	border-radius:5px;
 	border:1px solid black;
 	padding:8px 15px;
 	cursor:pointer;
 }

 
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/ownerHeader.jsp"%>
<div class="all">
	<div class="side">
		<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>
	</div>
	<div class="payment_wrapper">
	  <div class="payment_header">
		<h3 class="owner_title">현재 주문 내역</h3>
		<h4>현재 시간: <span id="clock"></span></h4>
	  </div>

	  <button id="paymentOn">주문 새로 고침</button>
	  <div class="total_container" id="total_ajax"></div>
	</div>
</div>
<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
<script src="${pageContext.request.contextPath}/resources/js/clock.js" type="text/javascript"></script>
<script>
window.onload = function(){
	getPaymentData();
	realTimeClock();
	colorChange();
}
document.querySelector("#paymentOn").addEventListener('click', getPaymentData);
function getPaymentData(){
	$.ajax({
		url:"${pageContext.request.contextPath}/paymentStatus.do",
		success: function(responseData){
			$("#total_ajax").html(responseData);
			console.log("success");
			colorChange()
		},
		error: function(){
			console.log("error");
		}
	})
}
</script>
<script>
	
	function isJSON(str) {
	    try {
	        JSON.parse(str);
	    } catch (e) {
	        return false;
	    }
	    return true;
	}
	
	
	function helloWorld(str){
		console.log("helloworld", str);
        let date = new Date().toLocaleString();
        let notification;
        let notificationPermission = Notification.permission;
        
        if (notificationPermission === "granted") {
            //Notification을 이미 허용한 사람들에게 보여주는 알람창
            //맨 위 제목
            if(isJSON(str)){
            	data = `주문 번호: `+JSON.parse(str).payment_id;
            	notification = new Notification(`빵이오 주문!`, {
            		icon: './resources/images/0254logo.svg',
                    body: data,
                });
            	//해당 부분 redirect로?
            	notification.onclick = function(e){
            		e.preventDefault();
            		getPaymentData();
            		notification.close();
            	}

            } else{
            	notification = new Notification(`빵이오 주문!`, {
            		icon: './resources/images/0254logo.svg',
                    body: str,
                });
            }
        } else if (notificationPermission !== 'denied') {
            //Notification을 거부했을 경우 재 허용 창 띄우기
            Notification.requestPermission(function (permission) {
                if (permission === "granted") {
                    notification = new Notification(`빵이오 주문 접수 시작!`, {
                        body: `지금부터 알림을 받습니다 : ${date}`,
                    });
                }else {
                    alert("알람 허용이 거부되었습니다.")
                }
            });
        }
    } 
	</script>
	<script>
	//부모 탐색 function
	function findAncestor(el, className) {
	    while ((el = el.parentElement) && !el.classList.contains(className));
	    return el;
	}

	function sendStatus(target) {
	    alert('주문 ' + target.dataset.seq + '을(를) 업데이트 하시겠습니까?');

	    var data = {
	        seq: target.dataset.seq,
	        path: target.dataset.path,
	        status: target.dataset.status,
	        get: target.dataset.get,
	        member_id: target.dataset.member_id
	    };
	    //data-status가 2일 때 4로 넘어가면 바로 지울 수가 없음
	    if (data.status == 3) {
	    	var paymentContainer = findAncestor(target, 'payment_container');
	    	console.log(data.status, paymentContainer);
	        if (paymentContainer) {
	            paymentContainer.remove();
	        }
	    } 

	    $.ajax({
	        url: "${pageContext.request.contextPath}/updatePaymentStatus.do",
	        type: 'POST',
	        data: data,
	        success: function(responseData) {
	        	 var parser = new DOMParser();
	             var htmlDoc = parser.parseFromString(responseData, 'text/html');
	             var paymentStatus = htmlDoc.querySelector(".paymentStatus");
	             
	             //4일 때 지우기
	             if (paymentStatus && ( paymentStatus.dataset.status == 4)) {
	                 var paymentContainer = findAncestor(target, 'payment_container');
	                 console.log(data.status, paymentContainer);
	                 if (paymentContainer) {
	                     paymentContainer.remove();
	                 }
	             }
	        	
	            target.outerHTML = responseData;
	            console.log("success");
	            colorChange(target);
	            sendToUser(data);
	        },
	        error: function() {
	            console.log("error");
	        }
	    });
	}
	
	</script>
	<script>
	function statusParse(status){
		if(status == 0){
			return '접수완료';
		} else if(status == 1){
			return '수락완료';
		} else if(status == 2){
			return '준비완료';
		} else if(status == 3){
			return '배달출발';
		} else if(status == 4){
			return '수령대기';
		} else {
			return '상태확인';
		}
	}
	</script>
	<script>
	//url에 memberid 더하기
	function sendToUser(data) {
		console.log("send to user");
	    var origin = data.path;
	    var url = origin + '/notifications/send-data/paymentStatus' + data.member_id;
	    var dataToUser = {status:`주문번호: \${data.seq}, 상태확인 : \${statusParse(data.status)}`};

	    fetch(url, {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json',
	            'charset': 'utf-8'
	        },
	        body: JSON.stringify(dataToUser) // 수정: dataToUser를 전송하도록 수정
	    })
/* 	    .then(response => {
	        if (response.ok) {
	            console.log('데이터 전송 성공');
	        } else {
	            console.log('데이터 전송 실패');
	        }
	    })*/
	    .catch(error => {
	        console.log('유저 서버 닫힘:', error);
	    }); 
	}
	</script>
	<script>
		const eventSource = new EventSource('${store.store_ip_path}/notifications/subscribe/payment${store.store_id}');
		console.log(eventSource);
		eventSource.addEventListener('sse', event => {
			console.log(event);
			console.log("여기"+eventSource);
			const decodedString = decodeURIComponent(event.data);
			//수신 시 console 출력
			console.log("decoded", decodedString);
			helloWorld(decodedString);
		});
	</script>
	<script>
	//색깔 변화
	function colorChange(){
		document.querySelectorAll(".paymentStatus").forEach(function(button) {
			  var status = button.getAttribute("data-status");
 
			 
				  switch (status) {
			  
			    case "0":
			      button.style.backgroundColor = "#D9D9D9";
			      button.innerText = "대기";
			      break;
			    case "1":
			      button.style.backgroundColor = "#B1D6E4";
			      button.innerText = "수락";
			      break;
			    case "2":
			      button.style.backgroundColor = "#F8C9DF";
			      button.innerText = "준비완료";
			      break;
			    case "3":
			      button.style.backgroundColor = "#FFEC9F";
			      button.innerText = "배달출발";
			      break;
			    default:
			      // 기본 색상 설정
			      button.style.backgroundColor = "gray";
			      break;
			  }
			});
	}
	</script>
</body>
</html>