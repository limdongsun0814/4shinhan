<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/mypage/miniCart.css">
<c:if test="${fn:length(cart_list) !=0}">
<div class="miniCart">
	<div class="mainCart">
		<div class="miniCartMove">
			<div class="miniCartPrev"  style="cursor: pointer;">〈</div>
			<div class="miniCartTitleDispaly">대충 이름</div>
			<div class="miniCartNext"  style="cursor: pointer;">〉</div>
		</div>
		<c:forEach items='${cart_list}' var="cart">
			<form class="miniCartTitle" id="${cart.key}" action="${pageContext.request.contextPath}/cart.do">
				<div class="cart_content" <%--  class="miniCartTitle" id="${cart.key}" --%>>
					<%-- ${cart.key} --%>
					<c:forEach items='${cart.value}' var="menu">
						<div class="miniCartContent">
							<div class="miniCart12">
								<div class="miniCartOne">
									<img class="miniCartImg" alt="없음"
										src="${menu.menu_image_path!=null?menu.menu_image_path:'resources/images/not_menu_img.png'}" />
									<div class="miniCart_left">
										<div class="miniCartName">${menu.menu_name}</div>
										<div class="miniCartPrice">${menu.menu_price}원</div>
									</div>
									<div class="miniCartCnt">
										<input class="cntInput" type="text" readonly="readonly" value="${menu.cart_product_count}개">
									</div>
								</div>
									
							</div>
						</div>
					</c:forEach>
					<input type="submit" class="add_to_cart" style="cursor: pointer;" value="장바구니">
				</div>
			</form>
		</c:forEach>
	</div>
  </div>
	<script type="text/javascript" src="${path}/resources/js/cart.js"></script>
 </c:if>
