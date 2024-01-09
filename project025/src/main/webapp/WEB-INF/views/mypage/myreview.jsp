<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/storereview.css">
<script src="https://kit.fontawesome.com/f719d238b7.js" crossorigin="anonymous"></script>
<c:set var="total" value="${fn:length(reviewList)}" />

<div class="head">${member.member_name}님이
	작성하신 리뷰는 <span class="total_review"></span>입니다.
</div>

<div class="boxing">
	<c:forEach items="${reviewList}" var="review" varStatus="loop">
	<div class="one_review">
	
		<div class="top">
			<p>주문번호 : ${review.payment_seq}</p>
			<div class="images">
				<c:if test="${review.member_review_recommend}">
	                <i class="fa-solid fa-thumbs-up"></i>
	            </c:if>
				<p><i class="fa-solid fa-star"></i> ${review.member_review_score_number}</p>
			</div>
		</div>
		<div class="review">
			<div class="left_content">
				<div id="image_area"></div>
				<img class="image" alt="리뷰사진" src="${review.member_review_img_path}">
				<button class="delete" onclick="deleteReview(${review.payment_seq})">리뷰 삭제</button>
			</div>

			<div class="right_content">
				<div class="pay_date">주문일: ${review.member_pay_date}</div>
				<div class="write_date">리뷰 작성일:${review.member_review_date}</div>
				<div class="review_content">
					<div class="review_title">리뷰 제목 - ${review.member_review_title}</div>
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
</div>

<script>

	function aa() {
		var total_review = <c:out value="${total}" />
		$('.total_review').text("총 " + total_review + "개");
	}
	// 페이지 로드 시 자동으로 함수 호출
	aa();

	function deleteReview(e){
		$.ajax({
			url: "deleteReview.do?payment_id="+ e,
			success: function(responseData){
				console.log(responseData);
				confirm("리뷰를 삭제하시겠습니까?");
				$("#here").html(responseData);
				
			}
		});
		 //var payment_id = "${payment_id}";
	}
	
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