<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://kit.fontawesome.com/f719d238b7.js" crossorigin="anonymous"></script>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage | 빵이오</title>
<!-- 헤더 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
</head>

<body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c9ae8a414e60beaf76f05c1954ec86eb&libraries=services,clusterer,drawing"></script>
<%@ include file="/WEB-INF/views/cart/miniCart.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  
<br><br>
	<!-- 마이페이지 -->
	<div class="my_container">
		<!-- 마이 페이지 고정 상단바(등급/혜택) -->
		<div class="tier_box_area" style="border-radius: 10px;">
			<div class="tier_box">
				<div class="tier_box_left">
					<div class="mypage_txt" style="font-size: 30px;">마이페이지</div>
				</div>
				<!-- 등급/혜택 -->
				<div class="tier_box_right">
				<!-- 등급 -->
					
					<!-- 혜택 -->
					<div class="benefits_area">
						<div class="benefits">
						<div class="info_member">
						<div class="txt">안녕하세요. ${member.member_name}님은 
						<span>
							${member.member_tier==0?"블루":member.member_tier==1?"핑크":"옐로우" }
						</span>
						입니다.
						</div>
					</div>
							<div class="benefit" id="mileage">
							<div class="mileage_icon"><i class="fa-solid fa-m"></i></div>빵이오 마일리지<span>${member.member_mileage}</span>M <p style="font-size: 15px;">(주문액의 02.5%가 적립됩니다!)</p></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 마이페이지 내용 -->
		<div class="bottom_area">
			<!-- 마이페이지 카테고리별 내용 -->
			<div class="bottom_content">
				<!-- 왼쪽 사이드 바 -->
				<div class="left_sidebar_area">
					<div class="left_sidebar">
						<!-- 메뉴 리스트 -->
			            <div class="my_menu">
			                <ul class="big_menu">
			                    <li>마이쇼핑</li>
			                    <ul class="small_menu">
			                        <li><a href="javascript: getOrderList()">주문내역 조회</a></li>
			                        <!-- <li><a href="javascript: getMySubList()">구독내역 조회</a></li> -->
			                    </ul>
			                </ul>
			                <ul class="big_menu">
			                    <li>마이 활동</li>
			                    <ul class="small_menu">
			                        <!-- <li><a href="#">쿠폰</a></li> -->
			                        <li><a href="javascript: getReviewList()">리뷰 관리</a></li>
									<li><a href="javascript: heartList()">찜한 가게</a></li>
			                        <!-- <li><a href="#">문의 내역</a></li> -->
			                    </ul>
			                 </ul>
			                <ul class="big_menu">
			                    <li>마이 정보</li>
			                    <ul class="small_menu">
			                        <li><a id="updateInfo" style="cursor: pointer;">회원정보 수정</a></li>
			                    </ul>
			                </ul>
			            </div>
		        	</div>
				</div>
				<!-- 마이페이지 카테고리별 내용 -->
				<div class="my_content_area">
					<div id="here"></div>
				</div>
			</div>
		</div>
	
	</div>
	
<!-- 모달창 -->
	<div id="chk_modalWrap" style="display: none;">
		<div id="chk_modalContent">
			<div id="chk_modalBody">
				<span id="chk_closeBtn">&times;</span>
				<div class="modal_image">
					<img src="${cpath}/resources/images/025logo.png" alt="로고">
				</div>
				<div class="chk_content" id="chk_content">
					<p style="font-size: 20px">회원정보를 수정하시려면 비밀번호를 입력하셔야 합니다.</p>
					<p>회원님의 개인정보 보호를 위한 본인 절차이오니, 빵이오 회원 로그인 시 사용하시는 비밀번호를 입력해주세요.</p>
					<input class="input_password" id="passwordInput" type="password" placeholder="비밀번호를 입력하세요.">
				</div>
				<div class="modal_button">
					<button class="modal_cancel_button" id="modal_cancel_button" onclick="modal_cancel()">취소</button>
					<button class="modal_check_button" onclick="modal_password_check()">확인</button>
				</div>
			</div>
		</div>
	</div>

	<script>
	
		//열리자 마자 주문내역 조회 페이지 가기
		$(document).ready(function () {
	        getOrderList();
	    });
		
		
		function checkPass() {
			console.log("qwer");

		}

		function heartList() {
			$.ajax({
				url : "${cpath}/store/getHeartStore.do",
				success : function(responseData) {
					$("#here").html(responseData);
				}
			});
		};
		
		function modal_password_check() {
		    
		    var enteredPassword = document.getElementById('passwordInput').value;

		    console.log(enteredPassword);
		    $.ajax({
		      url: "${cpath}/mypage/checkPassword.do", 
		      method: "POST",
		      data: { "enteredPassword": enteredPassword }, 
		      success: function(responseData) {
		        if (responseData === "success") {
		        	closeModal();
		        	updateMyInfo();
		        } else {
		          alert("비밀번호가 일치하지 않습니다.");
		        }
		      },
		      error: function() {
		        alert("비밀번호 확인 중 오류가 발생했습니다.");
		      }
		    });
		  }
		function closeModal() {
			  var modal = document.getElementById('chk_modalWrap');
			  modal.style.display = 'none';
			}
		
		 
		function updateMyInfo() {
			$.ajax({
				url : "${cpath}/mypage/getMyInfo.do",
				success : function(responseData) {
					$("#here").html(responseData);
				}
			});
		};
		
		function getOrderList() {
			$.ajax({
				url : "${cpath}/mypage/getOrderList.do",
				success : function(responseData) {
					$("#here").html(responseData);
				}
			});
		};
		function getMySubList() {
			$.ajax({
				url : "${cpath}/mypage/getMySubList.do",
				success : function(responseData) {
					$("#here").html(responseData);
				}
			});
		};
		function getReviewList() {
			$.ajax({
				url : "${cpath}/mypage/getReviewList.do",
				success : function(responseData) {
					$("#here").html(responseData);
				}
			});
		};
	</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/checkPass.js" > </script>
 </body>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</html>