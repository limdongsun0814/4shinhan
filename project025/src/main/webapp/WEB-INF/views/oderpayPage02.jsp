<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/orderpayPage02.css">
<link href="${path}/resources/css/cart02.css" type="text/css"
	rel="stylesheet" />
<%-- <link href="${path}/resources/css/modal.css" type="text/css"
	rel="stylesheet" /> --%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c9ae8a414e60beaf76f05c1954ec86eb&libraries=services,clusterer,drawing"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- portOne SDK 가져오기 -->
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- naverPay SDK 가져오기 -->
	<script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script>
<title>ORDER&PAY | 빵이오</title>

</head>


<body>

	<%@ include file="/WEB-INF/views/payment/miniPayment2.jsp"%>
	<div class="include_middle">
		<%-- <%@ include file="/WEB-INF/views/common/paymiddlebar.jsp"%> --%>
	</div>
	<br>
<div class= "cart_all">
	<div class="containermiddle">
		<!-- <div class="middle_bar"> -->
		<div class="middele_box">
			<div class="text1">주문 결제</div>
			<div class="text2">
				<a href="${path}/cart.do">01 장바구니 ></a>
				<a href="${path}/paymentInsert.do" style="color: black;"> 02 주문/결제 ></a><a> 03 결제완료</a>
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
				value="delivery" name="delivery"
				${get_id.equals("delivery")?"checked='checked'":""}
				onclick="return false;" /> <label for="delivery"
				class="method_delivery">배달</label> <input id="radio_dlivery"
				name="radio_dlivery" type="radio" value="pick_up" name="delivery"
				${!get_id.equals("delivery")?"checked='checked'":""}
				onclick="return false;" /> <label for="pick_up"
				class="method_pick_up">픽업</label>
		</div>
		<div class="address">
			<b>동네</b><br> <div id="address_new"></div>
		</div>
	</div>


	<div class="deliveryInfo">
		<br> <br> <br>
		<form class="form-grup-delivery" id="deliveryform">
			<div class="form-grup-1" id="delivery_div">
				<div class="select1">
					<div class="ptage">
						<p>
						<li></li>배달 정보를 입력해주세요.
						</p>
					</div>
					<div class="select1_info" style="display: flex;">
						<label>배송지선택 </label>
						<select id="select_options" onchange="getselect(event)">
							<option style="font-size: 20px;">배송지를 선택해주세요.</option>
							<c:forEach var="alist" items="${member_address_list}">
								<option name="select_address"
									value="${alist.member_address_name}">${alist.member_address_name}</option>
							</c:forEach>
						</select>
						<input type="button" id="add_address_btn"
							name="add_address_btn"  value="주소 추가">
					</div>
					<!--  위도 경도 정보  -->
					<input id="address_latitude" name="address_latitude"
						value="${alist.member_address_latitude }" style="display: none;" />
					<input id="address_longitude" name="address_longitude"
						value="${alist.member_address_longitude}" style="display: none;" />
					<div class="select1_info">
						<div>
							<lable>전화 번호</lable>
							<div class="phonefull">
								<small id="phone1"></small> - <small id="phone2"></small> - <small
									id="phone3"></small>
							</div>
						</div>
						<input type="tel" id="phone" name="phone"
							placeholder="예: 010-123-4567" readonly style="display: none;"
							value="${ login_member_phone}">
					</div>
					<div class="select1_info">
						<div class="nameSamll">
							<label>이름</label> <small>${member.member_name}</small>
						</div>
						<input type="text" id="name" name="name"
							value="${login_member_id}" style="display: none;" readonly>
					</div>
					<div class="select1_info">
						<label >주소</label> 


						<div class="alterInfo">
							<c:forEach items="${member_address_map}" var="member_address">
								<div id="${member_address.key}" style="display: none;"
									class="key">

									<input type="text" id="address1" name="addresspay"
										value="${member_address.value.member_address }" readonly><br>
									<input type="text" id="address2" name="addresspay"
										value="${member_address.value.member_address_detail }"
										readonly>
								</div>
							</c:forEach>
						</div>


					</div>
				</div>
			<!--  -->
			</div>
			<div class="form-grup-2"></div>
			<div class="select2">
				<div class="ptage">
					<p>
					<li></li>요청 사항을 입력해 주세요
					</p>
				</div>
				<textarea id="request_del" name="request"></textarea>
				<!-- <input type="text" id="request_del" name="request" value=""> -->
			</div>
			<div class="form-grup-3"></div>
			<div class="select3">
				<div class="ptage">
					<p>
					<li></li>할인 혜택을 받아보세요
					</p>
				</div>
				
				

				<div class="select1_info">
					<!-- <label> 쿠 폰 </label> <select>
						<option>1.할인 쿠폰</option>
						<option>2.할인 쿠폰</option>
						<optinon>3.할인 쿠폰</optinon>
					</select> <br> -->
					<!-- <lable> 포인트 / 마일리지 </lable> -->
					<div>
						<lable> 마일리지</lable>
						
					</div>
					<div class="point_Mileage">
						<!-- <div class="point-block">
							<input type="text" id="point" name="point"> <small>원
								/659P</small>
								<input type="text" id="readpoint" name="readpoint" value="가지고있는 포인트 값" readonly>
							<input type="button" id="usepoint" name="usepoint" value="전액사용">
						</div> -->
						<div class="mileage-block">
							<input type="number" id="mileage" onchange="mileage_function(event)" name="mileage" value="0" max="${member.member_mileage}"> <small>원
								/${member.member_mileage}M</small>
							<!-- <input type="text" id="readmileage" name="readmileage"
							value="가지고있는 마일리지 값" readonly>  -->
							<!-- <input type="button" id="usemileage" name="usemileage"
								value="마전액사용"> -->
						</div>
						
					</div>
					<div class="mileage_describe" style="margin-top: 15px;color: #A6A6A6;">
							마일리지는 총 결제금액의 50%까지만 사용 가능합니다!
						</div>
				</div>
			</div>

			<div class="form-grup-4"></div>
			<div class="select4">
				<div class="ptage">
					<p>
					<li></li>결제 수단을 선택 해주세요
					</p>
				</div>
				<br>
				<div class="payTpye">
					<c:forEach var="paymentTpye" items="${payment_type_use}">
						<input type='radio' name='paymethod2'
							onclick="payment_type_function(event)"
							value="${paymentTpye.payment_type_seq}" ${paymentTpye.payment_type_seq==3?'checked':'' } />${paymentTpye.payment_type}</c:forEach>
				</div>
			</div>
		</form>
		<!-- --------------------------------------------배달 픽업 form 구분  ------------------------------------ -->
		<form class="form-grup-pickup" id="pickup-form">
			<div class="form-grup-1" id="pickup_div">
				<div class="ptage">
					<p>
					<li></li>주문자 정보를 확인 해주세요
					</p>
				</div>
				<div class="pickup-container">
					<div class="phone-pickup">
						<lable>전화 번호</lable>
						<div class="phonefull">
							<small id="phone11"></small> - <small id="phone21"></small> - <small
								id="phone31"></small>
						</div>
						<%-- <input type="tel" id="phoneNumber" name="phoneNumber"
							class="phone-input" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}"
							placeholder="예: 010-123-4567" readonly
							value="${ login_member_phone}"> --%>
						<!-- <small>형식: 010-123-4567</small> -->
						<%-- <p>${login_member_phone}</p> --%>
					</div>
					<div class="name-pickup">
						<div>
							<label>이름</label> <input type="text" id="name" name="name"
								value="${member.member_name}" readonly
								style="margin-left: 115px; font-size: 20px; font-weight: normal;">
						</div>
					</div>

	 			<div  style="display: none;">
					주소
					<c:forEach items="${member_address_map}" var="member_address">
						<div id="${member_address.key}" style="display: none;" class="key">
							<label> 주소 </label> <input type="text" id="address1"
								name="address" value="${member_address.value.member_address }"
								readonly><br> <input type="text" id="address2"
								name="address"
								value="${member_address.value.member_address_detail }" readonly>
						</div>
					</c:forEach>
				</div> 
				</div>
			</div>
			<div class="form-grup-2"></div>
			<div class="select2">
				<div class="ptage">
					<p>
					<li></li>요청 사항을 입력해 주세요
					</p>
				</div>
				<textarea id="request_pick" name="request"></textarea>
				<!-- <input type="text" id="request_del" name="request" value=""> -->
			</div>
			<div class="form-grup-3"></div>
			<div class="select3">
				<div class="ptage">
					<p>
					<li></li>할인 혜택을 받아보세요
					</p>
				</div>

				<div class="select1_info">
					<!-- <label> 쿠 폰 </label> <select>
						<option>1.할인 쿠폰</option>
						<option>2.할인 쿠폰</option>
						<optinon>3.할인 쿠폰</optinon>
					</select> <br> -->
					<!-- <lable> 포인트 / 마일리지 </lable> -->
					<div>
						<label> 마일리지</label>
					</div>
					<div class="point_Mileage">
						<!-- <div class="point-block">
							<input type="text" id="point" name="point"> <small>원
								/659P</small>
								<input type="text" id="readpoint" name="readpoint" value="가지고있는 포인트 값" readonly>
							<input type="button" id="usepoint" name="usepoint" value="전액사용">
						</div> -->
						<div class="mileage-block">
							<input type="number" id="mileage_pick" name="mileage" onchange="mileage_function(event)" value="0" max="${member.member_mileage}"> <small>원
								/${member.member_mileage}M</small>
							<!-- <input type="text" id="readmileage" name="readmileage"
							value="가지고있는 마일리지 값" readonly>  -->
							<!-- <input type="button" id="usemileage" name="usemileage"
								value="마전액사용"> -->
						</div>
					</div>
					<div class="mileage_describe" style="margin-top: 15px;color: #A6A6A6;">
							마일리지는 총 결제금액의 50%까지만 사용 가능합니다!
						</div>
				</div>
			</div>

			<div class="form-grup-4"></div>
			<div class="select4">
				<div class="ptage">
					<p>
					<li></li>결제 수단을 선택 해주세요
					</p>
				</div>
				<br>
				<div class="payTpye">
					<c:forEach var="paymentTpye" items="${payment_type_use}">
						<input type='radio' name='paymethod2'
							onclick="payment_type_function(event)" 
							value="${paymentTpye.payment_type_seq}" />${paymentTpye.payment_type}</c:forEach>
				</div>
			</div>
		</form>
	</div>
	
