<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review | 빵이오4</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/storeNotice.css">

<%@ include file="/WEB-INF/views/common/ownerHeader.jsp"%>
</head>
<style>
.reviewLine {
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: space-between;
}

.content {
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0px 0px 15px 0px rgba(0, 0, 0, 0.1); /* 그림자 효과를 적용합니다 */
	/* background-color: #FEF4CF; */
	width: 100%;
	margin: 0 auto; /* 중앙 정렬 */
}

.item-container {
	border: 2px solid #FFBBBB; /* 테두리 색상을 지정합니다 */
	border-radius: 20px; /* 둥근 테두리를 만듭니다 */
	box-shadow: 0px 0px 15px 0px rgba(0, 0, 0, 0.1); /* 그림자 효과를 적용합니다 */
	padding: 20px; /* 내부 패딩을 추가합니다 */
	margin-left: auto;
	margin-bottom: 20px; /* 아이템 간 간격을 만듭니다 */
	background-color: #ffffff; /* 배경색을 지정합니다 */
	width: 90%; /* item-container의 크기를 절반으로 줄임 */
	margin: 0 auto; /* 중앙 정렬 */
}

.bottom-content {
	display: flex;
	flex-direction: column;
	width: 70%;
	margin: 0 auto; /* 중앙 정렬 */
	border-radius: 20px;
	border: 2px solid #FF6464;
	padding: 20px;
	margin-top: 30px; /* 각각의 리뷰 목록 사이에 간격을 추가 */
	margin-bottom: 30px; /* 각각의 리뷰 목록 사이에 간격을 추가 */
}

.content>h1 {
	display: inline-block; /* 수평 배치를 위해 인라인 블록으로 변경 */
}

.outdoorbutton {
	position: relative; /* 상대 위치 지정 */
	top: 10px; /* 위로부터 10px 위치 */
	margin-left: auto; /* 왼쪽 마진을 자동으로 설정 */
	margin-right: 40px; /* 오른쪽 마진 추가 */
	display: inline-block; /* 수평 배치를 위해 인라인 블록으로 변경 */
	padding: 10px;
	border: none;
	border-radius: 5px;
	background-color: #FF6464;
	color: #ffffff;
	cursor: pointer;
	text-align: center;
	width: 18%; /* 버튼 크기를 20%로 줄임 */
}

.rightAlign {
	text-align: right;
}

h1 {
	color: #FF6464;
	text-align: center;
	margin-bottom: 20px;
}

span {
	display: block;
	margin-bottom: 10px;
}

.close {
	margin: 0 auto;
	width: 70%;
}

.indoorbutton {
	display: block;
	margin: 0 auto;
	padding: 10px;
	border: none;
	border-radius: 5px;
	background-color: #FF6464;
	color: #ffffff;
	cursor: pointer;
	text-align: center;
	width: 30%; /* 버튼 크기를 20%로 줄임 */
}

button {
	background-color: #FF6464; /* 버튼 배경색 */
	border: none; /* 테두리 제거 */
	color: white; /* 글씨 색 */
	padding: 15px 32px; /* 패딩 */
	text-align: center; /* 텍스트 정렬 */
	text-decoration: none; /* 텍스트 장식 제거 */
	display: inline-block;
	font-size: 16px; /* 글씨 크기 */
	margin: 4px 2px; /* 마진 */
	cursor: pointer; /* 마우스 커서 모양 */
	border-radius: 4px; /* 테두리 둥글게 */
	transition-duration: 0.4s; /* 효과 지속시간 */
}

button:hover {
	background-color: #FFEC9F;
}

.reviewContent {
	padding: 10px;
	background-color: #FFEC9F;
	border-radius: 5px;
	margin-bottom: 20px;
}

.ownerReviewContent {
	padding: 10px;
	background-color: #FFEC9F;
	border-radius: 5px;
}

form {
	margin-top: 20px;
}

.imagereview {
	display: flex; /* Flexbox를 사용 */
}

.image, .review {
	flex: 1; /* 두 요소가 동일한 너비를 가지도록 */
	padding: 10px; /* 패딩 추가 */
}

.boldText {
    font-weight: bold;
}

