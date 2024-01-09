<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c9ae8a414e60beaf76f05c1954ec86eb&libraries=services,clusterer,drawing"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://kit.fontawesome.com/f719d238b7.js" crossorigin="anonymous"></script>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Home | 빵이오</title>


<!-- 헤더 -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/cart/miniCart.jsp" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/storelist.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/map.css">
<link rel="icon" href="${pageContext.request.contextPath}/resources/favicon/favicon.ico" type="image/x-icon"/>
<style>
.slide_prev_button{
	left:8%;
}
.slide_next_button{
	right:8%;
}
</style>
</head>

<body>
	<br><br>
	<!-- 이벤트 -->
	<div class="slide slide_wrap">
		<div class="slide_item item1">
			<img src="${pageContext.request.contextPath}/resources/images/025eventbanner3.png" alt="이벤트" style="width: 1200px; height: 500px; border-radius: 20px;">
		</div>
		<div class="slide_item item2">
			<img src="${pageContext.request.contextPath}/resources/images/025eventbanner.png" alt="이벤트" style="width: 1200px; height: 500px; border-radius: 20px;">
		</div>
		<div class="slide_item item3">

			<img src="${pageContext.request.contextPath}/resources/images/025eventbanner2.png" alt="이벤트" style="width: 1200px; height: 500px; border-radius: 20px">
		</div>
		<div class="slide_prev_button slide_button"><i class="fa-solid fa-chevron-left"></i></div>
		<div class="slide_next_button slide_button"><i class="fa-solid fa-chevron-right"></i></div>
		<ul class="slide_pagination"></ul>
    </div>
	<!-- Home Body -->
	<div class="container" id="container">
		<!-- 가게 리스트 영역 -->
		<div class="store_area">
			<!-- 가게 리스트 사이드바 -->
			<div class="store_sidebar">
				<!-- 주문 타입 필터링(전체/픽업만/배달만) -->
				<div class="orderType_area">
					<!-- 전체 -->
					<label class="Type" id="all">
					  <div class="orderType on">
					    <input type="radio" name="value1" />
					    <div class="orderType_title">전체</div>
					  </div>
					</label>
					<!-- 픽업 -->
					<label class="Type" id="pickup_ok">
					  <input type="radio" name="value1" />
					  <div class="orderType">
					    <div class="orderType_title">픽업 OK</div>
					  </div>
					</label>
					<!-- 배달 -->
					<label class="Type" id="delivery_ok">
					  <input type="radio" name="value1" />
					  <div class="orderType">
					    <div class="orderType_title">배달 OK</div> 
					  </div>
					</label>
				</div>
				<br><br>
				<!-- 정렬(별점순/거리순/리뷰많은순/판매량순) -->
				<div class="sortType_area">
					<!-- 별점순 -->
					<label class="SType" id="star">
					  <div class="sortType on">
					    <input type="radio" name="value2" />
					    <div class="sortType_title">별점</div>
					  </div>
					</label>
					<!-- 거리순 -->
					<label class="SType" id="distance">
					  <input type="radio" name="value2" />
					  <div class="sortType">
					    <div class="sortType_title">거리</div>
					  </div>
					</label>
					<!-- 리뷰많은순 -->
					<label class="SType" id="review">
					  <input type="radio" name="value2" />
					  <div class="sortType">
					    <div class="sortType_title">리뷰</div> 
					  </div>
					</label>
					<!-- 판매량순 -->
					<label class="SType" id="sales">
					  <input type="radio" name="value2" />
					  <div class="sortType">
					    <div class="sortType_title">판매량</div> 
					  </div>
					</label>
					<!-- 판매량순 -->
					<label class="SType" id="heart">
					  <input type="radio" name="value2" />
					  <div class="sortType">
					    <div class="sortType_title">찜</div> 
					  </div>
					</label>
				</div>
			</div>
			<!-- 가게&지도 -->
			<div class="store_right_area">
				<!-- 가게 리스트 출력 -->
				<div class="store_list_area" id="store_list_area">
					<div id="store_list_here"></div>
				</div>
				<!-- 지도 -->
				<div class="store_map_area" id="map_here">
					
				</div>
			</div>
		</div>
		
		<!-- 베스트 메뉴 -->
		<div class="best_area">
			<div class="best_title">
				<div style="font-size: 30px;">- BEST MENU - </div>
			</div>
			<div class="menu_list_area" id="menu_list">
				여기
			</div>
			
		</div>
	</div>

