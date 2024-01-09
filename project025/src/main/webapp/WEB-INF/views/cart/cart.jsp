<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<html>
<head>
<link href="${path}/resources/css/cart.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/orderpayPage01.css">
<link href="${path}/resources/css/cartSideBar.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/miniPayment.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<script src="https://kit.fontawesome.com/f719d238b7.js" crossorigin="anonymous"></script>
<title>CART | 빵이오</title>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>

<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<div class= "cart_all">
	<div class="containermiddle">
		<!-- <div class="middle_bar"> -->
		<div class="middele_box">
			<div class="text1">장바구니</div>
			<div class="text2">
				<a href="${path}/cart.do" style="color: black">01 장바구니 ></a><a style="color: #A6A6A6"> 02 주문/결제 ></a><a style="color: #A6A6A6"> 03 결제완료</a>
			</div>
			<div class="front">
				<img class="pay01" id="pay01" src="/app/resources/images/pay01.png"
					alt="pay01img">
			</div>
			<div class="back">
				<img class="pay02" id="pay02" src="/app/resources/images/pay02.png"
					alt="pay02img">
			</div>
		</div>
	</div>



	<div class="method">
		<div class="delivery">
			<input id="radio_dlivery" name="radio_dlivery" type="radio"
				onclick="delivery_radio_function(event)" value="delivery"
				name="delivery" checked="checked" /> <label for="delivery"
				class="method_delivery">배달</label> <input id="radio_dlivery"
				name="radio_dlivery" type="radio"
				onclick="delivery_radio_function(event)" value="pick_up"
				name="delivery" /> <label for="pick_up" class="method_pick_up">픽업</label>
			<div class="address">
				<b class="town">동네</b><br> <div id="address_new"></div><%-- ${member.member_address} --%>
			</div>
		</div>
	</div>


	<div class="cart">
		<c:forEach items='${cart_list}' var="cart" varStatus="cart_status">
			<div style="margin-bottom: 30px;"
				id='${cart.key}_${cart.value[0].store_is_pickup && cart.value[0].store_is_delivery?"cart_dispaly_all":cart.value[0].store_is_pickup?"cart_dispaly_pickup":"cart_dispaly_delivery"}'
				class='${cart.value[0].store_is_pickup && cart.value[0].store_is_delivery?"cart_dispaly_all": cart.value[0].store_is_pickup?"cart_dispaly_pickup":"cart_dispaly_delivery"}'>
				<%-- <div class='${cart.value[0].store_name}'> --%>
				<div class="cart_title">
					<div class="cart-titleInfo-div">
						<input type="radio" name="titla_radio" id="${cart.key}_checkbox" onclick="checkbox_all_function(event)">
							<input type="hidden" id="${cart.key}_store_id" value="${cart.value[0].store_id}">
							<input type="hidden" id="${cart.key}_store_ip_path" value="${cart.value[0].store_ip_path}">
						<div class="cart_title_font">${cart.key}</div>
					</div>

					<div class="cart_close_font">
						<form
							action="${pageContext.request.contextPath}/deleteCartStore.do"
							method="post">
							<input type="hidden" name="store_name" value="${cart.key}">
							<button class="close-btn" type="submit" style="font-size: 20px; background-color: transparent; cursor: pointer; border: none;">
							    <i class="fa-solid fa-x"></i>
							</button>
						</form>
					</div>
				</div>
				<c:forEach items='${cart.value}' var="menu">
					<div class="cart_content">
						<div class="cart-content-ifo">
							<input type="checkbox" class="menu_select"
								onclick="checkbox_function(event)"
								${menu.menu_count==0?"disabled":""}
								id="${cart.key}_${menu.menu_name}_check"> <img
								src="${menu.menu_image_path!=null?menu.menu_image_path:'resources/images/not_menu_img.png'}" class="img"
								width="137px" height="144" />
							<div class="menu_name">
								<input type="text" value="${menu.menu_name}" class="${cart.key}"
									readonly="readonly">
							</div>
						</div>
						<div class="option">

							<div class="price_content" id="price_content_title1">
								<div class="price-result">
									<input value="${menu.menu_price}"
										id="${cart.key}_${menu.menu_name}_price" readonly="readonly"><p class="price-result_p">원</p>
								</div>
							</div>
							<div class="price_content1">
								<input value="${menu.menu_discount_price}"
									id="${cart.key}_${menu.menu_name}_discount_price" type="hidden">
							</div>

							<div class="price_content2">
								<div class="price_content2_2">
									<div class="product_count">
										<button type="button" aria-label="수량내리기" style="z-index: 20;" class="count_down" id="${cart.key}_${menu.menu_name}_count_down" onclick="count_down(event)"><i class="fa-solid fa-minus" id="${cart.key}_${menu.menu_name}_count_down_i"></i></button>
										<div class="count_num" id="count_num">
											<input class="price2"
											value="${menu.cart_product_count>menu.menu_count?menu.menu_count:menu.cart_product_count}"
											id="${cart.key}_${menu.menu_name}_cnt" min="0"
											max="${menu.menu_count}">
										</div>
										<button type="button" aria-label="수량올리기" class="count_up" id="${cart.key}_${menu.menu_name}_count_up" onclick="count_up(event)"><i class="fa-solid fa-plus" id="${cart.key}_${menu.menu_name}_count_up_i"></i></button>
									</div>
								</div>
							</div>
						</div>
							
							<div class="stock" id="stock">남은재고</div>
							<input class="stock-count" value="${menu.menu_count }개">
							<form action="${pageContext.request.contextPath}/deleteCart.do"
							method="post">
							<div class="close_font">
								<input type="hidden" value="${cart.key}" name="store_name">
								<input type="hidden" value="${menu.menu_name}" name="menu_name">
								<button class="one_by_one_delete" type="submit" style="font-size: 20px; background-color: transparent; cursor: pointer; border: none;">
								    <i class="fa-solid fa-x"></i>
								</button>
							</div>
							</form>
						</div>
				</c:forEach>
			<!-- </div> -->
			
				<div class="cart_price_content">
					<div class="total_price">
						<div class="cart_proce_font">상품금액</div>
						<div class="price_content">
							<input type="number" id="${cart.key}_total_price"
								readonly="readonly" value="${total_cart[cart.key].total_price }">원
						</div>
					</div>
					<div class="total_price">
						<div class="cart_proce_Operator">-</div>
					</div>
					<div class="total_price">
						<div class="cart_proce_font">할인금액</div>
						<div class="price_content_color_red">
							<input type="number" id="${cart.key}_total_discount_price"
								readonly="readonly"
								value="${total_cart[cart.key].total_discount_price}"
								style="color: red;"><p style="color: red;">원</p>
						</div>
					</div>
					<!-- 		<div class="_fee"> -->
					<div class="total_price_fee">
						<div class="cart_proce_Operator">+</div>
					</div>

					<div class="total_price_fee" style="margin: 10px;">
						<div class="cart_proce_font_fee">배송비</div>
						<div class="price_content">
							<input type="number" class="solo" id="${cart.key}_delivery_fee"
								readonly="readonly"
								value="${total_cart[cart.key].store_delivery_fee }">원

						</div>
					</div>
					<!-- 	</div> -->
					<div class="total_price">
						<div class="cart_proce_Operator">=</div>
					</div>
					<div class="total_price">
						<div class="cart_proce_font">주문금액</div>
						<div class="price_content">
							<input type="number" id="${cart.key}_total" readonly="readonly"
								value="${total_cart[cart.key].total }">원
						</div>
					</div>
				</div>
			</div><!-- 
			<br> -->
		
		</c:forEach>	
	</div>
