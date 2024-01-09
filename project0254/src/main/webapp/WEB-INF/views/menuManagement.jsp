<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/SeoulNamsanM.woff">

<style>
input {
	border: 1px solid lightgray; /* 테두리를 연한 회색으로 설정 */
	border-radius: 5px; /* 테두리를 둥글게 만듦 */
	text-align: right;
}

.price-input {
	display: flex;
	justify-content: flex-end; /* 우측 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
	margin-top: 20px; /* 원하는 마진 크기로 조절하세요. */
}

.price-input span {
	margin-left: 5px; /* 원화 기호와 입력 필드 사이의 간격 설정 */
}

.contenttop {
	/* background-image: url('./resources/images/contenttop1.png'), url('./resources/images/contenttop2.png'); */
	background-repeat: no-repeat;
	background-size: cover;
	height: 150px;
}

.content1 {
	width: 50%;
	margin: 0 auto;
	/* background-color: #FEF4CF; */
}

.indoorbutton {
	display: flex;
	justify-content: center;
	height: 30px;
	align-items: center; /* 수직 중앙 정렬 */
	margin: 0 auto;
	border: none;
	border-radius: 5px;
	background-color: #FF6464;
	color: #ffffff;
	cursor: pointer;
	text-align: center;
	width: 20%;
	margin: 0 auto /* 버튼 크기를 20%로 줄임 */
}

.full {
	display: flex;
	border: 1px solid #FF6464;
	border-radius: 20px;
}

h1 {
	text-align: center;
	font-family: 'SeoulNamsanM' !important;
	color: #FF6464;
}

h4 {
	font-family: 'SeoulNamsanM' !important;
}

textarea[name="menu_describe"] {
	width: 100%; /* 전체 너비 */
	border: 1px solid lightgray; /* 테두리 스타일 */
	border-radius: 10px;
}

.insert {
	width: 50%;
	float: left;
	padding: 30px;
}

.preview {
	width: 50%;
	float: left;
	padding: 30px;
}

.divimage {
	width: 100%;
	text-align: center;
}

.flex-container {
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: space-between;
}

.flex-container h4 {
	margin-right: 10px;
}

.flex-container input[type="text"], .flex-container input[type="int"],
	.flex-container textarea {
	width: 100%;
}

.inline-div {
	display: inline-block;
	/* 추가적으로 필요한 스타일링을 여기에 작성하세요. */
}

.box {
	display: inline-block;
	padding: 8px 16px;
	margin: 4px;
	background-color: lightgray;
	color: white;
	text-align: center;
	border-radius: 5px;
	cursor: pointer;
}

