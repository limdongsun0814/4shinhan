<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<style>
.alarm_row{
	display:grid;
	grid-template-columns:15% 4fr 1.5fr;
	border: 0.5px solid #A6A6A6;
	background-color:#fff;
	padding-top:10px;
	word-break:keep-all;
	padding-left:5px;
	border-radius: 20px;
    margin-top: 10px;
}
.alarm_row h6 {
	margin:0 0 1rem;
	font-size:0.8em;
}
.alarm_row .content {
    font-size: 0.7em;
	font-weight:normal;
	line-height:1.25;
}

.alarm_row .date {
	color:#a6a6a6;
	font-weight:normal;
}
</style>
<body>
	<c:forEach items="${joinList}" var="breadAlarm">
	<div class="alarm_row" id="alarm_row">
		<img src="${cpath}/resources/images/bread.png"></img>
		<div>
		<h6>${breadAlarm.store_name}</h6>
		<h6>${breadAlarm.push_alarm_title}</h6>
		<h6 class="content">${breadAlarm.push_alarm_content}</h6>
		</div>
		<h6 class="date">${breadAlarm.push_alarm_datetime}</h6>
	</div>
		
	</c:forEach>
</body>