</div>




	<%-- 
		<div class="miniPayment">
		<div class="miniPaymentContent">
			<div class="miniPaymentContentTitle">결제 정보</div>

			<hr>
			<div class="miniPaymentTotalContent">
				<div class="miniPaymentTotal">
					<div class="mini-title">
						총 주문 상품 수 <input type="number" id="payment_total_cnt"
							readonly="readonly" value="0" />
					</div>

					<input class="no-border" type="number" readonly="readonly"
						dir="rtl" value="${total_cnt}">
					<p>개</p>

				</div>
				<div class="cnt" id="cnt">
					<c:forEach items="${menu_cnt}" var="cnt">
						<div class="cnt_set">
							<div class="key_menu" id="${cnt.key}">
								<li></li>${cnt.key}</div>
							<div>
								<input class="result-count" dir="rtl" type="text"
									id="${cnt.key}_cnt" value="${cnt.value}">
								<p>개</p>
							</div>
						</div>
					</c:forEach>
				</div>
				<c:forEach items="${menu_price}" var="price">
					<input class="no-border2" type="hidden" id="${price.key}_price"
						dir="rtl" value="${price.value }">
				</c:forEach>
				<div class="miniPaymentTotal">
					<div class="mini-title">총 상품 금액</div>
					<input class="no-border3" type="number" id="payment_total_price"
						readonly="readonly" value="0">
					<p>원</p>
				</div>
				<div class="miniPaymentTotal">
					<div class="mini-title">
						총 할인 금액 <img src="${path}/resources/images/check_button.png"
							width="15px" id="total_dis_price" />
					</div>
					<input class="no-border4" input type="number"
						id="payment_total_dis_price" readonly="readonly" value="0">
					<p>원</p>
				</div>
				<div class="disprice" id="disprice">
					<c:forEach items="${menu_disprice}" var="disprice">
						<div class="disprice_set">
							<div class="key-repeat">
								<li></li>${disprice.key}</div>
							<div>
								<input class="result-app" type="text" dir="rtl"
									id="${disprice.key}_disprice" value="${disprice.value}">
								<p>개</p>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="miniPaymentTotal"
					${get_id.equals("pick_up")?"style='display: none;'":""}>
					<div class="mini-title">총 배송비</div>
					<input class="no-border5" input type="number"
						id="payment_total_fee" readonly="readonly" value="0">
					<p>원</p>
				</div>
			</div>
			<hr>
			<div class="miniPaymentTotalPrice">
				<div class="mini-title">총 결제금액</div>
				<input class="no-border-result" type="number" id="payment_total" readonly="readonly"
				value="0">
				<p>원</p>
			</div>
		</div>
		<input class="cal" type="button" id="payment_button"
			onclick="submit_function()" value="주문하기">
	</div> 
 --%>
	<div class="miniPayment" id="minicart" >
		<div class="miniPaymentContent">
			<div class="miniPaymentContentTitle">주문 상품</div>
			<hr>
			<div class="miniPaymentTotalContent">
				<div class="miniPaymentTotal">
					<div class="mini-title">총 주문 상품 수</div>
					<input class="no-border" type="number" id="payment_total_cnt"
						readonly="readonly" value="0">
					<p>개</p>
				</div>



				<div class="miniPaymentTotal">
					<div class="mini-title">총 상품 금액</div>
					<input class="no-border3" type="number" id="payment_total_price"
						readonly="readonly" value="0">
					<p class="won2">원</p>
				</div>

				<div class="miniPaymentTotal">
					<div class="mini-title">총 할인 금액</div>
					<input class="no-border4" type="number"
						id="payment_total_dis_price" readonly="readonly" value="0">
					<p>원</p>
				</div>

				<div class="miniPaymentTotal"
					${get_id.equals("pick_up")?"style='display: none;'":""}>
					<div class="mini-title" id="payment_fee">총 배송비</div>
					<input type="number" id="payment_total_fee" readonly="readonly"
						value="0">
					<p class="won">원</p>
					<%-- 			<input class="no-border5" type="number" readonly="readonly"
						dir="rtl" value="${total_fee}" id="total_fee">
					<p>원</p> --%>
				</div>

			</div>
			<hr>
			<div class="miniPaymentTotalPrice">
				<div class="mini-title">총 결제금액</div>
				<input class="no-border-result" type="number" id="payment_total"
					readonly="readonly" value="0">
				<p>원</p>
			</div>

		</div>
		<input class="cal" type="button" value="주문하기" id="payment_button">
	</div>


	<!-- <script>
		let isPress = false, prevPosX = 0, prevPosY = 0,

		cont
		$target = document.querySelector(".miniPayment");

		$target.onmousedown = start;
		$target.onmouseup = end;

		window.onmousemove = move;

		function start(e) {
			prevPosX = e.clientX;
			prevPosY = e.clientY;

			isPress = true;
		}

		function move(e) {
			if (!isPress) {
				return;
			}

			// 이전 좌표와 현재 좌표 차이값
			const posX = prevPosX - e.clientX;
			const posY = prevPosY - e.clientY;

			// 현재 좌표가 이전 좌표로 바뀜
			prevPosX = e.clientX;
			prevPosY = e.clientY;

			// left, top으로 이동
			$target.style.left = ($target.offsetLeft - posX) + "px";
			$target.style.top = ($target.offsetTop - posY) + "px";
		}

		function end() {
			isPress = false;
		}
	</script> -->
	
	
