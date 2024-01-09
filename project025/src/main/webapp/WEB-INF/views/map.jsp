<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;">
	<!-- 내가 설정한 위치를 중심으로 이동 -->
	<div class="custom_locationcontrol">
		<span onclick="showMarker(2000)"><i class="fa-solid fa-location-pin"></i></span>
	</div>
	<!-- 범위 설정 -->
	<div class="custom_rangecontrol radius_border">
		<span onclick="showMarker(700)">700m</span>
		<span onclick="showMarker(1500)">1.5km</span>
	</div>
</div>







<script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=c9ae8a414e60beaf76f05c1954ec86eb&libraries=services,clusterer,drawing"></script>
<script>

/*$(function(){
	
});*/

var latitude = sessionStorage.getItem("my_addr")==null?37.55935630326601:sessionStorage.getItem("my_latitude");
var longitude = sessionStorage.getItem("my_addr")==null?126.92263631540145:sessionStorage.getItem("my_longitude");	// default; ANT빌딩

console.log("map.js: ", latitude, longitude);

var container = document.getElementById('map');
var options = {
	center: new kakao.maps.LatLng(latitude, longitude),
	level: 3
};

// 지도 생성
var map = new kakao.maps.Map(container, options);

/*var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png", // 마커이미지의 주소입니다    
imageSize = new kakao.maps.Size(30, 43); // 마커이미지의 크기입니다
//imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

//var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

var marker = new kakao.maps.Marker({
    map: map, // 마커를 표시할 지도
    position: options.center, // 마커를 표시할 위치
    title : "나~~", // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다 
    image: markerImage
});*/

/* 
 * 
  마커 
 *
 */
//마커 배열
var markers=[];
//마커가 표시될 위치입니다 
var mapStoreList=<%= request.getParameter("mapStoreList") %>;
//var mapStoreList=JSON.stringify('${mapStoreList}');
console.log("지도", mapStoreList);
var markerPositions  = [];
for (var i=0; i<mapStoreList.length; i++ ) {
	markerPositions[i]= {
	        latlng: new kakao.maps.LatLng(mapStoreList[i].store_address_latitude, mapStoreList[i].store_address_longitude)
	}
}
var selectedMarker=null;	// 클릭한 마커 담을 변수

console.log(markerPositions);

var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 

