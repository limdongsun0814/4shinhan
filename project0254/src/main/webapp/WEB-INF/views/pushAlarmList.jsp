<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Alarm | 빵이오4</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>

.content {
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 20px;
	border: 2px solid #FFBBBB; /* 테두리 색상을 지정합니다 */
	box-shadow: 0px 0px 15px 0px rgba(0, 0, 0, 0.1); /* 그림자 효과를 적용합니다 */
	/* background-color: #FEF4CF; */

	width: 80%; /* 너비를 80%로 줄임 */
	margin: 0 auto; /* 중앙 정렬 */
	margin-top: 40px;
    margin-bottom: 40px;
    border-radius: 50px;
}

.alarm-content {
    padding-left: 0px; 
    display: flex;
    flex-direction: column;
    /* flex-grow: 1; */
    width: 80%;
    /* height: 00px; */
    margin-top: 40px;
    margin-bottom: 40px;
    border-radius: 50px;
    align-items: center;
    margin: 0 auto;
    padding:5rem 0;
}

.content>h1 {
	display: inline-block; /* 수평 배치를 위해 인라인 블록으로 변경 */
}

.outdoorbutton {
	position: relative; /* 상대 위치 지정 */
	top: 10px; /* 위로부터 10px 위치 */
	/*margin: auto;  위 아래 마진 15px, 왼쪽 오른쪽 마진은 자동 */
	margin-left: auto; /* 왼쪽 마진을 자동으로 설정 */
	display: inline-block; /* 수평 배치를 위해 인라인 블록으로 변경 */
	padding: 10px;
	border: none;
	border-radius: 5px;
	background-color: #FF6464;
	color: #ffffff;
	cursor: pointer;
	text-align: center;
	width: 20%;
    margin-right: 15px;
}

h1 {
	font-family: 'SeoulNamsanM' !important;
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
	margin-left: auto; /* 왼쪽 마진을 자동으로 설정 */
	margin-right: 30px;
	padding: 10px;
	border: none;
	border-radius: 5px;
	background-color: #FF6464;
	color: #ffffff;
	cursor: pointer;
	text-align: center;
	width: 19%; /* 버튼 크기를 20%로 줄임 */
}

.item-container {
	border: 2px solid #FFBBBB; /* 테두리 색상을 지정합니다 */
	border-radius: 20px; /* 둥근 테두리를 만듭니다 */
	box-shadow: 0px 0px 15px 0px rgba(0, 0, 0, 0.1); /* 그림자 효과를 적용합니다 */
	padding: 20px; /* 내부 패딩을 추가합니다 */
	margin-left: auto;
	margin-bottom: 20px; /* 아이템 간 간격을 만듭니다 */
	background-color: #ffffff; /* 배경색을 지정합니다 */
	width: 50%; /* item-container의 크기를 절반으로 줄임 */
	margin: 0 auto; /* 중앙 정렬 */
}

button:hover {
	background-color: #FFEC9F;//
}

.notification {
	border: 2px solid #FFBBBB; /* 테두리 색상을 지정합니다 */
	border-radius: 20px; /* 둥근 테두리를 만듭니다 */
	box-shadow: 0px 0px 15px 0px rgba(0, 0, 0, 0.1); /* 그림자 효과를 적용합니다 */
	padding: 20px; /* 내부 패딩을 추가합니다 */
	margin-bottom: 20px; /* 아이템 간 간격을 만듭니다 */
	background-color: #ffffff; /* 배경색을 지정합니다 */
	width: 100%;
	display: flex;
    flex-direction: column;
}
.alarm_list_container{
	width:75%;
}
</style>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">
<%@ include file="/WEB-INF/views/common/ownerHeader.jsp"%>
</head>
<body>
	<div class="all">
		<div class="side">
			<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>
		</div>
		<div class="alarm-content">
			<h1>알림 목록</h1>

			<div class="alarm_list_container">
		</br>
			</br>
				<!-- 				<select id="selectview">
					<option value="10" selected="selected">10개씩 보기</option>
					<option value="15">15개씩 보기</option>
					<option value="20">20개씩 보기</option>
				</select> -->
				<div>
					<button class="indoorbutton"
				onclick="location.href='pushAlarmInsert.do'">알림새로보내기</button>
			</br>
					<c:forEach items="${pushAlarmList}" var="pushAlarmId">
						<div class="notification" style="border: 1px solid red;">

							<span class="alarmTargetId"
								name="${pushAlarmId.push_alarm_to_target_id}">주문 종류 :
								${pushAlarmId.push_alarm_to_target_id}</span> <span class="alarmTitle"
								name="pushAlarmId.push_alarm_title">알림 제목 :
								${pushAlarmId.push_alarm_title}</span> <span class="alarmContent"
								name="pushAlarmId.push_alarm_content">알림 내용 :
								${pushAlarmId.push_alarm_content}</span> <span class="alarmTime"
								name="pushAlarmId.push_alarm_datetime">${pushAlarmId.push_alarm_datetime}<fmt:formatDate
									value="${paymentDate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
							<button class="outdoorbutton"
								onclick="location.href='pushAlarmResend.do?push_alarm_id=${pushAlarmId.push_alarm_id}'">다시보내기</button>
						</div>
					</c:forEach>
				</div>


			</div>
			</br>

		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
</body>
</html>