<script type="text/javascript">
var address_new=sessionStorage.getItem("my_addr");
document.getElementById('address_new').innerHTML=address_new;
$(document).ready(function () {
    const minusBtn = document.getElementById('count_down');
    const plusBtn = document.getElementById('count_up');
    const resultCount = document.getElementById('${cart.key}_${menu.menu_name}_cnt');

    const updatePrice = function (count) {
        const price = count * (${menu.menu_price==null?0:menu.menu_price} - ${menu.menu_discount_price==null?0:menu.menu_discount_price});
        const formattedPrice = price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        document.getElementById('pay_price').innerHTML = '<div>' + formattedPrice + '&nbsp;원</div>';
    };

    console.log(resultCount.value == 0);

    if (resultCount.value == 0) {
        minusBtn.disabled = true;
        plusBtn.disabled = true;
    }

    $(".count_down").click(function (e) {
        e.preventDefault();
        var count_num = parseInt(resultCount.value);
        var update_num = count_num - 1;

        if (update_num <= 1) {
            minusBtn.disabled = true;
        }

        resultCount.value = update_num;
        document.getElementById('cnt').value = update_num;
        updatePrice(update_num);
    });

    $(".count_up").click(function (e) {
        e.preventDefault();
        var count_num = parseInt(resultCount.value);
        var update_num = count_num + 1;

        minusBtn.disabled = false;

        resultCount.value = update_num;
        document.getElementById('cnt').value = update_num;
        updatePrice(update_num);
    });
});
</script>
</body>
<%@include file="/resources/jsp/cart_js.jsp"%>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</html>
