<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th>seqno</th>
				<th>content</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${testList}" var="test">
				<tr>
					<td>${test.seqno}</td>
					<td>${test.content}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>
