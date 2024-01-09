<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<title>Insert title here</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" type="text/css"
	href="${cpath}/resources/css/mypage/myReviewWritePage.css">



</head>
<body>

<!-- 
	<form action="submitReview.do" method='post'> -->
	
		<input type="hidden" name="member_review_member_id" value="${member.member_id}" />
		<input type="hidden" id="payment_seq" name="payment_seq" value="${param.payment_seq}" />
		
		
	
	
		<div class="all">
			

			<div class="content">

					<div class="keunteduri">
						<h1>리뷰 등록</h1>

						
							<div class="insert">
								<div class="title-container">
									<span>제목:</span> 
									<input id="member_review_title" name="member_review_title" placeholder="리뷰 제목을 입력해주세요." type="text"/>
								</div>
								<br>
								<div class="title-container">
									내용:
									<textarea id="member_review_content" name="member_review_content" placeholder="리뷰 내용을 입력해주세요." ></textarea>
									
								</div>
								<br>
								<div class="title-container">
									<label for="imageInput" class="custom-file-upload">
									  <span id="fileName">리뷰 사진 선택 (1개)</span>
									  <input id="member_review_img_path" name="member_review_img_path" type="file" onchange="displayFileName(this)" />
									</label>
								</div>
									<div id="member_review_recommend" >
										<label>
										<input name="member_review_recommend" type="checkbox" id="recommendCheckbox" > 추천하기
										</label>
									</div>
									<div class="recommend_bottom">
										<input disabled id="member_review_score_number" name="member_review_score_number" placeholder="별점 (1~5)" type="text"/>
										<div class="btn-group">
											<button type="button" class="btn btn-primary" value="1">1점</button>
											<button type="button" class="btn btn-primary" value="2">2점</button>
											<button type="button" class="btn btn-primary" value="3">3점</button>
											<button type="button" class="btn btn-primary" value="4">4점</button>
											<button type="button" class="btn btn-primary" value="5">5점</button>
										</div>
									</div>
								<div class="submit_bottom">	
									<div class="time_area">
										<p>리뷰 등록 시간<p>
										<span id="datetime" name="member_review_date"></span>
									</div>
	
									<div class="w3-container w3-center">
										<button class="indoorbutton" type="button" onclick="submit_review(${param.payment_seq})">리뷰 등록</button>
									</div>
								</div>
						</div>
					</div>
					
				</div>
				
			</div>

<!-- 	</form>
 -->


</body>
<script>

	function displayFileName(input) {
		  var fileName = input.files[0].name;
		  document.getElementById("fileName").innerHTML = fileName;
	}


	$(document).ready(function() {
	    $(".btn-group .btn").click(function() {
	        // 클릭된 버튼의 value 값을 가져와서 input 태그에 설정
	        var score = $(this).val();
	        $("#member_review_score_number").val(score);
	    });
	});
	
	
	function submit_review(e) {
		
		
		var isChecked = $("#recommendCheckbox").prop("checked");
		var member_review_recommend_value = isChecked ? 1 : 0;
		console.log(member_review_recommend_value);
		
		var payment_seq_value = document.getElementById("payment_seq").value;
		var member_review_title_value = document.getElementById("member_review_title").value;
		var member_review_content_value = document.getElementById("member_review_content").value;
 		/* var member_review_img_path_value = document.getElementById("member_review_img_path").value;  */
		var member_review_score_number_value = document.getElementById("member_review_score_number").value;

		var obj = {
			"payment_seq":payment_seq_value,
			"member_review_title":member_review_title_value,
			"member_review_content":member_review_content_value,
			/* "member_review_img_path":member_review_img_path_value, */
			"member_review_recommend":member_review_recommend_value,
			"member_review_score_number":member_review_score_number_value
		};
		$.ajax({
			url: "${cpath}/mypage/submitReview.do",
			data:obj,
			method: "post",
			success:function(responseData){
				console.log(responseData);
				//$("#here").html(responseData);
			},
			error:function(){
				console.log("ajax 오류");
			}
		});  

		var file = $("#member_review_img_path")[0].files[0];
		console.log($("#member_review_img_path"));
		var fileData = new FormData();
		fileData.append("files",file);
		var formData = new FormData();
		formData.append("files", fileData);
		formData.append("payment_seq", payment_seq_value);
		$.ajax({
			url: "${cpath}/mypage/submitReviewImg.do/"+payment_seq_value,
			data: fileData,
			method: "post",
			contentType : false,
			processData : false,
			success:function(responseData){
				location.href="${cpath}/mypage/myPageMain.do";
				console.log(responseData);
				/* var imagePath = responseData.imagePath;
				$("#image_area").html('<img src="' + imagePath + '" alt="Review Image">'); */
			},
			error:function(){
				console.log("ajax 오류");
			}
		});
		
		
	}
	
	realTimeClock();
	function realTimeClock(){
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
</script>
</html>