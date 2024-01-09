<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c9ae8a414e60beaf76f05c1954ec86eb&libraries=services,drawing"></script>
<script src="https://kit.fontawesome.com/f719d238b7.js" crossorigin="anonymous"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>STORE | 빵이오</title>
<!-- 헤더 -->
<style>
.menu_table{
	display:grid;
	grid-template-columns:1fr 4fr;
	text-align:center;
	padding:1rem 1rem;
	grid-row-gap:10px;
	word-break:keep-all;
}
.menu_table > .menu_time_head{
	font-weight:600;
}
</style>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/storedetail.css">
</head>
<body>
<%@ include file="/WEB-INF/views/cart/miniCart.jsp" %>
	<div class="body_container">
		<div class="top_area">
			<div class="top_content">
				<div class="store_title">
					<div class="time_table">
						<button type="button" id="bread_img_btn"><i class="fa-solid fa-bread-slice" style="color: #AA7B59;"></i>&nbsp;&nbsp;빵 타임테이블</button>	
					</div>
					<div class="store_name">${store.store_name}</div>
					<div class="store_eval">
						<div class="store_star_rating"><i class="fa-solid fa-star" style="color: #F6C002"></i>&nbsp;${store.store_avg_score_number==null?'0.0':store.store_avg_score_number}</div>
						<div class="store_heart_count">
							<c:if test="${member !=null}">
								<i class="fa-solid fa-heart" id="heart_on" onclick="go_heart_delete_function(${store.store_id})" ${!myheart?'style="display: none; color: #E87D7D;"':'style="color: #E87D7D; cursor:pointer;"'}></i>
								<i class="fa-regular fa-heart" id="heart_off" onclick="go_heart_insert_function(${store.store_id})" ${myheart?'style="display: none; color: #E87D7D;"':'style="color: #E87D7D;"'}></i>
							</c:if>
							<c:if test="${member == null}">
								<i class="fa-regular fa-heart" id="heart_off" onclick="go_heart_insert_function(${store.store_id})" ${myheart?'style="display: none; color: #E87D7D;"':'style="color: #E87D7D; cursor:pointer;"'}></i>
							</c:if>
							${heart_count}
						</div>
						<div class="store_review"><i class="fa-solid fa-message" style="color: darkblue;"></i>&nbsp;${review_count}</div>
					</div>
				</div>
				<div class="store_info">
					<div class="img_area">
						<img class="store_img" src="${store.store_img_path!=null?store.store_img_path:'https://drive.google.com/uc?id=1MqIAitI3YSCU6bR4YZ-wEBtTSzbuUZ0B'}" alt="가게대표이미지"></img>
					</div>
					<div class="info_area">
						<div class="info_detail">
							<div style="color: #70B4E4" class="store_order_type">${store.store_is_delivery==true?"배달":""} ${store.store_is_pickup==true?"픽업":""}</div>
							<div class="store_min_delivery_price">
								<div style="font-weight: 600;">최소 주문금액&nbsp;&nbsp;</div>
								<div style="color: #70B4E4">
									<fmt:formatNumber value="${store.store_min_delivery_price}" pattern="###,###,###"/>원
								</div>
							</div>
							<div class="store_avg_delivery_predict_time">
								<div style="font-weight: 600;">배달 시간&nbsp;&nbsp;</div>
								<div style="color: #70B4E4">${store.store_avg_delivery_predict_time}분 소요 예상</div>
							</div>
						</div>
						<div class="info_txt"><i class="fa-solid fa-quote-left"></i>&nbsp; ${store.store_introduce}&nbsp;<i class="fa-solid fa-quote-right"></i></div>
					</div>
				</div>
			</div>
		</div>
		<div class="bottom_area">
			<div class="menu_bar_area">
				<div class="menu_bar">
	                <ul style="padding-left: 0px;">
                        <li><a class="menu_link" href="javascript: get_menu_list_page()">메뉴</a></li>
                        <li><a class="menu_link" href="javascript: get_ingredients_info()">원산지 정보</a></li>
                        <li><a class="menu_link" href="javascript: get_store_reviews()">리뷰</a></li>
                        <li><a class="menu_link" href="javascript: get_store_notice()">공지 및 이벤트</a></li>
                        <li><a class="menu_link" href="javascript: get_store_address()">찾아오시는 길</a></li>
	                </ul>
        		</div>
			</div>
			<div class="store_content_area">
				<div id="store_content_here">여기</div>
			</div>
		</div>
	</div>
	
<!-- 모달창 -->
	<div id="bread_modalWrap" style="display: none;">
		<div id="bread_modalContent">
			<div id="bread_modalBody">
				<span id="bread_closeBtn">&times;</span>
				<div class="bread_modal_image">
					<%-- <img src="${cpath}/resources/images/025logo.png" alt="로고"> --%>
				</div>
				<div class="bread_content" id="bread_content">
				<div class="top_text_title"><<${store.store_name} BREAD TIME TABLE>></div>
					<div class="top_text">
						<div class="menu_table">
							<div class="menu_time menu_time_head">나오는 시간</div>
							<div class="menu_names menu_time_head">나오는 빵</div>
						<c:forEach items="${menu_names}" var="menuName">
							<div class="menu_time">${menuName.menu_time } 시</div>
							<div class="menu_names">${menuName.menu_names }</div>
						</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
<script>
$(function(){
	get_menu_list_page();
});

function get_menu_list_page(){
	$.ajax({
		url: "${cpath}/store/getMenuListPage.do?store_id=${store_id}",
		success:function(responseData){
			$("#store_content_here").html(responseData);
		},
		error:function(){
			console.log("ajax 오류");
		}
	});
}


function get_store_reviews(){
	$.ajax({
		url: "${cpath}/store/getStoreReviews.do",
		data: {"store_id":${store.store_id}},
		success: function(responseData){
			$("#store_content_here").html(responseData);
		},
		error:function(){
			console.log("ajax 오류");
		}
	});
};

function get_store_address(){
	$.ajax({
		url: "${cpath}/store/getStoreAddress.do",
		data: {"store_id":${store.store_id}},
		success: function(responseData){
			$("#store_content_here").html(responseData);
		},
		error:function(){
			console.log("ajax 오류");
		}
	});
}

function get_store_notice(){
	$.ajax({
		url: "${cpath}/store/getStoreNotice.do",
		data: {"store_id":${store.store_id}},
		success: function(responseData){
			$("#store_content_here").html(responseData);
		},
		error:function(){
			console.log("ajax 오류");
		}
	});
}

function get_ingredients_info(){
	$.ajax({
		url: "${cpath}/store/getIngredientsInfo.do",
		data: {"store_id":${store.store_id}},
		success: function(responseData){
			$("#store_content_here").html(responseData);
		},
		error:function(){
			console.log("ajax 오류");
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
        		//alert(res.result);
        		//document.getElementById('heart_on').style.display = 'block';
        		//document.getElementById('heart_off').style.display = 'none';
        		
        		location.reload();
        	}else{
        		alert('찜 기능은 로그인이 필요합니다.');
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
        		//alert(res.result);
        		//document.getElementById('heart_on').style.display = 'none';
        		//document.getElementById('heart_off').style.display = 'block';
        	
        		location.reload();
        	}else{
        		alert('찜 기능은 로그인이 필요합니다.');
        		 location.href='${cpath}/memberlogin.do';
        	}
        },
        error:function(){
            alert('ajex 실패');
        }
    });
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/breadtimetable.js" > </script>
</body>

</html>