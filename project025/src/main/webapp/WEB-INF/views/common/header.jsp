<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>


<html>
<head>
<!-- <title>Home</title> -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<script src="https://kit.fontawesome.com/f719d238b7.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
#img_btn{
  position:relative;
}
#alarm_count{
  position:absolute;
  width:18px;
  height: 18px;
  border-radius: 15.5px;
  background-color: #E87D7D;
  left: 31px;
  top: -2px;
  font-size: 17px;
  font-weight: bold;
  visibility:hidden;
}
</style>

<script>
function deleteAllAlarm() {
	  var flag=confirm("알림을 모두 삭제하시겠습니까?");
	  if(flag){
		  $.ajax({
			  url : "${cpath}/member/deleteAllAlarm.do",
			  success : function (responseData) {
				  $(".alarm_row").remove();
				  console.log("알람이 삭제됨");
			  },
			  error : function () {
				  console.log("알람 삭제 ajax 오류");
			  }
		  });
	  }
}
</script>
</head>
<body>
<div class="header">
	<div class="bbang_center">
		<div class="container">
			<div class="logo">
				<a href="${pageContext.request.contextPath}/">
					<img src="${pageContext.request.contextPath}/resources/images/025logo.png" alt="로고" />
				</a>
			</div>
			<div class="search">
				<button id="header_address" class="header_address" onclick="get_my_address()">
					<div id="header_address_txt" class="header_address_txt"></div>
				</button>
				<form action="${pageContext.request.contextPath}/store/storeSearch.do">
					<input class=e145_437 id="store_search" name="store_search_name" placeholder="검색어를 입력하세요.">
					<input type="submit" id="store_search_submit" style="display: none">
					<input type="hidden" id="lat" name="lat">
					<input type="hidden" id="lng" name="lng">
					<label for="store_search_submit" onclick="store_search_function()" style="position: absolute; left: 3%; top: 18%; cursor: pointer;"><img src="${pageContext.request.contextPath}/resources/images/search.png"></label>
				</form>
				<!-- <input type="button" onclick="store_search_function()" id="store_search" style="display: none"> -->
			</div>
			<div class="head-right">
				<div class="auth">
					<c:if test="${sessionScope.member == null}">
						<a href="${pageContext.request.contextPath}/memberjoinpage.do">회원가입</a>
					</c:if>
					<a href="${pageContext.request.contextPath}/memberlogin.do">${sessionScope.member ne null ? "로그아웃": "로그인"}</a>
					<a href="${pageContext.request.contextPath}/cart.do">
						<!-- <img src="${pageContext.request.contextPath}/resources/images/cart.png" alt="장바구니" /> -->
						<i class="fa-solid fa-cart-shopping" style="font-size: 17px"></i>
					</a>
					<a href="${cpath}/mypage/myPageMain.do">
						<!-- <img src="${pageContext.request.contextPath}/resources/images/mypage.png" alt="마이페이지" /> -->
						<i class="fa-solid fa-user" style="font-size: 17px"></i>
					</a>
				</div>
				<div class="alarm">
					<!-- 알림함 모달 띄우는 버튼 -->
					<button type="button" class="btm_image" id="img_btn" onclick="btn_event()">
						<div id="alarm_count"></div><!-- 알림 개수 여기다가 표시 -->
						<i class="fa-solid fa-envelope" style="color: #F8C9DF; font-size: 40px"></i>
					</button>
 
					<!-- 모달 팝업창 -->
					<div id="modalWrap" style="display: none;">
					  <div id="modalContent">

					    <div id="modalBody">
					      
					      <!-- 팝업창 내 글귀 -->
					      <p>
					      	<a id="bread" style="font-weight: bold; color: black;">빵 나왔어요~~!</a>
					      	<i id="trash" class="fa-solid fa-trash-can" onclick="deleteAllAlarm()" style="cursor: pointer; margin-left: 25px; margin-right: 200px"></i>
					      	<span id="closeBtn"><i class="fa-solid fa-xmark"></i></span> <!-- 닫기 버튼 -->
					      </p>
					      <div class="content" id="content"></div>
					    </div>
					  </div>
					</div>
					  					
					
					
					<div class="history">
					<a href="${pageContext.request.contextPath}/payment/orderStatus.do">주문현황</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c9ae8a414e60beaf76f05c1954ec86eb&libraries=services,clusterer,drawing"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
/* 
function store_search_function(){
	console.log("검색 버튼 누름");
	var store_name_value = document.getElementById('store_search').value
	var search_name = {"name":store_name_value};
	$.ajax({
		url: "${cpath}/store/storeSearch.do",
		data:search_name,
		success: function(res){
			console.log(res);
			document.getElementById
		},
		error:function(){
			alert('ajax 실패');
		}
	});
} */

