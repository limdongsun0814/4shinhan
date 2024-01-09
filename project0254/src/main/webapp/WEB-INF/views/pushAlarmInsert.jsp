<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<meta charset="UTF-8">
<title>Alarm | 빵이오4</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
.templateBox {
    display: inline-block;
    border: 1px solid #ccc;
    padding: 10px;
    margin: 10px;
    width: 200px; /* 원하는 크기로 조절하세요 */
    border-radius: 15px; /* 테두리를 부드럽게 만듭니다 */
    background-color: #FFFAE6; /* 좀 더 연한 개나리색으로 변경 */
}

.templateBox label {
	display: block;
	width: 100%;
	height: 100%;
}

.templateBox input[type="radio"] {
	display: none;
}

.templateBox span {
	display: block;
	padding: 10px;
}

.previewBox {
	border: 1px solid #ccc;
	padding: 10px;
	margin-top: 10px;
}

.previewContainer {
	display: flex;
	justify-content: space-between;
}

.previewBox {
	display: none;
	border: 1px solid black;
	padding: 10px;
	margin: 10px 0;
	width: 45%; /* Adjust as needed */
	background-color: #FFDAB9; /* Peach color for a fresh look */
}

.previewBox:hover {
	background-color: #FFB347;
	/* Slightly darker peach color when mouse hovers */
}

push_alarm_category_id {
	width: 200px;
	padding: 10px;
	border: 1px solid #8B4513;
	border-radius: 4px;
	background-color: #FFDAB9;
	color: #8B4513;
	font-size: 16px;
	margin-bottom: 20px;
	-webkit-appearance: menulist; /* 화살표 다시 보이게 하기 (크롬, 사파리) */
	-moz-appearance: menulist; /* 화살표 다시 보이게 하기 (파이어폭스) */
	appearance: menulist; /* 화살표 다시 보이게 하기 (기타 브라우저) */
}

select::-ms-expand {
	color: #8B4513; /* 화살표 색상 변경 (IE) */
}

@font-face {
	font-family: 'SeoulNamsanM';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/SeoulNamsanM.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
	font-display: swap;
}

.radioset {
	display: flex;
	justify-content: space-between; /* 버튼 간의 간격을 최대한 넓게 설정 */
	width: 80%; /* .radioset의 너비를 설정. 이 값은 화면 크기에 따라 조정이 필요할 수 있습니다. */
	margin: 0 auto; /* .radioset을 화면 중앙에 배치 */
}

.radio-option input[type="radio"] {
	display: none; /* 기존 라디오 버튼을 숨김 */
}

.radio-option label {
	padding: 10px; /* 라벨 내부 여백 설정 */
	background-color: #f0f0f0; /* 배경색 설정 */
	border: 1px solid #ccc; /* 테두리 설정 */
	border-radius: 10px; /* 테두리를 조금 둥글게 설정 */
	width: 60px; /* 라벨의 너비 설정 */
	height: 30px; /* 라벨의 높이 설정 */
	line-height: 10px; /* 텍스트를 라벨의 중앙에 위치시키기 위해 조정한 값 */
	text-align: center; /* 텍스트를 라벨의 중앙에 위치시키기 위해 설정 */
	display: inline-block;
	position: relative;
	box-sizing: border-box; /* 패딩이 라벨의 크기에 포함되도록 설정 */
}

.radio-option input[type="radio"]:checked+label {
	background-color: #FF6464; /* 체크된 라디오 버튼의 배경색 변경 */
	color: white; /* 체크된 라디오 버튼의 텍스트 색상 변경 */
}

input[type="text"] {
	border: none; /* 테두리 제거 */
}

* {
	font-family: 'SeoulNamsanM', sans-serif;
}

.radio-option {
	display: inline-block; /* 라디오 버튼 옵션을 한 줄에 표시 */
	text-align: center; /* 텍스트를 중앙에 위치 */
	margin-right: 30px;
}

input[type="radio"] {
	border: 1px solid #FF6464; /* 테두리 스타일 */
	border-radius: 0; /* 네모 모양 */
	width: 20px; /* 너비 */
	margin: auto;
	/* height: 20px;  높이 <<<<<<<<<<<<<<얘가 범인*/
}

.keunteduri {
	border: 1px solid #FF6464; /* 테두리 스타일 */
	border-radius: 30px; /* 네모 모양 */
	width: auto; /* 너비 */
	padding: 20px; /* 테두리와 내용 사이의 간격 설정 */
}

