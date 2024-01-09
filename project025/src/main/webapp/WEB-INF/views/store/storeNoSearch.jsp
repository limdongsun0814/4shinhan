<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c9ae8a414e60beaf76f05c1954ec86eb&libraries=services,clusterer,drawing"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Home | 빵이오</title>
<style>
.noSearch{
	width:100%;
	height:750px;	
	display:flex;
	justify-content:center;
	align-items:center;
}

.noSearch > div {
	display:flex;
	flex-direction:column;
	align-items:center;
}

.noSearch h1 {
	font-size:1.5rem;
}

.noSearch img{
	width:3.5rem;
}

.noSearch span {
	font-size:1.5rem;
	color: green;
}
</style>

<!-- 헤더 -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/storelist.css"> --%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/Searchstorelist.css">
<%@ include file="/WEB-INF/views/cart/miniCart.jsp" %>
</head>

<body>
	<br><br>
	<!-- 이벤트 -->
	<%-- <div class="event">
		<a href="">
			<img src="${pageContext.request.contextPath}/resources/images/left.png" alt="이전 이벤트">
		</a>
		<a href="">
			<img src="${pageContext.request.contextPath}/resources/images/event.png" alt="이벤트">
		</a>
		<a href="">
			<img src="${pageContext.request.contextPath}/resources/images/right.png" alt="이후 이벤트">
		</a>
	</div> --%>
	<div class="menu_list_area" id="grid">
		<div class="storelist">
		<div class="noSearch"> 
			<div>
				<img src="../resources/images/question-outline.svg"/>
				<h1>검색어 <span>'${store_search_name}'</span>에 대해 검색된 가게가 없습니다.</h1>
				<h1>검색어를 다시 한 번 확인해보세요.</h1>
			</div>
		</div>
		
		<%-- <c:forEach items="${storeMap}" var="storeList" varStatus="status">
			<div id="page_${storeList.key}" class="page_class">
				<c:forEach items="${storeList.value}" var="store" varStatus="storeStatus">
					${storeStatus.index%2==0?"<div class='storeList'>":""}
						<a href="${pageContext.request.contextPath}/store/getStoreDetail.do/${store.store_id}">
							<div style="margin: 10px;">${pageContext.request.contextPath}  ${pageContext.request.contextPath}/resources/store/${store.store_img_thumbnail_path!=null?store.store_img_thumbnail_path:'notStoreImg.png'}
								<img class="store_img" src="${store.store_img_thumbnail_path!=null?store.store_img_thumbnail_path:'../resources/images/notStoreImg.png'}">
								<div style="font-size: 20px;">
									${store.store_name} <img src="${pageContext.request.contextPath}/resources/images/Star.png" width="20px"> ${store.avg_score}  
									<img src="${pageContext.request.contextPath}/resources/images/heart.png" width="20px"> ${store.heart_count} 
									<img src="${pageContext.request.contextPath}/resources/images/review_icon.png" width="20px"> ${store.review_count}
								</div>
								${store}
							</div>
						</a>
					 ${storeStatus.index%2==1?"</div>":""}
				</c:forEach>
				${fn:length(storeList.value)%2==1?"</div>":""}
			</div>	
		</c:forEach> --%>
		</div>
	</div>

	<%-- <div class="pagination">
	    <c:forEach items="${page}" var="page_index">
	    	<a class="page_index" id="page_index_${page_index}" onclick="movePage(event)">${page_index}</a>
	    </c:forEach>
	</div> --%>

	<script>
		/* var index = 1;
		viewPage(index);
		function movePage(event) {
			console.log(event.target);
			var str_id = event.target.id;
			index = str_id.split("_")[2];
			viewPage(index);
		}
		function viewPage(page_index){
			var page_document = document.getElementsByClassName("page_class");
			for(let i=0;i<page_document.length;i++){
				page_document[i].style.display="none";
			}
			document.getElementById('page_'+page_index).style.display="flex";
		} */
	</script>
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</html>