for (var i = 0; i < markerPositions.length; i ++) {
	
	// 내 위치로부터 거리 구하기
	var line = new kakao.maps.Polyline({
        map: map, // 선을 표시할 지도입니다 
        path: [options.center, markerPositions[i].latlng], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
        strokeWeight: 3, // 선의 두께입니다 
        strokeColor: '#db4040', // 선의 색깔입니다
        strokeOpacity: 0, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
        strokeStyle: 'solid' // 선의 스타일입니다
    });
	
	var distance = Math.round(Math.abs(line.getLength())), // 선의 총 거리를 계산합니다
    distanceContent = getTimeHTML(distance, marker); // 커스텀오버레이에 추가될 내용입니다

    //https://drive.google.com/uc?id=1MqIAitI3YSCU6bR4YZ-wEBtTSzbuUZ0B
	// 마커에 표시할 인포윈도우를 생성합니다
	var iwContent = '<div class="overlaybox">' +
    '    <div class="boxtitle">'+mapStoreList[i].store_name+'</div>' +
    '    <input type="checkbox" id="marker'+i+'" style="display: none;">' +
    '    <div class="first">' +
    '		 <img class="map_store_img" src="'+ mapStoreList[i].store_img_thumbnail_path+ '" alt="눈깜콩떡이"></img>'+	
    '        <div class="info text"><i class="fa-solid fa-star" style="color: #F6C002"></i> '+(mapStoreList[i].store_avg_score_number==null?'0.0':mapStoreList[i].store_avg_score_number)+'</div>' +
    '    </div>' +
    distanceContent +
    '</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwPosition = markerPositions[i].latlng; //인포윈도우 표시 위치입니다
    iwRemoveable = true; // removeable 속성을 true 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

	var infowindow = new kakao.maps.InfoWindow({
		//map: map, // 인포윈도우가 표시될 지도 -> 마우스오버 시 표시되게 할 것이므로 주석 처리~~
	    position : iwPosition, 
	    content : iwContent,
	    removable : iwRemoveable
	});
	
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: markerPositions[i].latlng, // 마커를 표시할 위치
        title : mapStoreList[i].store_name, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다 
    });
    
    markers.push(marker);
	    
	// 커스텀 오버레이에 표시할 내용입니다     
	// HTML 문자열 또는 Dom Element 입니다 
	/*var content = '<div class ="marker_label"><span class="left"></span><span class="center">'+mapStoreList[i].store_name+'</span><span class="right"></span></div>';
	// 커스텀 오버레이를 생성합니다
	var customOverlay = new kakao.maps.CustomOverlay({
		map: map,
		position: markerPositions[i].latlng,
	    content: content   
	});
	
	// 마우스오버 시 커스텀 오버레이
	var newCustomOverlayContent = '<div class="overlaybox">' +
    '    <div class="boxtitle">'+mapStoreList[i].store_name+'</div>' +
    '    <div class="first">' +
    '		 <img class="map_store_img" src="https://drive.google.com/uc?id=1MqIAitI3YSCU6bR4YZ-wEBtTSzbuUZ0B" alt="눈깜콩떡이"></img>'+	
    '        <div class="info text"><i class="fa-solid fa-star" style="color: #F6C002"></i> '+mapStoreList[i].store_avg_score_number+'</div>' +
    '    </div>' +
    '</div>';
    var newCustomOverlay = new kakao.maps.CustomOverlay({
		position: markerPositions[i].latlng,
	    content: newCustomOverlayContent   
	});*/

	
	// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    // 마우스 이벤트 리스너 추가
    // 마커에 mouseover 이벤트를 등록합니다
    //kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    //kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
    kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, infowindow, mapStoreList[i].store_id));
    
// 마커가 지도 위에 표시되도록 설정합니다
//    marker.setMap(map);
// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
//    marker.setMap(null);
}

//내 위치 마커를 커스텀 오버레이로 생성합니다
//커스텀 오버레이에 표시할 내용입니다     
//HTML 문자열 또는 Dom Element 입니다 
var content = '<i class="fa-solid fa-street-view" style="font-size: 30px; color: #F60B0B;"></i>';
//커스텀 오버레이를 생성합니다
var customOverlay = new kakao.maps.CustomOverlay({
	map: map,
	position: options.center,
 content: content,   
 title: "나!!!!!!"
});
   
// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
    	infowindow.close();
    };
}

var selectedStore;
// 핀 클릭 이벤트 -> 현재 위치로부터 도보, 자전거 시간 계산~!
//var distanceOverlay;
var scrollValue;
function makeClickListener(map, marker, infowindow, store_id) {
	
	return function() {
		infowindow.open(map, marker);
		
		if (selectedStore!=null){
			console.log(selectedStore);
			selectedStore.style.backgroundColor="#F8E5EE";
		}
			
		selectedStore=document.getElementById(eval("'store"+store_id+"'"));
		selectedStore.style.backgroundColor="#CECEF6";
		
		
		scrollValue = $('#store_list_area').scrollTop();
//		const parent=document.getElementById('store_list_area');
		const parent=document.querySelector('.store');
		const distanceBetweenParentAndChild =selectedStore.getBoundingClientRect().top - parent.getBoundingClientRect().top;
		
		console.log("현재 스크롤", scrollValue);
		console.log("목적지", distanceBetweenParentAndChild);
		
		if (Math.abs(scrollValue-distanceBetweenParentAndChild)>10){
			$('#store_list_area').animate({
		    	scrollTop: distanceBetweenParentAndChild
		    }, 500);	
		}
		/*없애주기~~
		if (distanceOverlay) {
	        distanceOverlay.setMap(null);
	        distanceOverlay = null;
	    } 
		
		// 현재 위치와 핀 거리 구하기~~
		var line = new kakao.maps.Polyline({
            map: map, // 선을 표시할 지도입니다 
            path: [options.center, marker.getPosition()], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
            strokeWeight: 3, // 선의 두께입니다 
            strokeColor: '#db4040', // 선의 색깔입니다
            strokeOpacity: 0, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다
        });
		
		var distance = Math.round(Math.abs(line.getLength())), // 선의 총 거리를 계산합니다
	        clickContent = getTimeHTML(distance, marker); // 커스텀오버레이에 추가될 내용입니다
	        
	    distanceOverlay = new kakao.maps.CustomOverlay({	// 거리정보를 표시할 커스텀오버레이
	        map: map, // 커스텀오버레이를 표시할 지도입니다
	        content: clickContent,  // 커스텀오버레이에 표시할 내용입니다
	        position: marker.getPosition(), // 커스텀오버레이를 표시할 위치입니다.
	        xAnchor: 0,
	        yAnchor: 0,
	        zIndex: 3  
	    }); */
	    	
	}
}