</script><script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/slide.js"></script>	
<script>

var order_type="";
var sort_type="";
var my_lat;
var my_lng;
var scrollValue;

$(function(){
	
	console.log("home-session: ", sessionStorage.getItem("my_latitude"), "home: ", my_lat);
	//get_all_stores();
	//get_all_stores_map();
	filtering(order_type, sort_type, my_lat, my_lng);
    filtering_map(order_type, sort_type, my_lat, my_lng);
	get_best_menu();

});

function get_best_menu(){
	$.ajax({
		url: "${cpath}/getBestMenuList.do",
		dataType: 'json',
		success:function(responseData){
			let htmlStr=``;
			let i=1;
			for(data of responseData){
				console.log(data);
				htmlStr+=`
					<div style="position: relative;">
						<a href="${cpath}/store/getMenuDetail.do?menu_id=\${data.menu_id}" style="width: 250px; height: 300px;">
							<div class="best_menu" id="best_menu\${i}">
								<img class="best_menu_img" src="\${data.menu_thumb_image_path!=null?data.menu_thumb_image_path:'https:\/\/drive.google.com\/uc?id=14Top-Dg-8l4S0J3PyvXsawOYHfMhACw4'}" alt="베스트메뉴"></img>
								<div class="top_info">
									<button class="menu_store_name">\${data.store_name}</button>
								</div>
								<div class="bottom_info">
								<div class="bottom_info_left">
									<div class="best_menu_name">\${data.menu_name}</div>
									<div class="best_menu_price" style="margin-top: 3px;">\${data.menu_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")} 원</div>
									
								</div>
							</div>
							<!--<i class="fa-solid fa-award"></i>-->
							</div>
						</a>
						<button type="button" class="best_cart" style="z-index: 10;" onclick="addToCart(\${data.menu_id})">장바구니</button>
					</div>
					`;
				i++;
			}
		
			
			var menuList = document.getElementById("menu_list");
			menuList.innerHTML = htmlStr;
			
			/*	$('#menu_list').html(htmlStr); */
			
			
		},
		error:function(){
			console.log("ajax 오류");
		}
	});
}

function get_all_stores(){
	console.log("뭐임");
	$.ajax({
		url: "${cpath}/store/getAllStoreList.do?lat=37.55935630326601&lng=126.92263631540145",
		success:function(responseData){
			$("#store_list_here").html(responseData);
		},
		error:function(){
			console.log("ajax 오류");
		}
	});
}

function addToCart(menu_id) {
	// 로그인X -> 로그인해주세요.
	// 로그인O -> 클릭이벤트
	/* console.log("장바구니"); */
    var menu_obj = {"cart_product_menu_id":menu_id};
    $.ajax({
        type:"POST",
        url:"${cpath}/CartInsertOne.do",
        data:menu_obj,//JSON.stringify(id_object),
        //contentType: "application/json; charset=utf-8;",
        success:function(res){
        	if(res.login_check){
        		alert(res.result);
        		location.reload();
        	}else{
        		alert(res.result);
        		 location.href='${cpath}/memberlogin.do';
        	}
        },
        error:function(){
            alert('ajex 실패');
        }
    });
}

$(".Type").click(function (e) {
    e.preventDefault();
    var id = $(this).attr("id");
    console.log(id);

    $(".Type .orderType").removeClass("on");

    $("#" + id + " .orderType").addClass("on");
    
    order_type=id;
    filtering(order_type, sort_type, my_lat, my_lng);
    filtering_map(order_type, sort_type, my_lat, my_lng);
     
    $('#store_list_area').animate({
    	scrollTop: 0
    }, 500);
    
    //$("#map").load(window.location.href + "#map");
});

