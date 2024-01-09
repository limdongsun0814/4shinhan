<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>

<div class="store_list">
	<c:forEach items="${storeList}" var="store" varStatus="status">
		<div style="position: relative;">
			<a href="${cpath}/store/getStoreDetail.do/${store.store_id}" style="z-index: 5;">
				<div class="store" id="store${store.store_id}">
					<img class="store_img" src="${store.store_img_thumbnail_path!=null?store.store_img_thumbnail_path:'https://drive.google.com/uc?id=1MqIAitI3YSCU6bR4YZ-wEBtTSzbuUZ0B'}" alt="눈깜콩떡이"></img>
					<div class="store_info">
						<div class="store_name">${store.store_name}</div>
						<div class="store_status">
							<div class="store_star_rating"><i class="fa-solid fa-star" style="color: #F6C002"></i>&nbsp;${store.store_avg_score_number==null?'0.0':store.store_avg_score_number}</div>
							<div id="store_is_open">${store.store_is_open==true?"영업 중":"영업 종료" }</div>
						</div>
						<div class="store_location">
							<div class="store_distance">${Math.round((store.distance*1000)/10)*10}m |&nbsp;</div>
							<div class="store_address">${store.store_address}</div>
						</div>
						<div class="store_order_type">
							<c:if test="${store.store_is_pickup}">
								<div class="order_type_available">픽업</div>
							</c:if>
							<c:if test="${store.store_is_delivery}">
								<div class="order_type_available">배달</div>
							</c:if>
						</div>
					</div>
				</div>
			</a>
			<button type="button" class="store_heart" onclick="clickHeart()" style="z-index: 9;">
				<!-- <i class="fa-solid fa-heart" style="color: #E87D7D;"></i>  -->
				<%-- <c:if test="${member !=null}">
						<i class="fa-solid fa-heart" id="heart_on" onclick="go_heart_delete_function(${store.store_id})" ${!myheart?'style="display: none; color: #E87D7D;"':'style="color: #E87D7D;"'}></i>
						<i class="fa-regular fa-heart" id="heart_off" onclick="go_heart_insert_function(${store.store_id})" ${myheart?'style="display: none; color: #E87D7D;"':'style="color: #E87D7D;"'}></i>
				</c:if> --%>
			</button>
		</div>
	</c:forEach>
</div>

<script>

function clickHeart() {
	// 로그인X -> 로그인해주세요.
	// 로그인O -> 클릭이벤트
	console.log("클릭 하트");

}

</script>