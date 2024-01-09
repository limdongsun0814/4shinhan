<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Menu | 빵이오4</title>
		<style>
.menu_all_container {
	padding: 0 10%;
}

.catgory_title {
	display: flex;
	justify-content: space-between;
}

#menu_cateogory_container {
	padding: 0 8%;
}

.menu_add_container {
	display: flex;
}

.menulist_container {
	padding-bottom: 20px;
}



.menu_info {
	width: 68%;
}

.flexbox {
	display: flex;
}

.menu_thumb {
	width: 40%;
	height: auto;
	display:flex;
	align-items:center;
}

.menu_controller>select {
	display: inline-block;
}

#searchBar{
	position:relative;
	display:flex;
	background-color:#F7F0DA;
	border:none;
	border-radius:5px;
	padding:10px;
}

#search{
	width:20rem;
}

#searchBar > button {
	border:none;
	outline:none;
	background-color:inherit;
	cursor:pointer;
	position:relative;
}

.icon-container {
	position: relative;
    width: 35px;
    height: 35px;
    overflow: hidden;
    
}

.icon-search {
  position: relative;
  top: 5px;
  left: 8px;
  width: 50%;
  height: 50%;
  opacity: 1;
  border-radius: 50%;
  border: 3px solid #6078EA;
  transition: opacity 0.25s ease, transform 0.43s cubic-bezier(0.694,  0.048, 0.335, 1.000);
}

.icon-search:after {
  content: "";
  position: absolute;
  bottom: -9px;
  right: -2px;
  width: 4px;
  border-radius: 3px;
  transform: rotate(-45deg);
  height: 10px;
  background-color: #c7d0f8;
}
</style>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/resources/css/home.css">
		<%@ include file="/WEB-INF/views/common/ownerHeader.jsp"%>
	</head>
	<body>
		<div class="all">
			<div class="side">
				<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>
			</div>
			<div class="content">
				<div class="owner_title">메뉴관리</div>
				<div>
					<fieldset id="searchBar">
						<input id="search" onkeypress="if(event.keyCode==13){getMenuContainer();}"
							type="text" placeholder="카테고리 또는 메뉴를 검색해보세요.">
						<button onclick="getMenuContainer()">
							<div class="icon-container">
								<div class="icon-search"></div>
							</div>
						</button>
					</fieldset>
				</div>
				<div id="menu_all_container">

				</div>
			</div>
		</div>
		<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>

	</body>
	<script>
		window.onload = getMenuContainer;
		
		function getMenuContainer(){
			var keyword = document.querySelector("#search").value;
			console.log("ajax keyword",keyword);
			$.ajax({
				url:"${pageContext.request.contextPath}/menuContainer.do",
				data:{'keyword':keyword},
				success: function(responseData){
					$("#menu_all_container").html(responseData);
				},
				error: function(){
					console.log("ajax 실패");
					console.log("error");
				}
			})
		}
		</script>

</html>
