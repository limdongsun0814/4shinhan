<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://kit.fontawesome.com/f719d238b7.js" crossorigin="anonymous"></script>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/ingredients_info.css">


<div class="ing_info_area">
	<div class="ing_info_top">원산지 정보</div>
	<div class="ing_info_list">
		<table>
			<thead>
				<tr align="center">
					<th>표시품목</th>
					<th>원산지</th>
							
				</tr>
			</thead>
			<c:forEach items="${ingredientsMap}" var="map" varStatus="loop">
				<div class="ing_info">
					<tbody>
						<tr align="center">
							<th>${map.getKey()}</th>
							<th>${map.getValue()}</th>
									
						</tr>
					</tbody>
				</div>
			</c:forEach>
		</table>
		
	</div>
</div>


<script>
    
</script>