//클릭한 핀에 대한 도보, 자전거 시간을 계산하여
//HTML Content를 만들어 리턴하는 함수입니다
function getTimeHTML(distance, marker) {

// 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
var walkkTime = distance / 67 | 0;
var walkHour = '', walkMin = '';

// 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
if (walkkTime > 60) {
   walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
}
walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

// 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
var bicycleTime = distance / 227 | 0;
var bicycleHour = '', bicycleMin = '';

// 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
if (bicycleTime > 60) {
	 bicycleHour = '<span class="number">' + Math.floor(bicycleTime / 60) + '</span>시간 '
}
bicycleMin = '<span class="number">' + bicycleTime % 60 + '</span>분'
if(bicycleHour=='' && bicycleMin==('<span class="number">' + 0 % 60 + '</span>분')){
	bicycleMin = '<span class="number">' + 1 % 60 + '</span>분 미만'
}
// 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
var content = '<ul class="distance info">';
content += '    <li>';
content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
content += '    </li>';
content += '    <li>';
content += '        <span class="label">도보</span>' + walkHour + walkMin;
content += '    </li>';
content += '    <li>';
content += '        <span class="label">자전거</span>' + bicycleHour + bicycleMin;
content += '    </li>';
content += '</ul>'

return content;
}





/*
 * 
 지도 중심 내 위치로 이동 
 *
 */
function panTo() {
    // 이동할 위도 경도 위치를 생성합니다 
    var moveLatLon = new kakao.maps.LatLng(latitude, longitude);
    
    // 지도 중심을 부드럽게 이동시킵니다
    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
    map.panTo(moveLatLon);            
}





/*
 *
 줌 컨트롤
 *
 */
//지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);





/*
 * 
 동네 반경 설정 (일단 1km/3km)
 *
 */
var circle = new kakao.maps.Circle({});

function showMarker(radius) {
	
	console.log(radius);
	
	
	var center = options.center;
	var line = new kakao.maps.Polyline();
	
	if(radius < 2000) {
        circle.setMap(map);
        circle.setPosition(center);
        circle.setRadius(radius);
        if (radius==700){
        	map.setLevel(4);
        } else if (radius==1500){
        	map.setLevel(5);
        }
    } else {
        circle.setMap(null);
        map.setLevel(3);
    }
	
	markers.forEach(marker => {
		// 마커의 위치와 원의 중심을 경로로 하는 폴리라인 설정
	    var path = [ marker.getPosition(), center ];
	    line.setPath(path);
	    
	 	// 마커와 원의 중심 사이의 거리
	    var dist = line.getLength();

	    // 이 거리가 원의 반지름보다 작거나 같다면
	    if (dist <= radius) {
	        // 해당 marker는 원 안에 있는 것
	    	marker.setMap(map);
	    } else {
            marker.setMap(null);
        }
	});
	
	panTo();
}

//map.setCenter(locPosition); 맵 중심좌표 변경

	
</script>
