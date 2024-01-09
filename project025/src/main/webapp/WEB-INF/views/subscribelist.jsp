<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage | 빵이오</title>
<!-- 헤더 -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css">
</head>

<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<div class="sorting_dropdown">
		<select class="dropdown" id="sorting_dropdown" onchange="get_menu_list()">
			<option value="latest" selected>평점 높은 순</option>
			<option value="popular">리뷰 많은 순</option>
			<option value="priceasc">주문 많은 순</option>
			<option value="pricedesc">거리 가까운 순</option>
		</select>
	</div>
	
	<div class="subscribe_store">
		<c:forEach items="${ subscribeList}" var="sub">
			<div>가게 이미지</div>
			<div>${sub['store_name']}</div>
			<div>평균 별점: ${sub['store_avg_score_number']}</div>
			<div>찜 개수 : ${sub['heart_count']}</div>
			<div>리뷰 개수 : ${sub['member_review_count']}</div>
			<div>구독 가능 프로그램 수 : ${sub['subscribe_count']}</div>
		</c:forEach>
	</div>
<script>
$(function(){
	get_menu_list();

	$('.field').on('focus', function() {
		$('body').addClass('is-focus');
	});
	
	$('.field').on('blur', function() {
		$('body'). ('is-focus is-type');
	});
	
	$('.field').on('keydown', function(event) {
		$('body').addClass('is-type');
		if((event.which === 8) && $(this).val() === '') {
			$('body').removeClass('is-type');
		}
	});
});

function get_menu_list(){
	let categoryDropdown = document.getElementById('category_dropdown');
	let cateSelectedIndex=categoryDropdown.selectedIndex;
	let cateSelectedValue=categoryDropdown.options[cateSelectedIndex].value;
	
	let sortingDropdown = document.getElementById('sorting_dropdown');
	let sortSelectedIndex=sortingDropdown.selectedIndex;
	let sortSelectedValue=sortingDropdown.options[sortSelectedIndex].value;
	
	console.log(cateSelectedIndex);
	console.log(cateSelectedValue);
	
	$.ajax({
		url: "${cpath}/store/getMenuList.do?page=1&per_page_num=9&store_id=${store_id}&category="+cateSelectedValue+"&sort="+sortSelectedValue,
		success:function(responseData){
			$("#menu_list").html(responseData);
		},
		error:function(){
			console.log("ajax 오류-menu.jsp");
		}
	});
}
</script>



</body>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</html>