$(".SType").click(function (e) {
    e.preventDefault();
    var id = $(this).attr("id");
    console.log(id);

    $(".SType .sortType").removeClass("on");

    $("#" + id + " .sortType").addClass("on");
    
    sort_type=id;
    filtering(order_type, sort_type, my_lat, my_lng);
    filtering_map(order_type, sort_type, my_lat, my_lng);
    
    $('#store_list_area').animate({
    	scrollTop: 0
    }, 500);
    //$("#map").load(window.location.href + "#map");
});

function filtering(ot, st, my_lat, my_lng) {
	
	my_lat=sessionStorage.getItem("my_latitude");
	my_lng=sessionStorage.getItem("my_longitude");
	
	if (my_lat==null) {
		my_lat=37.55935630326601;
	}
	
	if (my_lng==null) {
		my_lng=126.92263631540145;
	}

	var url="${cpath}/store/getStoreListByFiltering.do?order_type="+ot+"&sort_type="+st+"&lat="+my_lat+"&lng="+my_lng;
	console.log(url);
    
    $.ajax({
		url: url,
		success:function(responseData){
			$("#store_list_here").html(responseData);
		},
		error:function(){
			console.log("ajax 오류");
		}
	});
}

function get_all_stores_map(){
	$.ajax({
		url: "${cpath}/store/getAllStoreListMap.do?lat=37.55935630326601&lng=126.92263631540145",
		success: function(data){   
			console.log(data);
			
			localStorage.setItem("mapStoreList", JSON.stringify(data));
			
		},
		error:function(){
			console.log("map:ajax 오류");
		}
	});
}

//var mapStoreList;
function filtering_map(ot, st, my_lat, my_lng) {
	console.log("으으아아아아악");
	
	my_lat=sessionStorage.getItem("my_latitude");
	my_lng=sessionStorage.getItem("my_longitude");
	
	if (my_lat==null) {
		my_lat=37.55935630326601;
	}
	
	if (my_lng==null) {
		my_lng=126.92263631540145;
	}

	var url="${cpath}/store/getStoreListByFilteringMap.do?order_type="+ot+"&sort_type="+st+"&lat="+my_lat+"&lng="+my_lng;
	console.log(url);
    
    $.ajax({
		url: url,
		success: function(responseData){   
			console.log("필터링 맵: ", responseData);
			//$("#map_here").html(responseData);
			//localStorage.setItem("mapStoreList", JSON.stringify(data));
			$("#map_here").load("store/getMap.do", {mapStoreList: JSON.stringify(responseData)});
			//sessionStorage.setItem("mapStoreList", JSON.stringify(responseData));
		},
		error:function(){
			console.log("map:ajax 오류");
		}
	});
}
function go_heart_insert_function(store_id){
    var menu_obj = {"store_id":store_id};
    console.log(store_id);
    $.ajax({
        type:"POST",
        url:"${cpath}/store/insertHeartStoreAjax.do",
        data:menu_obj,//JSON.stringify(id_object),
        //contentType: "application/json; charset=utf-8;",
        success:function(res){
        	if(res.login_check){
        		alert(res.result);
        		document.getElementById('heart_on').style.display = 'block';
        		document.getElementById('heart_off').style.display = 'none';
        	}else{
        		alert(res.result);
        		 location.href='${cpath}/memberlogin.do';
        	}
        },
        error:function(){
            alert('ajex 실패');
        }
    });
}
function go_heart_delete_function(store_id){
    var menu_obj = {"store_id":store_id};
    console.log(store_id);
    $.ajax({
        type:"POST",
        url:"${cpath}/store/deleteHeartStoreAjax.do",
        data:menu_obj,//JSON.stringify(id_object),
        //contentType: "application/json; charset=utf-8;",
        success:function(res){
        	if(res.login_check){
        		alert(res.result);
        		document.getElementById('heart_on').style.display = 'none';
        		document.getElementById('heart_off').style.display = 'block';
        	}else{
        		alert(res.result);
        		 location.href='${cpath}/memberlogin.do';
        	}
        },
        error:function(){
            alert('ajex 실패');
        }
    });
}
</script>
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</html>