<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice | 빵이오4</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/storeNotice.css">
<%@ include file="/WEB-INF/views/common/ownerHeader.jsp"%>
</head>
<style>
.content {
	padding: 20px;
	box-shadow: 0px 0px 15px 0px rgba(0, 0, 0, 0.1); /* 그림자 효과를 적용합니다 */
	/* background-color: #FEF4CF; */
	width: 100%;
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

h1 {
	color: #FF6464;
	text-align: center;
	margin-bottom: 20px;
}

span {
	display: block;
	margin-bottom: 10px;
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
	width: 25%; /* 버튼 크기를 20%로 줄임 */
}

.deletebutton {
	text-align: center;
	display: block;
	margin: 0 auto 0 81%;
	padding: 10px;
	border: none;
	border-radius: 5px;
	background-color: #FF6464;
	color: #ffffff;
	cursor: pointer;
	width: 20%; /* 버튼 크기를 20%로 줄임 */
}

button:hover {
	background-color: #FFEC9F;
}
</style>
<script>
function deleteConfirm(event, element, seq) {
	event.preventDefault();
    var result = confirm("공지사항 " + seq + "번을 삭제하시겠습니까?");
    if (result) {
        var form = element.closest("form");
        form.submit();
    } else {
        alert("삭제가 취소되었습니다.");
    }
}
</script>
<body>
	<div class="all">
		<div class="side">
			<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>
		</div>

		<div class="content">
			<div>
				<h1>공지사항</h1>
			</div>

			</br>

			<div class="bottom-content">
				<button class="outdoorbutton"
					onclick="location.href='storeNoticeInsert.do'">공지사항 신규 등록</button>
				</br> </br> </br>
				<c:forEach items="${storeNoticeList}" var="storeNotice">
					<div class="item-container">
						<form action="storeNoticeDelete.do" method="post">
							<input type="hidden" name="store_notice_seq"
								value="${storeNotice.store_notice_seq}" />
							<!-- 삭제할 공지사항의 시퀀스 값을 여기에 입력해주세요 -->
							<button class="deletebutton"
								onclick="deleteConfirm(event, this, ${storeNotice.store_notice_seq})">공지사항
								삭제</button>
						</form>
						<span>공지사항 번호 : ${storeNotice.store_notice_seq}</span><span
							style="display: none;">store_notice_store_id:
							${storeNotice.store_notice_store_id}</span></br> <span>공지사항 제목 :
							${storeNotice.store_notice_title}</span></br> <span>공지사항 내용 : <br></span>
							<div style="display: flex; flex-direction: row;">
								<span style="line-height: 25px;">
								${storeNotice.store_notice_content}
								</span>
								<span style="display: none;">이미지
								파일 : ${storeNotice.store_notice_img_path}</span></br> 
								<div id="store_notice_img_path">
									<img src="${storeNotice.store_notice_img_path}" width="200px" height="200px" style="margin-left: 20px;" id="upload_img">						
								</div>
							</div>
							
							<span style="margin-top: 20px;">공지 날짜 : ${storeNotice.store_notice_date}</span></br> <span>공지사항 조회수 :
							${storeNotice.store_notice_view_count}</span>
						<button class="indoorbutton"
							onclick="location.href='storeNoticeSelect.do?store_notice_seq=${storeNotice.store_notice_seq}'">공지사항
							수정</button>



					</div>
					</br>
					</br>
				</c:forEach>
			</div>
		</div>
	</div>
</body>

<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
</html>