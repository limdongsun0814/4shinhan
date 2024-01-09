<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/registDiscount.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">

</head>
<body>
	<%@ include file="/WEB-INF/views/common/ownerHeader.jsp"%>

	<div class="all">
		<div class="side">
			<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>
		</div>
		<div>
		<div class="registDiscount-title">할인등록</div>
		<div class="menu_all_container">
			<div class="flexbox_selectBox flexbox">
				<span>카테고리 선택</span> <select id="category_select"
					onchange="categoryChange(this)">
					<option value=0>카테고리를 선택하세요</option>
					<c:forEach items="${menuCategoryList}" var="category">
						<option value="${category.menu_category_seq}">${category.menu_category_name }</option>
					</c:forEach>
				</select>
			</div>
			<div id="menu_container">
				<div class="categoryTotal-title">
					<input id="categoryTotal" type="checkbox" onclick="allCheck(this)">
					<label for="categoryTotal">카테고리</label>
				</div>
				<script>
					function categoryChange(e) {
						document.querySelector("#categoryTotal").value = e.value;
						document.querySelector("#categoryTotal").checked = false;
					}

					//전체선택 함수
					function allCheck(e) {
						var menuAll = document.querySelectorAll(".menubar");
						if (e.checked == true) {
							for (let i = 0; i < menuAll.length; i++) {
								if (!menuAll[i].classList.contains('hide')) {
									menuAll[i].getElementsByTagName('input')[0].checked = true;
								} else {
									menuAll[i].getElementsByTagName('input')[0].checked = false;
								}
							}
						} else {
							for (let i = 0; i < menuAll.length; i++) {
								menuAll[i].getElementsByTagName('input')[0].checked = false;

							}
						}
					}
				</script>
				<hr>
				<div class="menu_check_list" id="menu_check_list">
					<c:forEach items="${menuList}" var="menu">
						<div class="menubar hide" id="menubar-hide1">
							<input type="checkbox" id="${menu.menu_id}"
								name="${menu.menu_id}" value="${menu.menu_id }"
								data-category="${menu.menu_category}"> <label class="hide1"
								for="${menu.menu_id}">${menu.menu_name}</label>
						
						<div class="hide2-container">
							<div class="hide-img"><img src="${menu.menu_thumb_image_path == null?'./resources/images/0254logo.png':menu.menu_thumb_image_path}"></div>
							<div class="hide2">${menu.menu_describe}</div>
							<div class="price_wrapper">
								<div class="hide3">${menu.menu_price}원</div>
								<div class="hide4"><span>할인 가격</span>: ${menu.menu_discount_price} 원</div>
							</div>
						</div>
						</div>
						
					</c:forEach>
				</div>
			</div>
			<div id="discount_container">
				<div>
					<span>할인금액</span> <input class="discount_price" type="number" name="discount_price">
					<span>원</span>
				</div>
				<button class="regist-btn" onclick="doPost()">할인적용하기</button>
			</div>
		</div>
		</div>
	</div>
<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
</body>
<script>
	window.onload = function() {
		var menu_check_list = document.querySelector("#menu_check_list");
		menu_check_list.classList.add("show");
		
		var select = document.getElementById('category_select');
		select.addEventListener('change', function() {
			if(this.value == 0){
				console.log('없음');
				menu_check_list.classList.add("show");
			} else {
				menu_check_list.classList.remove("show");
			}
			var menuBarList = document.querySelectorAll('.menubar');
			for (let i = 0; i < menuBarList.length; i++) {
				var checkbox = menuBarList[i]
						.querySelector('input[type=checkbox]');
				if (this.value != checkbox.dataset.category) {
					checkbox.disabled = true;
					menuBarList[i].classList.add("hide");
				} else {
					checkbox.disabled = false;
					menuBarList[i].classList.remove("hide");
				}
			}
			
		});
	};

	function doPost() {
		var menuBarList = document.querySelectorAll('.menubar');
		var checkedMenus = [];
		var discountPrice = document
				.querySelector('input[name="discount_price"]').value;

		for (let i = 0; i < menuBarList.length; i++) {
			var checkbox = menuBarList[i]
					.querySelector('input[type="checkbox"]');
			if (checkbox.checked) {
				checkedMenus.push(checkbox.name);
			}
		}

		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", "registDiscount.do");

		var menuInput = document.createElement("input");
		menuInput.setAttribute("type", "hidden");
		menuInput.setAttribute("name", "menu_id");
		menuInput.setAttribute("value", checkedMenus);
		form.appendChild(menuInput);

		var discountInput = document.createElement("input");
		discountInput.setAttribute("type", "hidden");
		discountInput.setAttribute("name", "discount_price");
		discountInput.setAttribute("value", discountPrice);
		form.appendChild(discountInput);

		/*
		var formData = new FormData();
		formData.append("discount_price", discountPrice);
		for (let i = 0; i < checkedMenus.length; i++) {
		  formData.append("menu_id", checkedMenus[i]);
		}
		 */

		// form을 body에 추가하고 제출
		document.body.appendChild(form);
		form.submit();
	}
</script>
</html>