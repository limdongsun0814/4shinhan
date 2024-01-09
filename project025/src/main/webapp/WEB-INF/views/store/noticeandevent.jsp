<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://kit.fontawesome.com/f719d238b7.js" crossorigin="anonymous"></script>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/noticeandevent.css">


<div class="notice_area">
	<div class="notice_top">공지 & 이벤트</div>
	<div class="notice_list">
		<c:if test="${empty noticeList}">
			<div class="no_notice">
				<div>아직 공지가 없습니다.</div>
			</div>
		</c:if>
		<c:if test="${not empty noticeList}">
			<c:forEach items="${noticeList}" var="notice" varStatus="loop">
				<!-- <div class="notice">
					<div class="notice_info">
						<div class="notice_title">제목: ${notice.store_notice_title}</div>
						<div class="notice_content">내용: ${notice.store_notice_content}</div>
						<div class="notice_timestamp">${notice.store_notice_date}</div>
						<div class="notice_view_count">조회수(${notice.store_notice_view_count})</div>
					</div>
				</div> -->
				<div class="one_notice">
					<div class="top">
						<div class="notice_timestamp">${notice.store_notice_date}</div>
						<p>제목: ${notice.store_notice_title}</p>
						<div class="notice_view_count">조회수(${notice.store_notice_view_count})</div>
					</div>
					<div class="notice">
						<div class="notice_img">
							<img class="left_content" src="${notice.store_notice_img_path}" alt="공지 이미지"/>
						</div>
			
						<div class="right_content">
							<div class="notice_content">
								<div class="content">${notice.store_notice_content}</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
	</div>
</div>


<script>
    
</script>
