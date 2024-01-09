<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/mypage/myorderlist.css">


<div class="order_area">
	<p>주문 내역 조회</p>
	<div class="select">
		<!-- 주문내역 선택 조회(주문 타입) -->
		<div class="order_list_select">
		
		
			<!-- 주문 타입 필터링(전체/픽업만/배달만) -->
			<div class="orderType_area">
				주문 유형
				<!-- 전체 -->
				<label class="Type" id="all">
					<div class="orderType" id="all2"> 
						<input type="radio" name="value1" />
						<div class="orderType_title">전체</div>
					</div>
				</label>
				<!-- 픽업 -->
				<label class="Type" id="pickup_only"> <input type="radio"
					name="value1" />
					<div class="orderType" id="pickup_only2">
						<div class="orderType_title">픽업</div>
					</div>
				</label>
				<!-- 배달 -->
				<label class="Type" id="delivery_only"> <input type="radio"
					name="value1" />
					<div class="orderType" id="delivery_only2">
						<div class="orderType_title">배달</div>
					</div>
				</label>
			</div>
		
		
			
		
			<!-- 주문내역 선택 조회(주문 날짜) -->	
			<div class="date">
				조회 기간
				<!-- 1주 -->
					<label class="SType" id="1week">
						<div class="sortType" id="1">
							<input type="radio" name="value2" />
							<div class="sortType_title">1주</div>
						</div>
					</label>
					<!-- 1개월 -->
					<label class="SType" id="1month"> <input type="radio"
						name="value2" value="2" />
						<div class="sortType" id="2">
							<div class="sortType_title">1개월</div>
						</div>
					</label>
					<!-- 3개월 -->
					<label class="SType" id="3months"> <input type="radio"
						name="value2" value="3" />
						<div class="sortType" id="3">
							<div class="sortType_title">3개월</div>
						</div>
					</label>
			</div>
		</div>
		
		<button type="button" class="order_search_button" onclick="search();"> 조회</button>
		
	</div>
	<!-- 주문 리스트 출력 -->
	<div class="order_list_area">
		<div id="here1234"></div>
	</div>
</div>



<script>
	
	$(".Type").click(function (e) {
	    e.preventDefault();
	    var id = $(this).attr("id");
	    console.log(id);
	
	    $(".Type .orderType").removeClass("on");
	
	    $("#" + id + " .orderType").addClass("on");
	    
	});
	
	
	$(".SType").click(function (e) {
	    e.preventDefault();
	    var id = $(this).attr("id");
	    console.log(id);
	
	    $(".SType .sortType").removeClass("on");
	
	    $("#" + id + " .sortType").addClass("on");
	   
	    
	});
	
	
	function search() {
		const order = $('.orderType.on').attr('id');
		const date = $('.sortType.on').attr('id');
		
	    var url;
	    if (order=="all2"){
	    	url="${cpath}/mypage//getAllOrderList.do?period="+date;
	    } else if(order=="pickup_only2"){
	    	url="${cpath}/mypage/getPickUpOrder.do?period="+date;
	    } else if(order=="delivery_only2"){
	    	url="${cpath}/mypage/getDeliveryOrder.do?period="+date;
	    }
	    
	    $.ajax({
			url: url,
			success:function(responseData){
				$("#here1234").html(responseData);
			},
			error:function(){
				console.log("ajax 오류");
			}
		});
	}







/*

function get_all_order(){
	$.ajax({
		url: "${cpath}/mypage/getAllOrderList.do",
		success:function(responseData){
			$("#here1234").html(responseData);
		},
		error:function(){
			console.log("ajax 오류");
		}
	});
}
*/


</script>