.box.pink {
	background-color: FF6464;
}
#upload_img, #upload_img_thumb {
	margin-top:1rem;
	width:auto;
	height:11rem;
}  
</style>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<%@ include file="/WEB-INF/views/common/ownerHeader.jsp"%>
</head>
<body>
	<form method="POST" action="menuManagement.do" enctype="multipart/form-data">
		<div class="all">
			<div class="side">
				<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>
			</div>
			<input type="hidden" name=menu_id value="${menu.menu_id }"> <input
				type="hidden" name=menu_store_id value="${menu.menu_store_id }">

			<div class="content1">
				<div class="contenttop">
					</br> </br>
					<h1>메뉴수정</h1>
				</div>
				<div class="full">
					<div class="insert">
						<div class="flex-container">
							<h4>카테고리</h4>
							<select name="menu_category">
								<c:forEach items="${menucategory}" var="category">
									<!-- jstl if문으로 선택 시 selected 넣기? -->
									<option value='${category.menu_category_seq}'
										<c:if test="${category.menu_category_seq==menu.menu_category}">
								selected
							</c:if>>${category.menu_category_name}
									</option>
								</c:forEach>
							</select>
						</div>
						<div class="flex-container">
							<h4>빵이름</h4>

							<!-- <input type="checkbox" name="item" value="menu_is_hot">대표메뉴1 value="${menu.menu_is_hot}"  value="${menu.menu_is_signature}" -->
							<input id="hotCheck" type="checkbox" name="menu_is_hot"
								 ${menu.menu_is_hot?'checked':''}>대표메뉴 <input
								id="signatureCheck" type="checkbox" name="menu_is_signature" ${menu.menu_is_signature?'checked':''}
								>시그니처 <br>
						</div>

						<script>
							var hotCheck = document.querySelector("#hotCheck");
							if (hotCheck.value == "true") {
								hotCheck.click();
							}
							var signatureCheck = document
									.querySelector("#signatureCheck");
							if (signatureCheck.value == "true") {
								signatureCheck.click();
							}
						</script>
						<div class="price-input">
							<input type="text" name="menu_name" value="${menu.menu_name}" />
							<br />
						</div>
						<h4>빵 한 줄 소개</h4>
						<textarea name="menu_describe" rows="5">${menu.menu_describe}</textarea>
						<div class="flex-container">
							<h4>가격</h4>

							<div class="price-input">
								<input id="price" type="int" oninput="makeDiscount()"
									name="menu_price" value="${menu.menu_price }" /> <span>원</span>
							</div>
						</div>
						<h4>할인할 금액</h4>
						<div class="price-input">
							<input id="discountprice" oninput="makeDiscount()" type="int"
								name=menu_discount_price value="${menu.menu_discount_price }" /><span>원</span>
							<br />
						</div>

						<h4>현재 판매가</h4>
						<div class="price-input">
							<span id="discounted">${menu.menu_price-menu.menu_discount_price }
								원</span> <br />
						</div>
						<script>
							function makeDiscount() {
								console.log("change");
								var price = document.querySelector("#price");
								var discountprice = document
										.querySelector("#discountprice");
								var discounted = document
										.querySelector("#discounted");

								discounted.innerHTML = price.value
										- discountprice.value + "원";
							}
						</script>

						<h4>빵 나오는 시간</h4>
						<div class="price-input">
							<input type="int" name=menu_time value="${menu.menu_time }" /><span>시</span>
							<br />
						</div>
						<h4>나오는 빵</h4>
						<div class="price-input">
							<input type="int" name=menu_making_count
								value="${menu.menu_making_count }" /><span>개</span> <br />
						</div>

						<h4>노출상태</h4>
						<div>
							<div id="open" class="box ">일시품절</div>
							<div id="close" class="box ">노출중</div>
							<div class="price-input">
								<span>현재 상품 수 </span> &nbsp;<input id="count" name="menu_count"
									value="${menu.menu_count}">개
							</div>
						</div>

						<script>
							var count = document.getElementById("count");
							console.log(count.value);
							var open = document.querySelector("#open");
							var close = document.querySelector("#close");

							if (count.value > 0) {
								// 상품 수가 0보다 클 때, '일시품절' 박스에 'blue' 클래스를 추가하고 색상을 변경
								close.classList.add("pink");
								close.style.backgroundColor = "pink";
							} else {
								// 상품 수가 0 이하일 때, '노출중' 박스에 'blue' 클래스를 추가하고 색상을 변경
								open.classList.add("pink");
								open.style.backgroundColor = "pink";
							}
						</script>


					</div>

					<div class="preview">
						<h4>사진</h4>
						<div class="divimage">
							<fieldset id="imagebox">
								<p>이미지를 선택해주세요</p>
								<input type="hidden" name="menu_image_path" id="0_img_thumb_input" value="${menu.menu_thumb_image_path}">
								<input type="file" name="new_menu_image_path" id="new_img_input" onchange="setImgPath(event)" >
							</fieldset>
							<div id="menu_image_preview">
								<img src="${menu.menu_image_path }" id="upload_img">						
							</div>

							</br> </br>
						</div>
						
						
						<h4>썸네일 사진</h4>
						<div class="divimage">
							<fieldset id="thumbimagebox">
								<p>썸네일용 이미지를 선택해주세요</p>
								<input type="hidden" name="menu_thumb_image_path" id="0_img_thumb_input" value="${menu.menu_thumb_image_path}">
								<input type="file" name="new_menu_thumb_image_path" id="new_img_thumb_input" onchange="setThumbnail(event)" >
							</fieldset>
							<div id="menu_thumb_image_preview">
								<img src="${menu.menu_thumb_image_path }" id="upload_img_thumb">						
							</div>

							</br> </br>
						</div>
					</div>



				</div>
				</br>
				<div class="w3-container w3-center">
					<button class="indoorbutton" type="submit">메뉴수정</button>
				</div>
				
				
			</div>
		</div>
		<br>

		</div>
	</form>
<%-- 	<form action="menuDelete.do" method="post">
									<input type="hidden" name="menu_id" value="${menu.menu_id}" />
									<!-- 삭제할 공지사항의 시퀀스 값을 여기에 입력해주세요 -->
									<button class="deletebutton"
										onclick="deleteConfirm(event, this, ${menu.menu_id})">메뉴
										삭제</button>
								</form></br> --%>
		<script>
function deleteConfirm(event, element, menu_id) {
	event.preventDefault();
    var result = confirm("메뉴 " + menu_id + "번을 삭제하시겠습니까?");
    if (result) {
        var form = element.closest("form");
        form.submit();
    } else {
        alert("삭제가 취소되었습니다.");
    }
}
</script>
	<script>
		window.onload = function() {
			var textarea = document.getElementById('menu_describe');
			var input = document.getElementById('menu_name');

		}
	</script>
	<script>
	function setImgPath(event) {
	    var reader = new FileReader();

	    console.log(event.target.id);
		var img_id = event.target.id.split('_')[0];
	    console.log("event",event);
	    
	    reader.onload = function(event) {
	    var img = document.getElementById("upload_img");
	    img.src=event.target.result;
	     /* img.setAttribute("src", event.target);
	     img.setAttribute("id", img_id+"_"+"img"); */
	    console.log(event.target.id);
	    console.log(event.target);
	    console.log(img);
	     //document.querySelector("div#img_container").appendChild(img);
	   };
	    reader.readAsDataURL(event.target.files[0]);
	 }
	
	  function setThumbnail(event) {
	    var reader = new FileReader();

	    console.log(event.target.id);
		var img_id = event.target.id.split('_')[0];
	    console.log("event",event);
	    
	    reader.onload = function(event) {
	    var img = document.getElementById("upload_img_thumb");
	    img.src=event.target.result;
	     /* img.setAttribute("src", event.target);
	     img.setAttribute("id", img_id+"_"+"img"); */
	    console.log(event.target.id);
	    console.log(event.target);
	    console.log(img);
	     //document.querySelector("div#img_container").appendChild(img);
	   };
	    reader.readAsDataURL(event.target.files[0]);
	 }
	</script>
</body>
<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
</html>