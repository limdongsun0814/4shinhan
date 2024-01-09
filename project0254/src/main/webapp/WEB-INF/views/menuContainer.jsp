<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<style>
.catgory_title {
	margin-top: 1rem;
}

.menu_category_name {
	font-size: 1.3rem;
	font-weight: bold;
}

.count_change_btn {
	background-color: #FFEC9F;
	font-size: 1rem;
	font-weight: 500;
	border-radius: 3px;
	padding: 10px;
	border: none;
}

.menu_add_container {
	margin-bottom: 1rem;
	display: flex;
	align-items: center;
}

.add_menu {
	background-color: #F8C9DF;
	font-size: 1rem;
	font-weight: 500;
	border-radius: 3px;
	border: none;
	padding: 10px;
	margin-right: 10px;
}

.menu_thumb {
	margin: 1rem;
	border-radius: 5px;
	width: 27%;
	margin-right: 1.5rem;
}


.menu_text {
	display: flex;
	flex-direction: column;
	justify-content: space-around;
	padding: 10px 0;
	width: 60%;
}

.menu_text>h5 {
	color: #787878;
	font-weight: 600;
	font-size: 1rem;
}

.menu_text>h4 {
	font-weight: 700;
	font-size: 1.3rem;
}

.menu_text>h6 {
	font-weight: 600;
	font-size: 1.3rem;
}

.menu_text>* {
	margin: 1.2rem 0;
	word-break: keep-all;
}

hr {
	width: 100%;
	background-color: #9E9E9E;
	padding: 0.2px;
}

.menu_container {
	background-color: white;
	justify-content: space-between;
}

.menu_controller {
	position: relative;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: end;
}

.menu_manage_btn {
	background: none;
	border: none;
}

.count_change>form {
	margin-top: 0.5rem;
	display: flex;
	justify-content: end;
}

.menu_count {
	width: 30%;
	height: 30px;
	margin: 0 5px;
	font-size: 1rem;
	font-weight: 600;
	text-align: center;
}

.svg_container {
	cursor: pointer;
}

.menu_thumb > img {
	width:100%;
}

</style>
<div>
	<div class="category_change" style="visibility: hidden;">카테고리 순서
		변경 칸</div>
</div>
<!-- 메뉴 카테고리 칸 -->
<div id="menu_cateogory_container">
	<!-- 카테고리 전체 품절 버튼...? 전체 품절일때 품절 중 어떻게 보여주는가, 전체 품절 표시 확인 필요 -->
	<c:forEach var="category" items="${menuCategory}">
		<div class="catgory_title">
			<div class="menu_category_name">${category.menu_category_name}</div>
			<div class="isPurchase">
				<select class="category_count_change count_change_btn"
					name="${category.menu_category_seq}">
					<c:set var="total" value="0" />
					<c:forEach items="${menuList}" var="menu">
						<c:if test="${menu.menu_category == category.menu_category_seq }">
							<c:set var="total" value="${total + menu.menu_count}" />
						</c:if>
					</c:forEach>
					<c:choose>
						<c:when test="${total == 0}">
							<option value=1>판매중</option>
							<option selected value=-1>품절</option>
						</c:when>
						<c:otherwise>
							<option selected value=1>판매중</option>
							<option value=-1>품절</option>
						</c:otherwise>
					</c:choose>
				</select>
			</div>
		</div>
		<hr>
		<!-- 메뉴 리스트 칸 -->
		<div class="menu_add_container">
			<button class="add_menu"
				onclick="location.href='menuInsert.do?category_id=${category.menu_category_seq}'">메뉴
				추가</button>
			<div style="visibility: hidden;">메뉴 순서 변경</div>
		</div>
		<div class="menulist_container">
			<c:forEach items="${menuList}" var="menu">
				<c:if test="${menu.menu_category == category.menu_category_seq }">
					<div class="menu_container flexbox">
						<div class="menu_info flexbox"
							onclick="location.href='menuManagement.do?menu_id=${menu.menu_id}'">
							<div class="menu_thumb">
								<img src="${menu.menu_thumb_image_path!=null?menu.menu_thumb_image_path:'./resources/store/notMenuImg_square.png'}">
							</div>
							<div class="menu_text">
								<h4>${menu.menu_name}</h4>
								<h5>${menu.menu_describe}</h5>
								<h6>${menu.menu_price}원</h6>
								
							</div>
						</div>
						<div class="menu_controller">
							<div class="flexbox">
							
								<select class="menu_count_change count_change_btn"
									name="${menu.menu_id}">
									<c:choose>
										<c:when test="${menu.menu_count == 0}">
											<option value="${menu.menu_count}">판매중</option>
											<option selected value=-1>품절</option>
										</c:when>
										<c:otherwise>
											<option selected value=10>판매중</option>
											<option value=-1>품절</option>
										</c:otherwise>
									</c:choose>
								</select>
								<button class="menu_manage_btn">
									<img
										src="${pageContext.request.contextPath}/resources/images/svg/editorButton.svg"
										alt="SVG Image">
								</button>
							</div>
							<div class="count_change">
								<form method="get" action="updateMenuCount.do"
									class="update_form">
									<input type=hidden name=menu_id value="${menu.menu_id}">
									<div class="svg_container count_down">
										<img
											src="${pageContext.request.contextPath}/resources/images/svg/minusButton.svg"
											alt="SVG Image">
									</div>
									<input name="menuCount" class="menu_count"
										value="${menu.menu_count}">
									<div class="svg_container count_up">
										<img
											src="${pageContext.request.contextPath}/resources/images/svg/plusButton.svg"
											alt="SVG Image">
									</div>
								</form>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>

	</c:forEach>