.title-container input[type="text"] {
	flex-grow: 1;
	margin-left: 10px;
}

.category-container {
	display: flex; /* 플렉스박스 레이아웃 */
	justify-content: space-between; /* 요소 사이에 공간 분배 */
	border: 1px solid #FF6464; /* 테두리 스타일 */
	padding: 10px; /* 안쪽 여백 */
	margin: auto;
	max-width: 600px; /* 최대 너비 설정 */
	border-radius: 10px;
}

.title-container {
	display: flex;
	align-items: center;
	justify-content: flex-start; /* 좌측정렬 */
	border: 1px solid #FF6464;
	padding: 10px;
	margin-top: 10px;
	margin-left: 0; /* 좌측으로 정렬 */
	max-width: 600px; /* 최대 너비 설정 */
	border-radius: 10px;
}

.contentteduri {
	margin: auto;
	max-width: 600px; /* 최대 너비 설정 */
	border-radius: 10px;
	/* color: #FF6464; */
}

textarea[name="push_alarm_content"] {
	width: 100%; /* 전체 너비 */
	border: 1px solid #FF6464; /* 테두리 스타일 */
	border-radius: 10px;
}

.indoorbutton {
	display: flex;
	justify-content: center;
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

button:hover {
	background-color: #FFEC9F;
}

.full {
	display: flex;
}

.content {
	/* border: 1px solid #FF6464; 
	border-radius: 10px; 
	padding: 10px; 
	width: 70%; 
	margin: 0 auto; */
	display: flex;
	justify-content: center;
	flex-direction: column;
	align-items: center;
}

.insert {
	float: left;
	padding: 15px;
	justify-content: center;
}

h1 {
	text-align: center;
	font-family: 'SeoulNamsanM';
	color: #FF6464;
}
</style>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<%@ include file="/WEB-INF/views/common/ownerHeader.jsp"%>
</head>
<body>

	<form method="POST" action="pushAlarmInsert.do">
		<div class="all">
			<div class="side">
				<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>
			</div>
			<input type="hidden" name=menu_id> <input type="hidden"
				name=push_alarm_store_id value="${sessionScope.owner_store_id }">

			<div class="content">
				<div class="keunteduri">
					<h1>따뜻한 빵 알림보내기</h1>
					</br> </br>

					<!-- 					<div class="radioset">
						<div class="radio-option">
							<input type="radio" name="push_alarm_to_target_id" value="전체"
								id="radio1"> <label for="radio1">전체</label>
						</div>
						<div class="radio-option"> -->
					<input type="hidden" name="push_alarm_to_target_id" value="찜"
						id="radio2">
					<!--				<label for="radio2">찜</label>
 						</div>
						<div class="radio-option">
							<input type="radio" name="push_alarm_to_target_id" value="구독"
								id="radio3"> <label for="radio3">구독</label>
						</div>
					</div>
					</br>  -->
					</br>


					<div class="full">
						<div class="insert">

							<div>
								<!-- <span>카테고리</span>  -->
								<select name="push_alarm_category_id" class="push_alarm_category_id" hidden>

									<c:forEach items="${push_alarm_category_id}" var="category">
										<option value='${category.push_alarm_category_id}'>
											${category.push_alarm_category_name}</option>
									</c:forEach>
								</select>
							</div>
							</br>
							<!-- <select id="templateSelectTitle">
								<option value="">직접 입력</option>
								<option value="template1">갓구운 빵 나왔어요!</option>
								<option value="template2">한정수량!</option>
							</select> -->
							<div class="templateBox">
								<label> <input type="radio" name="templateSelect"
									value="직접입력"> <span>직접입력</span>
								</label>
							</div>
							<div class="templateBox">
								<label> <input type="radio" name="templateSelect"
									value="template1"> <span>갓 구운 빵 나왔어요!</span>
								</label>
							</div>
							<div class="templateBox">
								<label> <input type="radio" name="templateSelect"
									value="template2"> <span>한정수량!</span>
								</label>
							</div>
							<div class="title-container">
								<span>제목</span> <input type="text" id="contentInputTitle"
									name="push_alarm_title" />
							</div>

							</br>
							<!-- <select id="templateSelectContent">
								<option value="직접입력">직접 입력</option>
								<option value="template1">템플릿 1</option>
								<option value="template2">템플릿 2</option>
							</select> -->
							<div class="templateBox">
								<label> <input type="radio" name="templateRadio"
									value="직접입력"> <span>직접입력</span>
								</label>
							</div>
							<div class="templateBox">
								<label> <input type="radio" name="templateRadio"
									value="template1"> <span>빵 알림1</span>
								</label>
							</div>
							<div class="templateBox">
								<label> <input type="radio" name="templateRadio"
									value="template2"> <span>빵 알림2</span>
								</label>
							</div>

							<textarea id="contentInput" name="push_alarm_content" cols="70"
								rows="10"></textarea>

							<br> <span>현재 시간</span> <span id="datetime"
								name="push_alarm_datetime"></span> <br />

						</div>

					</div>
					</br>
					<div class="w3-container w3-center">
						<button class="indoorbutton" type="submit">알림전송</button>
					</div>
				</div>
			</div>

		</div>
	</form>



</body>


<script>
	$(document).ready(function() {
		$('input[name="templateSelect"]').click(function() {
			var selectedTemplate = $(this).val();
			if (selectedTemplate === "template1") {
				$("#contentInputTitle").val("갓 구운 빵 나왔어요!");
			} else if (selectedTemplate === "template2") {
				$("#contentInputTitle").val("한정수량!");
			} else {
				$("#contentInputTitle").val("");
			}
		});
	});
</script>


<script>
	$(document).ready(function() {
		// 라디오 버튼 변경 이벤트 처리
		$('input[name="templateRadio"]').change(function() {
			var selectedTemplate = $(this).val();
			if (selectedTemplate === "template1") {
				$("#contentInput").val("#따끈따끈\n우리 가게의 빵이 방금 탄생했어요\n따끈따끈한 향기와 함께 맛도 최고! \n사장님이 직접 구운 빵, 놓치지 마세요\n지금 바로 매장으로 오세요!");
			} else if (selectedTemplate === "template2") {
				$("#contentInput").val("#빵 구워졌어요\n우리 가게의 빵이 방금 구워졌습니다\n향긋한 빵이 오늘의 행복을 선사할 거예요\n빵의 온기와 함께 사랑도 전달됩니다\n지금 바로 우리 가게로 오세요!");
			} else {
				$("#contentInput").val("");
			}
		});

		// select 태그 변경 이벤트 처리 (옵션 선택 시 textarea 값 변경)
		$("#templateSelectContent").change(function() {
			var selectedTemplate = $(this).val();
			if (selectedTemplate === "template1") {
				$("#contentInput").val("템플릿 1의 내용");
			} else if (selectedTemplate === "template2") {
				$("#contentInput").val("템플릿 2의 내용");
			} else {
				$("#contentInput").val("");
			}
		});

		// 페이지 로드 시 초기 템플릿 내용 설정
		var selectedTemplate = $('input[name="templateRadio"]:checked').val();
		if (selectedTemplate === "template1") {
			$("#contentInput").val("템플릿 1의 내용");
		} else if (selectedTemplate === "template2") {
			$("#contentInput").val("템플릿 2의 내용");
		} else {
			$("#contentInput").val("");
		}
	});
</script>

<script>
	window.onload = realTimeClock;
	function realTimeClock() {
		var now = new Date();
		var year = now.getFullYear();
		var month = now.getMonth() + 1; // getMonth()는 0부터 시작하므로 1을 더해줍니다.
		var day = now.getDate();
		var hours = now.getHours();
		var minutes = now.getMinutes();
		var seconds = now.getSeconds();
		// 요일을 한국어로 표시
		var days = [ "일", "월", "화", "수", "목", "금", "토" ];
		var dayOfWeek = days[now.getDay()];
		// 시간, 분, 초를 두 자리 숫자로 표시하기 위해 10보다 작으면 앞에 0을 추가
		month = (month < 10 ? "0" : "") + month;
		day = (day < 10 ? "0" : "") + day;
		hours = (hours < 10 ? "0" : "") + hours;
		minutes = (minutes < 10 ? "0" : "") + minutes;
		seconds = (seconds < 10 ? "0" : "") + seconds;
		// 연월일시분초와 요일을 한국어로 표시
		var formattedDateTime = year + "년 " + month + "월 " + day + "일 ("
				+ dayOfWeek + ") " + hours + "시 " + minutes + "분 " + seconds
				+ "초";
		// 시간을 HTML 요소에 업데이트
		document.getElementById("datetime").innerHTML = formattedDateTime;
		// 1초마다 realTimeClock 함수를 호출하여 시간을 업데이트
		setTimeout(realTimeClock, 1000);
	}
	
</script>

<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
</html>