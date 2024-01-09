<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://kit.fontawesome.com/f719d238b7.js" crossorigin="anonymous"></script>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/storereview.css">

<div class="storeReview_top">가게 리뷰</div>

<div class="boxing">
	<c:if test="${empty reviewList}">
		<div class="no_review">
			<div>아직 리뷰가 없습니다.</div>
			<div>첫 리뷰의 주인공이 되어보세요!</div>
		</div>
	</c:if>
	<c:if test="${not empty reviewList}">
		<c:forEach items="${reviewList}" var="review" varStatus="loop">
			<div class="one_review">
			
				<div class="top">
					<p>"${review.member_review_member_nickname}"님의 리뷰 - ${review.member_review_title}</p>
					
					<div class="images">
						<c:if test="${review.member_review_recommend}">
			                <i class="fa-solid fa-thumbs-up"></i>
			            </c:if>
						<p class="absolute_position"><i class="fa-solid fa-star"></i> ${review.member_review_score_number==null?'0.0':review.member_review_score_number}</p>
					</div>
					
				</div>
				<div class="review">
					<div>
						<img class="left_content" src="${review.member_review_img_path}" alt="리뷰 이미지"/>
					</div>
		
					<div class="right_content">
						<div class="pay_date">주문일: ${review.member_pay_date}</div>
						<div class="write_date">리뷰 작성일: ${review.member_review_date}</div>
						<div class="review_content">
							<div class="content">리뷰 내용 - ${review.member_review_content}</div>
						</div>
						<div class="owner_review_content">
							<a class="text" href="javascript:doDisplay(${loop.index});">사장님 답글 보기▼</a>
				            <div class="owner_content" id="owner_content_${loop.index}" style="display: none;">${review.owner_review_content}</div>
				        </div>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:if>
</div>

<script>
    function doDisplay(index) {
        var ownerContent = document.getElementById('owner_content_' + index);
        // 현재 상태에 따라 토글링
        if (ownerContent.style.display === 'none') {
            ownerContent.style.display = 'block'; // 보이도록 변경
        } else {
            ownerContent.style.display = 'none'; // 감추도록 변경
        }
    }
</script>