</div>
<script>
/* var menuCountChanges = document.querySelectorAll('.menu_count_change');
for(var i = 0; i < menuCountChanges.length; i++){
	var options = menuCountChanges[i].options;
	for (var j = 0; j < options.length; j++) {
		  if (options[j].value === '-1') {
		    menuCountChanges[i].style.backgroundColor = '#a6a6a6';
		    break;
		  }
	}
} */



		function decreaseCount(button) {
		  var menuCountInput = button.nextElementSibling;
		  var menuCount = parseInt(menuCountInput.value);
		  
		  if (menuCount > 0) {
		    menuCountInput.value = menuCount - 1;
		  }
		}

		// count_up 버튼 클릭 시 menu_count 증가
		function increaseCount(button) {
		  var menuCountInput = button.previousElementSibling;
		  var menuCount = parseInt(menuCountInput.value);
		  
		  menuCountInput.value = menuCount + 1;
		}

		// 모든 count_down 버튼에 이벤트 리스너 등록
		var countDownButtons = document.querySelectorAll('.count_down');
		countDownButtons.forEach(function(button) {
		  button.addEventListener('click', function() {
		    decreaseCount(this);
		  });
		});

		// 모든 count_up 버튼에 이벤트 리스너 등록
		var countUpButtons = document.querySelectorAll('.count_up');
		countUpButtons.forEach(function(button) {
		  button.addEventListener('click', function() {
		    increaseCount(this);
		  });
		});
		
		$("#menu_cateogory_container").on("click", ".menu_manage_btn", function() {
			var form = $(this).parent().parent().find('form');
			form.submit();
		}) 
		
		
	</script>

<script>
			// 각 메뉴 개수 변화 이벤트     
			var countChangeMenus = document.querySelectorAll(".menu_count_change");
			countChangeMenus.forEach(function(menu) {
						menu.addEventListener("change",	function() {
											if (menu.options[menu.selectedIndex].value == -1) {
												if (!confirm("품절 처리 하시겠습니까?")) {
													alert("취소(아니오)를 누르셨습니다.");
													menu.options[0].selected = true;
												} else {
													alert("품절 처리 되었습니다.");
													window.location.href="soldOutMenu.do?menu_id="+menu.name;
												}
											} else {
												console.log(menu.options[menu.selectedIndex].value);
											}
										});
					});

			//카테고리 개수 변화 이벤트
			var countChangeCategory = document
					.querySelectorAll(".category_count_change");
			countChangeCategory
					.forEach(function(category) {
						category
								.addEventListener(
										"change",
										function() {
											if (category.options[category.selectedIndex].value == -1) {
												if (!confirm("카테고리를 품절 처리 하시겠습니까?")) {
													alert("취소(아니오)를 누르셨습니다.");
												} else {
													alert("품절 처리 되었습니다.");
													window.location.href = 'soldOutCategory.do?menu_category='
															+ category.name;
												}
											} else {
												console
														.log(menu.options[menu.selectedIndex].value);
											}
										});
					});
		</script>