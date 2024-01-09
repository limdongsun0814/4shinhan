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
@font-face {
	font-family: 'SeoulNamsanM';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/SeoulNamsanM.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
	font-display: swap;
}

input[type="text"] {
	border: none; /* 테두리 제거 */
}

* {
	font-family: 'SeoulNamsanM', sans-serif;
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

textarea[name="store_notice_content"] {
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
<body>


	<form action="storeNoticeInsert.do" method="POST"
		enctype="multipart/form-data">
		<div class="all">
			<div class="side">
				<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>
			</div>

			<div class="content">
				<div class="keunteduri">
					<h1>공지사항 새로등록</h1>


					<div class="full">
						<div class="insert">

							<input type="hidden" name=store_notice_store_id
								value="${owner_store_id }">
							<div class="title-container">
								<span>제목</span><input type="text" name=store_notice_title>
							</div>
							</br>
							</br>
							<div class="contentteduri">
								내용</br>
								</br>
								<textarea name="store_notice_content" rows="20" cols="60">${storeNotice.store_notice_content}</textarea>
							</div>
							</br> </br>

							<div class="divimage">
								<fieldset id="imagebox">
									<p>이미지를 선택해주세요</p>
									<input type="file" name="store_notice_img_path1"
										id="0_img_input" onchange="setThumbnail(event)">
								</fieldset>
								<div id="store_notice_img_preview">
									<img src="resources/images/notStoreImg.png" id="upload_img" width="200px" height="200px" >
								</div>

								</br> </br>
							</div>

							<label>날짜 : </label><span id="datetime"
								name="push_alarm_datetime"></span></br> <input type="hidden"
								name=store_notice_view_count value="0">


						</div>
					</div>
					</br>
					<button class="indoorbutton" type="submit">새 공지사항 등록하기</button>
				</div>
			</div>
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
	
	
	function setThumbnail(event) {
	    var reader = new FileReader();

	    console.log(event.target.id);
		var img_id = event.target.id.split('_')[0];
	    console.log("event",event);
	    
	    reader.onload = function(event) {
	    var img = document.getElementById("upload_img");
	    img.src=event.target.result;
	     /* img.setAttribute("src", event.target);
	     img.setAttribute("id", img_id+"_"+"img"); */
	    console.log(event.target.id);
	    console.log(event.target);
	    console.log(img);
	     //document.querySelector("div#img_container").appendChild(img);
	   };
	    reader.readAsDataURL(event.target.files[0]);
	 }
</script>
<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
</html>