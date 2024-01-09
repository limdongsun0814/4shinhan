<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<meta charset="UTF-8">
<title>Alarm | 빵이오4</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
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
	border: 1px solid #FF6464;
	padding: 10px;
	margin-top: 10px;
	margin: auto;
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

.content {
	/* border: 1px solid #FF6464; 
	border-radius: 10px; 
	padding: 10px; 
	
	margin: 0 auto; */
	width: 70%;
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



	<form method="POST" action="pushAlarmList.do">
		<div class="all">
			<div class="side">
				<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>
			</div>
			<input type="hidden" name=menu_id> <input type="hidden"
				name=push_alarm_store_id value="${sessionScope.owner_store_id }">

			<div class="content">

				<div class="keunteduri">
					<h1>알림 보내기</h1>

					<div class="radioset" style="display: none;">
						<div class="radio-option">
							<input type="radio" name="push_alarm_to_target_id" value="전체"
								id="radio1"
								<c:if test="${push_alarm.push_alarm_to_target_id == '전체'}">checked</c:if>>
							<label for="radio1">전체</label>
						</div>
						<div class="radio-option">
							<input type="radio" name="push_alarm_to_target_id" value="찜"
								id="radio2"
								<c:if test="${push_alarm.push_alarm_to_target_id == '찜'}">checked</c:if>>
							<label for="radio2">찜</label>
						</div>
						<div class="radio-option">
							<input type="radio" name="push_alarm_to_target_id" value="구독"
								id="radio3"
								<c:if test="${push_alarm.push_alarm_to_target_id == '구독'}">checked</c:if>>
							<label for="radio3">구독</label>
						</div>
					</div>

					<input type="hidden" name="push_alarm_to_target_id_hidden"
						value="${push_alarm.push_alarm_to_target_id}">
					<div class="full">
						<div class="insert">
							<div class="category-container" style="display: none;">
								<span>카테고리</span><select name="push_alarm_category_id">
									<c:forEach items="${push_alarm_category_id}" var="category">
										<option value='${category.push_alarm_category_id}'
											<c:if test="${category.push_alarm_category_id == selected_push_alarm_category_id}">selected</c:if>>
											${category.push_alarm_category_name}</option>
									</c:forEach>
								</select>
							</div>

							<input type="hidden" name="push_alarm_category_id_hidden"
								value="${selected_push_alarm_category_id}"> <br />



							<div class="title-container">
								<span>제목</span> <input type="text" name="push_alarm_title"
									value="${push_alarm.push_alarm_title}" />
							</div>
							</br>


							<div class="contentteduri">

								내용<br />
								<textarea name="push_alarm_content" cols="50" rows="10">${push_alarm.push_alarm_content}</textarea>
								<br />
							</div>
							<h2>현재 시간</h2>
							<span id="datetime" name="push_alarm_datetime"></span> <br />
						</div>

					</div>
					<div class="w3-container w3-center">
						<button class="indoorbutton" type="submit">알림전송</button>
					</div>
				</div>
			</div>
		</div>
		<br>

		</div>
	</form>



</body>
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