<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/mypage/miniPayment02.css">
<div class="miniPayment">
	<div class="miniPaymentContent">
		<div class="miniPaymentContentTitle">주문상품</div>

		<hr>
		<div class="miniPaymentTotalContent">
			<div class="miniPaymentTotal">
				<div class="mini-title">
					총 주문 상품 수 <img src="${path}/resources/images/check_button.png"
						height="15px" id="total_cnt" />
				</div>

				<input class="no-border" type="number" readonly="readonly" dir="rtl"
					value="${total_cnt}">
				<p>개</p>

			</div>
			<div class="cnt" id="cnt">
				<c:forEach items="${menu_cnt}" var="cnt">
					<div class="cnt_set">
						<div class="key_menu" id="${cnt.key}">
							<li></li>${cnt.key}</div>
							<input class="result-count" dir="rtl" type="text"
								id="${cnt.key}_cnt" value="${cnt.value}">
							<p>개</p>
					</div>
				</c:forEach>
			</div>
			<c:forEach items="${menu_price}" var="price">
				<input class="no-border2" type="hidden" id="${price.key}_price"
					dir="rtl" value="${price.value }">
			</c:forEach>
			<div class="miniPaymentTotal">
				<div class="mini-title">총 상품 금액</div>
				<input class="no-border3" type="number" readonly="readonly"
					dir="rtl" value="${total_price}">
				<p class="won3">원</p>
			</div>
			<div class="miniPaymentTotal">
				<div class="mini-title">
					총 할인 금액 <img src="${path}/resources/images/check_button.png"
						height="15px" id="total_dis_price" />
				</div>
				<input class="no-border4" type="number" readonly="readonly"
					dir="rtl" value="${total_dis_price}">
				<p style="color: red;">원</p>
			</div>
			<div class="disprice" id="disprice">
				<c:forEach items="${menu_disprice}" var="disprice">
					<div class="disprice_set">
						<div class="key-repeat">
							<li></li>${disprice.key}</div>
							<input class="result-app" type="text" dir="rtl"
								id="${disprice.key}_disprice" value="${disprice.value}">
							<p>원</p>
					</div>
				</c:forEach>
			</div>
			<div class="miniPaymentTotal"
				${get_id.equals("pick_up")?"style='display: none;'":""}>
				<div class="mini-title">총 배송비</div>
				<input class="no-border5" type="number" readonly="readonly"
					dir="rtl" value="${total_fee}" id="total_fee">
				<p>원</p>
			</div>
		</div>
		<hr>
		<div class="miniPaymentTotalPrice">
			<div class="mini-title">총 결제금액</div>
			<input class="no-border-result" type="number" dir="rtl" id="payment_total_mini"
				readonly="readonly" value="${total}">
			<p>원</p>
		</div>
	</div>
	<input class="cal" type="button" id="submit"
		onclick="submit_function()" value="결제하기">
</div>
<script>
	document.getElementById('total_cnt').addEventListener('click',
			total_cnt_function);
	document.getElementById('total_dis_price').addEventListener('click',
			total_dis_price_function);
	var toggle_cnt = true;
	var toggle_dis_price = true;
	function total_cnt_function() {
		toggle_cnt = !toggle_cnt;
		if (!toggle_cnt) { //flex
			document.getElementById('cnt').style.display = "flex";
		} else {
			document.getElementById('cnt').style.display = "none";
		}
	}
	function total_dis_price_function() {
		toggle_dis_price = !toggle_dis_price;
		if (!toggle_dis_price) { //flex
			document.getElementById('disprice').style.display = "flex";
		} else {
			document.getElementById('disprice').style.display = "none";
		}
	}
</script>