var geocoder = new kakao.maps.services.Geocoder();
  $(document).ready(function () {
	  if (sessionStorage.getItem("my_addr")==null) {
		  sessionStorage.setItem("my_addr", "서울 마포구 월드컵북로4길 77");
			sessionStorage.setItem("my_latitude", 37.5593899313277);
			sessionStorage.setItem("my_longitude", 126.922668197194);
		  $("#header_address_txt").text("서울 마포구 월드컵북로4길 77");
	  } else {
		  $("#header_address_txt").text(sessionStorage.getItem("my_addr"));
	  }
	  
    $("#modalWrap").hide();

    function countNewAlarm() {
        $.ajax({
            url: "${cpath}/member/countNewAlarm.do",
            success: function(responseData) {
                // 서버에서 받아온 알림 개수를 표시하는 요소에 반영
                var alarmCount = parseInt(responseData);
                var isMemberNull = ${sessionScope.member == null};
                
                if (!isNaN(responseData) && (alarmCount > 0 || isMemberNull)) {
				    $("#alarm_count").text(alarmCount);
				    $("#alarm_count").css({
				        'visibility': 'visible',  // 보이기
				    });
				} else {
				    $("#alarm_count").css('visibility', 'hidden');  // 숨기기
				}
            },
            error: function() {
                console.error("알림 개수를 가져오는데 실패했습니다.");
            }
        });
    }
	
    countNewAlarm();
    
    
      function getBreadAlarm() {
      $.ajax({
        url: "${cpath}/member/getBreadAlarm.do",
        success: function (responseData) {
        	console.log(responseData);
          $("#content").html(responseData);
        }
      });
    }
      
      
	
      /* document.getElementById('img_btn').onclick = function() {
    	  getBreadAlarm();
    	};  */
      
	   /* function getNoticeAlarm() {
	     resetLinks();
	     selectedLink = $("#notice");
	     $.ajax({
	       url: "${cpath}/member/getNoticeAlarm.do",
	       success: function (responseData) {
	         $("#content").html(responseData);
	         selectedLink.css("color", "red");
	         selectedLink.css("font-weight", "bold");
	       }
	     });
	   }
	
	   function getSubscribeAlarm() {
	     resetLinks();
	     selectedLink = $("#subscribe");
	     $.ajax({
	       url: "${cpath}/member/getSubscribeAlarm.do",
	       success: function (responseData) {
	         $("#content").html(responseData);
	         selectedLink.css("color", "red");
	         selectedLink.css("font-weight", "bold");
	       }
	     });
	   } */
	
	// 링크에 클릭 이벤트 핸들러 추가
//	   $("#bread").on("click", getBreadAlarm);
//	   $("#notice").on("click", getNoticeAlarm);
//	   $("#subscribe").on("click", getSubscribeAlarm);
	 });
  

    document.addEventListener("DOMContentLoaded", function () {
        var links = document.querySelectorAll(".menu a");

        links.forEach(function (link) {
            link.addEventListener("click", function () {
                // 이전에 선택된 링크의 클래스를 제거
                document.querySelector(".menu a.active").classList.remove("active");
                              // 현재 클릭된 링크에 active 클래스 추가
                this.classList.add("active");
            });
        });
    });
  
var callback = function(result, status) {
	if (status === kakao.maps.services.Status.OK) {
		sessionStorage.setItem("my_latitude", result[0].y);
		sessionStorage.setItem("my_longitude", result[0].x);
		document.getElementById("lng").value=result[0].x;
		document.getElementById("lat").value=result[0].y;
		$.ajax({
		       url: "${cpath}/sessionUpdateAddress.do",
		       data:{"lng":sessionStorage.getItem("my_latitude"),
		    	   "lat":sessionStorage.getItem("my_longitude")},
		       success: function (responseData) {
		    	   console.log("address session에 저장 완료");
		    	   Location.reload();

	       }
	     });
		
		console.log("tttttttttttt");
		console.log(sessionStorage.getItem("my_latitude"));
		
		//location.reload(true);
		$("#map_here").load(window.location.href + "#map_here");
	}
};
  
function get_my_address() {
	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            
         	// 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
            	extraAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
            	extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraAddr !== ''){
            	extraAddr = ' (' + extraAddr + ')';
            }
            
            sessionStorage.setItem("my_addr", addr);    	
            geocoder.addressSearch(addr, callback);
            $("#header_address_txt").text(addr);
    		
            console.log("헤더-session: ", sessionStorage.getItem("my_latitude"), "헤더: ", my_lat);
        	
            filtering("all", "star", my_lat, my_lng);
            filtering_map("all", "star", my_lat, my_lng);
     
        }
    }).open();
}

//const btn = document.getElementById('img_btn');
var modal = document.getElementById('modalWrap');
var closeBtn = document.getElementById('closeBtn');



//btn.onclick = 
function btn_event() {
	
	var membervo = "${member}";
	if(membervo==''){
	 location.href="${cpath}/filter.do";
	} else {
		document.body.style.overflow = 'hidden';
		modal.style.display = 'block';
		$("#img_btn").html('<i class="fa-solid fa-envelope-open" style="color: #F8C9DF; font-size: 35px"></i>');

		$.ajax({
			url: "${cpath}/member/getBreadAlarm.do",
			success: function (responseData) {
				console.log(responseData);
				$("#content").html(responseData);
			}
		});
	}
}

closeBtn.onclick = function() {
	$("#img_btn").html('<i class="fa-solid fa-envelope" style="color: #F8C9DF; font-size: 40px"></i>');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
    $("#img_btn").html('<i class="fa-solid fa-envelope" style="color: #F8C9DF; font-size: 40px"></i>');
  }
}
</script>
<%-- <script src="${cpath}/resources/js/alarmbox.js"></script> --%>
</body>
</html>