</div>

	<!--    -----------------------------------------------모달  ------------------------------------------------------------- -->
	<div id="add_address_form" class="hidden">
		<div id="add_adress_content" class="add_adress_content">
			<!-- <form action="addmoreAddress.do" method="post"> -->
			<div class="part-form-group">
				<div class="form-group">
					<label>배송지 이름 추가</label><br> <input type="text"
						name="addressName" id="addressName">
				</div>

				<div class="form-group">
					<label>주소</label> </br> <input type="text" name="postcode"
						class="input-id" id="postcode" placeholder="Address" readonly />

					<div class="addressSbutton">
						<input type="button" onclick="get_address()" value="주소 찾기"
							required />
					</div>
					<br>
				</div>
				<div class="form-group">
					<label>도로명 주소</label></br> <input type="text" name="address"
						id="address" class="input-id" placeholder="Street name address"
						readonly required />
				</div>

				<div class="form-group">
					<label>상세 주소</label></br> <input type="text" name="address_detail"
						class="input-id" id="detail_address"
						placeholder="Detailed Address" required /><br>
				</div>
			</div>
			<input id="address_latitude" name="address_latitude"
				style="display: none;" /> <input id="address_longitude"
				name="address_longitude" style="display: none;" />
			<div id="moda-form-butn">
				<input type="button" id="alter" name="alter" value="추가하기">
				<button id="add_address_close_btn">닫기</button>
			</div>
			<!-- </form> -->
		</div>
	</div>
	<script
		src="${pageContext.request.contextPath}/resources/js/oderpayPage02.js"></script>
