<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- <html>
<head>
<title>Home</title> -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/ownerHeader.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- </head>
<body> -->
<header>
<div class="header">
	<div class="logo">
	
		<a href="${pageContext.request.contextPath}/">
			<img src="${pageContext.request.contextPath}/resources/images/0254logo.png" alt="로고" />
		</a>
	</div>
	<div class="auth">
		<a href="javascript:logout()" ${sessionScope.owner == null?'style="display: none;"':""}>로그아웃</a>
		<img src="${pageContext.request.contextPath}/resources/images/address_icon.png" ${sessionScope.owner == null?'style="display: none;"':""}  >
		<select id="address" class="address_auth" onchange="address_function(event)" ${sessionScope.owner == null?'style="display: none;"':""} >
			<c:forEach items="${sessionScope.owner_store_list}" var="store_list" varStatus="status">
				<option value="${status.index}" ${sessionScope.store.store_id==store_list.store_id?"selected":""} >${store_list.store_name}</option>
			</c:forEach>
				<option value="insertStore" >가게 추가</option>
		</select>
		<a href="${pageContext.request.contextPath}/signUp.do"  ${sessionScope.owner != null?'style="display: none;"':""}>회원가입</a>
		<a href="${pageContext.request.contextPath}/login.do"  ${sessionScope.owner != null?'style="display: none;"':""}>로그인</a>
	</div>
</div>
</header>
<script>
	//var address_doc=document.getElementById("address");
	//address_doc.addEventListener('change',address_function);

	
	var path = "${pageContext.request.contextPath}";
	
	function address_function(event){
		console.log(event.target.value);
		console.log(path);
		if(event.target.value!="insertStore"){
			var form = document.createElement("form");
			form.setAttribute("method","post");
			form.setAttribute("action",path+"/chageAddress.do");
			
			var input = document.createElement("input");
			input.setAttribute("type","hidden");
			input.setAttribute("name",'index');
			input.setAttribute("value",event.target.value);
			form.appendChild(input);
			
			document.body.appendChild(form);
			form.submit();
		}else{
			/* storeInsert.do */
			var form = document.createElement("form");
			form.setAttribute("method","get");
			form.setAttribute("action",path+"/storeInsert.do");
			
			document.body.appendChild(form);
			form.submit();
		}
	}
	
	function logout() {
		location.href=path+'/logout.do';
	}
	
</script>
<!-- </body>
</html> -->