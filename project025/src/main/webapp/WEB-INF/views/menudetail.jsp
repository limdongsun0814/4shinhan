<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/menudetail.css">
<script src="https://kit.fontawesome.com/f719d238b7.js" crossorigin="anonymous"></script>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MENU | 빵이오</title>
<!-- 헤더 -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>
</head>
<body>
	<div class="body_container">
		<div class="top_area">
			<div class="menu_title_area">
				<div class="menu_name">${menu.menu_name}</div>
			</div>
			<div class="menu_info_area">
				<div class="menu_info_left">
					<div class="menu_img_area">
						<img class="menu_item_img" src="${menu.menu_image_path!=null?menu.menu_image_path:'https://drive.google.com/uc?id=14Top-Dg-8l4S0J3PyvXsawOYHfMhACw4'}" alt="메뉴 사진"></img>
					</div>
					<div class="menu_description"><i class="fa-solid fa-pen-nib"></i> ${menu.menu_describe}</div>
				</div>
				<div class="menu_info_right">
					<div style="text-align: center;">상품 정보</div>
					<hr style="margin-top: 20px; width: 430; border border-width: 0.5px 0 0 0; border-color: lightgray; border-style: dashed; border-top-width: 0px;"></hr>
					<div class="menu_info_detail">
						<div class="price_info">
							<div class="discount_info">
								<div class="discount_percent">
									<fmt:formatNumber value="${(menu.menu_discount_price div menu.menu_price)*100}" pattern="##"/>%
								</div>
								<div class="first_cost">
									<fmt:formatNumber pattern="###,###,###" value="${menu.menu_price}"/>&nbsp;원
								</div>
							</div>
							<div class="realtime_price_info">
								<fmt:formatNumber pattern="###,###,###" value="${menu.menu_price-menu.menu_discount_price}"/>&nbsp;원
							</div>
						</div>
						<hr style="margin-top: 20px; width: 430; border border-width: 0.5px 0 0 0; border-color: lightgray; border-style: dashed; border-top-width: 0px;"></hr>
						<div class="stock_info">
							<div>현재 재고 개수</div><%-- ${menu.menu_id} --%>
							<div class="info_value">${menu.menu_count}개</div>
						</div>
						<hr style="margin-top: 20px; width: 430; border border-width: 0.5px 0 0 0; border-color: lightgray; border-style: dashed; border-top-width: 0px;"></hr>
						<div class="ingredients_info">
							<div>원산지</div>
							<div class="info_value">가게 정보 참조</div>
						</div>
						<hr style="margin-top: 20px; width: 430; border border-width: 0.5px 0 0 0; border-color: lightgray; border-style: dashed; border-top-width: 0px;"></hr>
						<div class="pay_info">
							<div class="product_count">
								<button type="button" aria-label="수량내리기" disabled="" class="count_down" id="count_down"><i class="fa-solid fa-minus"></i></button>
								<div class="count_num" id="count_num">1</div>
								<button type="button" aria-label="수량올리기" class="count_up" id="count_up"><i class="fa-solid fa-plus"></i></button>
							</div>
							<div class="pay_price_info">
								<div>총 상품금액: </div>
								<div class="pay_price" id="pay_price">
									<fmt:formatNumber pattern="###,###,###" value="${menu.menu_price-menu.menu_discount_price}"/>&nbsp;원
								</div>
							</div>
						</div>
					</div>
					<div class="menu_button_area">
						<!-- <button type="button" class="add_to_heart"><i class="fa-regular fa-heart"></i></button> -->
						<form action="${cpath}/CartInsert.do" method="post" >
							<!-- <button type="button" class="add_to_cart">장바구니 담기</button> -->
							<input type="submit" class="add_to_cart" value="장바구니 담기">
							<input type="hidden" id="cnt" name="cart_product_count" value="1">
							<input type="hidden" name="cart_product_menu_id" value="${menu.menu_id}">
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="bottom_area">
			<div class="recommend_title" style="font-size: 30px; margin-bottom: 50px; margin-top: 50px; display: flex;">❄·. you may also like .·❄</div>
			<div class="random_list_area">
				<c:forEach items="${randomMenuList}" var="rm" varStatus="status">
					<a href="${cpath}/store/getMenuDetail.do?menu_id=${rm.menu_id}" style="width: 250px; height: 300px;">
						<div class="random_menu">
							<img class="random_menu_img" src="${rm.menu_thumb_image_path!=null?rm.menu_thumb_image_path:'https://drive.google.com/uc?id=14Top-Dg-8l4S0J3PyvXsawOYHfMhACw4'}" alt="랜덤메뉴사진"></img>
							<div class="top_info">
								<button class="menu_store_name">${rm.store_name}</button>
								<!-- <button type="button" class="menu_heart" onclick="clickHeart()">
									<i class="fa-solid fa-heart" style="color: #E87D7D;"></i>
								</button> -->
							</div>
							<div class="bottom_info">
								<div class="bottom_info_left">
									<div class="random_menu_name" style="
										<c:if test='${fn:length(rm.menu_name) gt 9}'>font-size: 16px;</c:if>
									">${rm.menu_name}</div>
									<div class="random_menu_price" style="margin-top: 3px;">
										<fmt:formatNumber pattern="###,###,###" value="${rm.menu_price}"/>&nbsp;원
									</div>
								</div>
							</div>
							<button type="button" class="random_cart" onclick="addToCart()">장바구니</button>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(function(){
	const minusBtn=document.getElementById('count_down');
    const plusBtn=document.getElementById('count_up');
	console.log(${menu.menu_count}==0);
    if (${menu.menu_count}==0){
    	minusBtn.disabled = true;
    	plusBtn.disabled = true;
    }
});

$(".count_down").click(function (e) {
    e.preventDefault();
    
    const minusBtn=document.getElementById('count_down');
    const resultCount=document.getElementById('count_num');
    var count_num=resultCount.innerText;
    var update_num=parseInt(count_num)-1;

    if (update_num<=1) {
    	minusBtn.disabled = true;
    }
    
    resultCount.innerText=update_num;
    document.getElementById('cnt').value=update_num;
    document.getElementById('pay_price').innerHTML='<div>'+(update_num*${menu.menu_price-menu.menu_discount_price}).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'&nbsp;원</div>';
});

$(".count_up").click(function (e) {
    e.preventDefault();
    
    const minusBtn=document.getElementById('count_down');
    const resultCount=document.getElementById('count_num');
    var count_num=resultCount.innerText;
    var update_num=parseInt(count_num)+1;
    
    minusBtn.disabled = false;
    
    resultCount.innerText=update_num;
    document.getElementById('cnt').value=update_num;
    document.getElementById('pay_price').innerHTML='<div>'+(update_num*${menu.menu_price-menu.menu_discount_price}).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'&nbsp;원</div>';
});
</script>
	
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</html>