</body>



<script type="text/javascript">
	//첫 화며에서 pickup form 안나오게
	var total_payment_mini = ${total};
	var address_new=sessionStorage.getItem("my_addr");
	document.getElementById('address_new').innerHTML=address_new;
	var user_mileage_value =${member.member_mileage};
	var total_pay= ${total} 
	var get_id = "${get_id}";
	var check_value;
	var payment_type_value;
	var address_name = "";
	console.log('aaaaaaaaa', get_id);
	var menu_key = [];
	var menu_document = document.querySelectorAll('.key_menu');
	var store_id = ${store_id};
	var store_ip_path = "${store_ip_path}";
	console.log('++++++++++++',store_ip_path);
	console.log('++++++++++++', "${store_ip_path}");
	
	for (let i = 0; i < menu_document.length; i++) {
		menu_key.push(menu_document[i].id);
	}
	console.log('keyaaaaab', menu_key, menu_document.length);
	if (get_id == "delivery") {
		document.getElementById('pickup-form').style.display = 'none';
	} else {
		document.getElementById('deliveryform').style.display = 'none';
	}
	var key_doc = document.querySelectorAll(".key");
	var keys = [];
	console.log('aaa');
	console.log(key_doc);
	for (let i = 0; i < key_doc.length; i++) {
		console.log('tttt', key_doc[i].id);
		keys.push(key_doc[i].id);
	}
	console.log(keys);

	function getselect(event) {
		console.log(event.target.value);
		console.log(keys);
		address_name = event.target.value;
		for (let i = 0; i < keys.length; i++) {
			if (keys[i] != "") {
				document.getElementById(keys[i]).style.display = 'none';
			}
		}

		document.getElementById(event.target.value).style.display = 'block';
	}

	var delivery_radio = document.getElementsByName('delivery');

	function delivery_raido_fucntion(event) {
		if (event.target.value == 'delivery') {
			document.getElementById('pickup-form').style.display = 'none';
			document.getElementById('deliveryform').style.display = 'block';
		} else if (event.target.value == 'pick_up') {
			document.getElementById('pickup-form').style.display = 'block';
			document.getElementById('deliveryform').style.display = 'none';

		}

	}

	var phone_number = "${ login_member_phone}";

	var num1 = phone_number.substring(0, 3);
	var num2 = phone_number.substring(3, 7);
	var num3 = phone_number.substring(7, 11);

	document.getElementById("phone1").innerHTML = num1;
	document.getElementById("phone2").innerHTML = num2;
	document.getElementById("phone3").innerHTML = num3;
	document.getElementById("phone11").innerHTML = num1;
	document.getElementById("phone21").innerHTML = num2;
	document.getElementById("phone31").innerHTML = num3;

	document.getElementById('alter').addEventListener('click', address_check);

	var open_add_address = document.querySelector('#add_address_btn');
	var add_address_form = document.querySelector('#add_address_form');

	function address_check() {
		var addressNameValue = document.getElementById('addressName').value;
		var addressValue = document.getElementById('address').value;
		var address_detailValue = document.getElementById('detail_address').value;
		var address_latitudeValue = document.getElementById('address_latitude').value;
		var address_longitudeValue = document
				.getElementById('address_longitude').value;

		var obj = {
			'member_address_name' : addressNameValue,
			'member_address' : addressValue,
			'member_address_detail' : address_detailValue,
			'member_address_latitude' : address_latitudeValue,
			'member_address_longitude' : address_longitudeValue,
		};
		$.ajax({
			type : "POST",
			url : "addmoreAddress.do",
			data : obj,//JSON.stringify(id_object),
			//contentType: "application/json; charset=utf-8;",
			success : function(res) {
				console.log('test');
				console.log(res);
				document.getElementById("delivery_div").innerHTML = res;
				document.getElementById("phone1").innerHTML = num1;
				document.getElementById("phone2").innerHTML = num2;
				document.getElementById("phone3").innerHTML = num3;

				document.getElementById("addressName").value = "";
				document.getElementById("postcode").value = "";
				document.getElementById("address").value = "";
				document.getElementById("detail_address").value = "";

				document.getElementById("address_longitude").value = "";
				document.getElementById("address_latitude").value = "";

				open_add_address.addEventListener('click',
						open_add_address_function);
				document.querySelector('#add_address_form').classList
						.add('hidden');
				// res.result  form-grup-1
			},
			error : function() {
				alert('ajex 실패');
			}
		});
	}

	var geocoder = new kakao.maps.services.Geocoder();

	function get_address() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				console.log(data);
				document.getElementById('postcode').value = data.zonecode;
				document.getElementById("address").value = roadAddr;
				console.log('종료1');

				geocoder.addressSearch(roadAddr, get_position);
			}
		}).open();
		console.log('종료2');
	}

	var get_position = function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			console.log(result);

			document.getElementById('address_longitude').value = result[0].x;
			document.getElementById("address_latitude").value = result[0].y;
			console.log(result[0].x); //owner_address_longitude
			console.log(result[0].y); //owner_address_latitude
		}
	};
	function open_add_address_function() {
		console.log("open 모달");
		add_address_form.classList.remove('hidden');
	}
	
	IMP.init('imp47436353');
	function submit_function() {
		
		console.log("submit");
		var fee = document.getElementById("total_fee").value;
		obj_submit = {
			"store_name" : "${storeName}",
			"payment_type" : payment_type_value,
			"payment_get_id" : get_id,
			"total_fee" : fee,
			"store_id" : store_id,
			"store_ip_path":store_ip_path
		};
		console.log(get_id);
		if (get_id == 'delivery') {
			obj_submit["payment_request_content"] = document
					.getElementById("request_del").value;
			obj_submit["address_name"] = address_name;
			obj_submit["mileage"] = document
			.getElementById("mileage").value;
		} else {
			console.log("-------+++++++++-----",document.getElementById("request_pick").value);
			obj_submit["payment_request_content"] = document
					.getElementById("request_pick").value;

			obj_submit["mileage"] = document
			.getElementById("mileage_pick").value;
		}
		var arr = [];
		console.log("------------------------");
		var menuString="(${storeName})";
		for (let i = 0; i < menu_key.length; i++) {
			menuString+=menu_key[i] + '_';
			arr.push(menu_key[i] + '_'
					+ document.getElementById(menu_key[i] + '_cnt').value + '_'
					+ document.getElementById(menu_key[i] + '_disprice').value
					+ '_'
					+ document.getElementById(menu_key[i] + '_price').value);
			/* obj_submit[menu_key[i]+'_cnt']=document.getElementById(menu_key[i]+'_cnt').value;
			obj_submit[menu_key[i]+'_disprice']=document.getElementById(menu_key[i]+'_disprice').value;
			obj_submit[menu_key[i]+'_price']=document.getElementById(menu_key[i]+'_price').value; */
		}
		obj_submit['menu2'] = menuString;
		obj_submit['menu'] = arr;
		console.log(menu_key);
		console.log(obj_submit);
		console.log(get_id, "get_id");
		console.log(payment_type_value);
		console.log(payment_type_value==null);
		
		 if ((address_name != "" || get_id == "pick_up") && payment_type_value != null){
			// payment_type_value에 따라 pg 값 설정
			if(payment_type_value == 1) {
				var form = document.createElement("form");
	  			form.setAttribute("method", "post");
	  			form.setAttribute("action", "paymentend.do");
	  			console.log("submit 전송");
	  			for (let obj_key in obj_submit) {
	  				var input = document.createElement("input");
	  				input.setAttribute("type", "hidden");
	  				input.setAttribute("name", obj_key);
	  				input.setAttribute("value", obj_submit[obj_key]);
	  				form.appendChild(input);
	  			}
	  			document.body.appendChild(form);
	  			form.submit();
			}else {
				if (payment_type_value == 3) {
		            obj_submit["pg"] = 'kakaopay.TC0ONETIME';
		            obj_submit["pay_method"] = 'card';
		        } else if (payment_type_value == 2) {
		            obj_submit["pg"] = 'html5_inicis.INIBillTst';
		            obj_submit["pay_method"] = 'card';
		        } else if (payment_type_value == 4) {
		            obj_submit["pg"] = 'tosspay.tosstest';
		            obj_submit["pay_method"] = 'card';
		        } 
				var payment_merchant_uid =  new Date().getTime();
			    IMP.request_pay({
			      pg: obj_submit["pg"],
			      pay_method: obj_submit["pay_method"],
			      merchant_uid:payment_merchant_uid,   // 주문번호
			      name: obj_submit["menu2"],
			      amount: ${total}-document.getElementById('mileage').value,      // 숫자 타입
			      buyer_email: "${member.member_email}",
			      buyer_name: "${member.member_name}",
			      buyer_tel: "${member.member_phone}"
			    }, function (rsp) { // callback
			      //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
			     
			    	  if (rsp.success) {
			    		var msg = '결제가 완료되었습니다.';
			  			var form = document.createElement("form");
			  			form.setAttribute("method", "post");
			  			form.setAttribute("action", "paymentend.do");
			  			console.log("submit 전송");
			  			obj_submit["payment_merchant_uid"]=payment_merchant_uid;
			  			for (let obj_key in obj_submit) {
			  				var input = document.createElement("input");
			  				input.setAttribute("type", "hidden");
			  				input.setAttribute("name", obj_key);
			  				input.setAttribute("value", obj_submit[obj_key]);
			  				form.appendChild(input);
			  			}
			  			document.body.appendChild(form);
			  			form.submit();
			  		}
			      else {
			    	  var msg = '결제 실패';
			          msg += '\n에러내용 : ' + rsp.error_msg;
			      }
			    	alert(msg);
			    });
			}
	        
		
		 }else {
			 alert("주문 정보를 모두 기입해주세요.");
		 }
		
		
		

	}
	function payment_type_function(event) {
		check_value = event.currentTarget.value;
		console.log(check_value);
		payment_type_value = check_value;
	}
	function mileage_function(event){
		var mileage = event.target.value;
		//user_mileage_value total_pay
		
		console.log(user_mileage_value,"   ",total_pay);
		if(mileage>user_mileage_value || mileage > total_pay/2){
			event.target.value=user_mileage_value>total_pay/2?total_pay/2:user_mileage_value;
		}
		//document.getElementById('payment_total_mini').value=total_payment_mini-event.target.value;
	}
</script>
<%-- <%@include file="/resources/jsp/find_address.jsp"%> --%>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</html>