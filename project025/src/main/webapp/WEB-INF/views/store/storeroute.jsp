<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/storeroute.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  
<div class="storeAddress_top">찾아 오시는 길</div>
	
<div id="mapaa" style="width:800px; height:500px;"></div>

<script>
var containeraa = document.getElementById('mapaa'); //지도를 담을 영역의 DOM 레퍼런스
console.log(containeraa);

var latitude = ${storeAddress[0].store_address_latitude}; // 위도 정보를 변수로 저장
console.log(latitude);

var longitude = ${storeAddress[0].store_address_longitude}; // 경도 정보를 변수로 저장
console.log(longitude);

var options = { //지도를 생성할 때 필요한 기본 옵션
	center : new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
	level : 3
};
console.log(options);
var map = new kakao.maps.Map(containeraa, options); 

var imageSrc = '${pageContext.request.contextPath}/resources/images/bread_marker.png', // 마커이미지의 주소입니다    
imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

// 마커가 표시될 위치입니다 
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition,
    image: markerImage
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null);    
</script>



<div class="bottom">
	<div class="left-content">
		<div class="store_name2">
			<p style="font-weight: bold;">상호명</p>
			<p style="font-size: 18px;">${storeAddress[0].store_name}</p>
		</div>
		<div class="store_phone">
			<p style="font-weight: bold;">전화번호</p>
			<p style="font-size: 18px;">${storeAddress[0].store_phone}</p>
		</div>
		<div class="store_operation_hour">
			<p style="font-weight: bold;">영업 시간</p>
			<p style="font-size: 18px;">${storeAddress[0].store_operation_hour}</p>
		</div>
	</div>
	
	<div class="right-content">
		<div class="store_address">
			<p style="font-weight: bold;">가게 주소</p>
			<p style="font-size: 18px;">${storeAddress[0].store_address} ${storeAddress[0].store_address_detail}</p>
		</div>
		<div class="store_sale_method">
		    <p style="font-weight: bold;" id="pickupInfo"></p>
		    <p style="font-weight: bold;" id="deliveryInfo"></p>
		    <p style="font-weight: bold;" id="subscribeInfo"></p>
		</div>
		<div class="store_regular_close_date">
			<p style="font-weight: bold;">정기 휴무일</p>
			<p style="font-size: 18px;">${storeAddress[0].store_closed_date}</p>
		</div>
	</div>
</div>	

<script>
    var pickupInfo = document.getElementById('pickupInfo');
    var deliveryInfo = document.getElementById('deliveryInfo');
    var subscribeInfo = document.getElementById('subscribeInfo');

    pickupInfo.innerText = ${storeAddress[0].store_is_pickup} ? '픽업 O | ' : '픽업 X';
    deliveryInfo.innerText = ${storeAddress[0].store_is_delivery} ? '배달 O' : '배달 X';
    //subscribeInfo.innerText = ${storeAddress[0].store_is_subscribe} ? '구독 O' : '구독 X';
</script>