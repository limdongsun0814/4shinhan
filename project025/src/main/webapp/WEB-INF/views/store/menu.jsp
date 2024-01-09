<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/menulist.css">


<!-- 검색바/카테고리/정렬 -->
<div class="search_area">
	<!-- 검색바 -->
	<div class="search_bar">
		<fieldset class="field-container">
		  <input type="text" placeholder="상품 이름을 검색해보세요." class="field" id="search_input" onkeypress="if(event.keyCode==13) {search_menu();}" />
		  <button class="btn btn-primary" id="button-search" type="button" onclick="search_menu()">
		  	<div class="icons-container">
			    <div class="icon-search"></div>
			    <div class="icon-close">
			      <div class="x-up"></div>
			      <div class="x-down"></div>
			    </div>
		  	</div>
		  </button>
		</fieldset>
	</div>
	<div class="dropdown">
		<!-- 빵 카테고리 선택 드롭다운 -->
		<div class="category_dropdown">
			<select class="dropdown" id="category_dropdown" onchange="get_menu_list()">
				<option value="0" selected>전체</option>
				<option value="10">시그니처</option>
				<c:forEach items="${menu_category_list}" var="menucate" varStatus="status">
					<option value="${menucate.menu_category_seq}">${menucate.menu_category_name}</option>
				</c:forEach>
				
				<!-- <option value="2">식빵</option>
				<option value="3">건강빵</option>
				<option value="4">간식빵</option>
				<option value="5">파이/패스트리</option>
				<option value="6">도넛/고로케</option>
				<option value="7">케이크</option>
				<option value="1">음료</option> -->
			</select>
		</div>
		<!-- 정렬 기준 선택 드롭다운 -->
		<div class="sorting_dropdown">
			<select class="dropdown" id="sorting_dropdown" onchange="get_menu_list()">
				<option value="latest" selected>신상품순</i></option>
				<option value="popular">인기순</option>
				<option value="priceasc">가격 낮은 순</option>
				<option value="pricedesc">가격 높은 순</option>
			</select>
		</div>
	</div>
</div>
<!-- 메뉴 목록 -->
<div class="menu_list_container" id="menu_list"></div>

<script>

$(function(){
	get_menu_list();

	$('.field').on('focus', function() {
		$('body').addClass('is-focus');
	});
	
	$('.field').on('blur', function() {
		$('body').removeClass('is-focus is-type');
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
	
	document.getElementById('search_input').value = '';
}

function search_menu() {
    let keyword = document.getElementById('search_input').value.trim();
    $.ajax({
		url: "${cpath}/store/searchMenu.do?keyword="+keyword+"&page=1&per_page_num=9&store_id=${store_id}",
		success:function(responseData){
			$("#menu_list").html(responseData);
		},
		error:function(){
			console.log("ajax 오류-menu.jsp-search");
		}
	});
};

</script>
		  