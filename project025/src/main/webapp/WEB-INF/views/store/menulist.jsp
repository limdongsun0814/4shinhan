<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/menulist.css">

<div class="menu_list_area" id="grid">
	<c:forEach items="${menuList}" var="menu" varStatus="status">
		<div class="menu_item_area">
			<a href="${cpath}/store/getMenuDetail.do?menu_id=${menu.menu_id}" class="menu_item">
				<div>
					<img class="menu_item_img" src="${menu.menu_thumb_image_path==null?'https://drive.google.com/uc?id=14Top-Dg-8l4S0J3PyvXsawOYHfMhACw4':menu.menu_thumb_image_path}" alt="메뉴 사진"></img>
				</div>
				<c:if test="${menu.menu_is_signature}">
					<div class="menu_signature">
						<i class="fa-solid fa-s" style="color: #FFDF57;"></i>
						<!-- <i class="fa-solid fa-star-of-life" style="color: #FFEC9F"></i> -->
						<!-- <i class="fa-solid fa-face-laugh-squint" style="color: #FFEC9F"></i> -->
					</div>
				</c:if>
				<c:if test="${menu.menu_count<=0}">
					<div class="menu_soldout">
						일시품절!!
					</div>
				</c:if>
				<!-- <div>${menu }</div> -->
				<div class="menu_item_info">
					<div class="menu_name">${menu.menu_name}</div>
					<div class="menu_info_right">
						<div class="menu_price">
							<div id="discount">
								<fmt:formatNumber value="${(menu.menu_discount_price div menu.menu_price)*100}" pattern="##"/>%&nbsp;
							</div>
							<div>
								<fmt:formatNumber pattern="###,###,###" value="${menu.menu_price-menu.menu_discount_price}"/>
							</div>
						</div>
						<div style="color: darkgray; font-size: 15px;">재고(${menu.menu_count})</div>
					</div>
				</div>
			</a>
			<button type="button" class="big_add_to_cart" onclick="go_cart_function(${menu.menu_id})"> cart <i class="fa-solid fa-cart-shopping"></i></button>
		</div>
	</c:forEach>
</div>
<div class="pagination">
    <c:if test="${pageMaker.prev}">
    	<a href="javascript:movePage('${pageMaker.makeQuery(pageMaker.start_page - 1)}')"><i class="fa fa-angle-left"></i></a>
    </c:if>
    <c:forEach begin="${pageMaker.start_page}" end="${pageMaker.end_page}" var="idx">
    	<c:if test="${pageMaker.cri.getPage()==idx}">
    		<a class="num active" id="num${idx}" href="javascript:movePage('${pageMaker.makeQuery(idx)}')">${idx}</a>
    	</c:if>
    	<c:if test="${pageMaker.cri.getPage()!=idx}">
    		<a class="num" id="num${idx}" href="javascript:movePage('${pageMaker.makeQuery(idx)}')">${idx}</a>
    	</c:if>
 	</c:forEach>

    <c:if test="${pageMaker.next && pageMaker.end_page > 0}">
    	<a href="javascript:movePage('${pageMaker.makeQuery(pageMaker.end_page + 1)}')"><i class="fa fa-angle-right"></i></a>
    </c:if>
</div>
	
<script>
$(function(){
	
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
//href="${cpath}/store/getMenuList.do${pageMaker.makeQuery(pageMaker.end_page + 1)}

function movePage(cri){
	console.log("페이지 이동"+cri);
	
	$(".num .active").removeClass("active");
	//$("#num"+idx).addClass("active");

	
	if (document.getElementById('search_input').value!=''){	// 검색
	    let keyword = document.getElementById('search_input').value.trim();
	    $.ajax({
			url: "${cpath}/store/searchMenu.do?"+cri+"&keyword="+keyword,
			success:function(responseData){
				$("#menu_list").html(responseData);
			},
			error:function(){
				console.log("ajax 오류-menu.jsp-search");
			}
		});
	} else {	// 검색X
		$.ajax({
			url: "${cpath}/store/getMenuList.do"+cri,
			success:function(responseData){
				$("#menu_list").html(responseData);
			},
			error:function(){
				console.log("ajax 오류");
			}
		});
		
		document.getElementById('search_input').value = '';
	}
};
function go_cart_function(menu_id){
    var menu_obj = {"cart_product_menu_id":menu_id};
    $.ajax({
        type:"POST",
        url:"${cpath}/CartInsertOne.do",
        data:menu_obj,//JSON.stringify(id_object),
        //contentType: "application/json; charset=utf-8;",
        success:function(res){
        	if(res.login_check){
        		alert(res.result);
        		location.reload();
        	}else{
        		alert(res.result);
        		 location.href='${cpath}/memberlogin.do';
        	}
        },
        error:function(){
            alert('ajex 실패');
        }
    });
}
</script>