</style>
<body>
	<div class="all">
		<div class="side">
			<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>
		</div>
		<div class="content">
			</br> </br>
			<h1>리뷰 목록</h1>


			<div class="close">

				<c:forEach items="${myReviewList}" var="myReview">
					<div class="bottom-content">
						<div class="reviewLine">
							<span class="myReviewPaymentSeq" name="${myReview.payment_seq}"><strong>주문번호</strong>
								${myReview.payment_seq}</span> <span><strong>${myReview.menu_name}</strong>
								포함 ${myReview.total_payment_product_count}개</span> <span
								class="reviewScoreNumber"
								name="myReview.member_review_score_number"><strong>별점</strong>${myReview.member_review_score_number}</span>
							<span class="reviewRecommend"
								name="myReview.member_review_recommend">추천할것인지유무${myReview.member_review_recommend}</span>
						</div>
						</br>

						<div class="imagereview">
							<div class="image">
								<span class="reviewImg" name="myReview.member_review_img_path"><img src="${myReview.member_review_img_path}" width="300px"> </span>
								</br>
							</div>

							<div class="review">
								<span class="reviewContent"
									name="myReview.member_review_content"><strong>고객님리뷰</strong></br>
									</br> ${myReview.member_review_content} </span> </br>

								<c:choose>
									<c:when test="${empty myReview.owner_review_content}">
										<form action="addOwnerReview.do" method="post">
											<input type="hidden" name="payment_seq"
												value="${myReview.payment_seq}" />
												<input type="hidden" name="owner_review_date "
												value="${myReview.owner_review_date }" />
											<textarea name="ownerReviewContent" required></textarea>
											<button type="submit">댓글 작성</button>
										</form>
									</c:when>
									<c:otherwise>
										<span class="ownerReviewContent"><strong>사장님
												댓글</strong></br> </br> ${myReview.owner_review_content} </span>
									</c:otherwise>
								</c:choose>
								</br>

							</div>
						</div>


						<span class="paymentDate rightAlign" name="myReview.payment_date"><strong>결제일</strong>
							${myReview.payment_date}</span> </br> 
						<span class="reviewDate rightAlign" name="myReview.member_review_date"><strong>리뷰일</strong>
							${myReview.member_review_date}</span>

					</div>
				</c:forEach>
			</div>



		</div>



	</div>
	<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
</body>
<script>
    // 리뷰 별점 엘리먼트를 모두 선택합니다.
    let reviewScoreNumbers = document.querySelectorAll('.reviewScoreNumber');

    reviewScoreNumbers.forEach((reviewScoreNumber) => {
        // 각 리뷰 별점 엘리먼트의 별점 값을 가져옵니다.
        let score = reviewScoreNumber.textContent.replace('별점', '');

        // 별점 값을 숫자형으로 변환합니다.
        let scoreNumber = parseInt(score);

        // 별점 문자열을 초기화합니다.
        let stars = '';

        // 별점 값을 기반으로 별을 생성합니다.
        for(let i = 0; i < scoreNumber; i++) {
            stars += '★';
        }

        // 남은 별점을 빈 별로 채웁니다.
        for(let i = 0; i < (5 - scoreNumber); i++) {
            stars += '☆';
        }

        // 별점 엘리먼트의 텍스트를 업데이트합니다.
        reviewScoreNumber.textContent = '별점 ' + stars;
        
       // 별점 엘리먼트에 boldText 클래스를 추가합니다.
        reviewScoreNumber.classList.add('boldText');
    });
</script>
<script>
    // 추천 여부 엘리먼트를 모두 선택합니다.
    let reviewRecommends = document.querySelectorAll('.reviewRecommend');

    reviewRecommends.forEach((reviewRecommend) => {
        // 각 추천 여부 엘리먼트의 추천 값을 가져옵니다.
        let recommend = reviewRecommend.textContent.replace('추천할것인지유무', '');

        // 추천 값이 'true'인 경우 따봉을 표시합니다.
        if (recommend === 'true') {
            reviewRecommend.textContent = '👍';
        } else {
            // 추천 값이 'false'인 경우 아무것도 표시하지 않습니다.
            reviewRecommend.textContent = '';
        }
    });
</script>
</html>