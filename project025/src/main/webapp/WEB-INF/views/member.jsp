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
				<th>id</th>
				<th>name</th>
				<th>push</th>
			</tr>
		</thead>
		<tbody>
			
				<tr>
					<td>${member.member_id}</td>
					<td>${member.member_name}</td>
					<td>${member.member_push_ok}</td>
				</tr>
			
		</tbody>
	</table>
</body>
</html>
