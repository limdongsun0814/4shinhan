<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
</head>
<style>
.modal_container {
	position:absolute;
	top:50%;
	left:50%;
	transform:translate(-80px, -50%);
	background-Color:#F1EEDC;
	display:flex;
	width:500px;
	height:300px;
	align-items:center;
	justify-content:center;
	border:0.5px solid black;
	border-radius:20px;
}
.modal_container > h1{
	font-size:1.5rem;
}
.modal_hidden{
	display:none;
}
.bread_modal_image{
	display:flex;
	justify-content:center;
}
#modal_content{
	position:relative;
}
#modal_close {
	position:absolute;
	top:-60px;
	right:-70px;
	font-size:1.5rem;
	cursor:pointer;
}

</style>
</head>
<div class="modal_container modal_hidden" onclick="modalToggle()">

		<div id="modal_content">
			<span id="modal_close">&times;</span>
			<div class="bread_modal_image">
				<img src="${pageContext.request.contextPath}/resources/images/0254logo.png" alt="로고">
			</div>
			<h1>준비 중인 페이지입니다.</h1>

			<!--  <button id="find_id_close">닫기</button> -->
		</div>

</div>
<script>
function modalToggle(){
	console.log('modal click');
	var modal = document.querySelector('.modal_container');
	if(modal.classList.contains('modal_hidden')){
		modal.classList.remove('modal_hidden');
	} else {
		modal.classList.add('modal_hidden');
	}
}
function modalClose(){
	var modal = document.querySelector('.modal_container');
	modal.classList.add('modal_hidden');
}
</script>