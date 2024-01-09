<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/myheartstores.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage/myinfo.css">

<div class="myinfo_all">
	<form>
	<table>
			<tbody>
				
			        <tr>
			            <th>이름</th>
			            <td class="none_change">${member.member_name}</td>
			        </tr>
			        <tr>
			            <th>아이디</th>
			            <td class="none_change">${member.member_id}</td>
			        </tr>
			        <tr>
			            <th>생년월일</th>
			            <td class="none_change">${member.member_birthdate}</td>
			        </tr>
			        <tr>
			            <th>핸드폰</th>
			            <td class="none_change">${member.member_phone}</td>
			        </tr>
			        <tr>
			            <th>이메일</th>
			            <td class="none_change">
			            	${member.member_email}
			            </td>
		            	<td><input id="email" value="${member.member_email}" type="hidden"/></td>
			        </tr>
			        <tr>
			            <th>주소</th>
			            <td>
			            	<input class="find_adress_button" type="button" onclick="get_address()" value="주소찾기">
			            	<input id="address" value="${member.member_address}" readonly="readonly"/>
			            	<div class="address_detail"><div class="address_detail_left">상세주소 : </div> <input  id="address_detail" value="${member.member_address_detail}"></input></div>
			            	<input type="hidden" id="address_longitude" value="${member.member_address_longitude}"><input type="hidden" id="address_latitude" value="${member.member_address_latitude}">
			            </td>
			        </tr>
			        <tr>
			            <th>닉네임 변경</th>
			            <td>
			            	<input id="nickname" value="${member.member_nickname}"/>
			            </td>
			        </tr>
			        <tr>
			            <th>비밀번호 변경</th>
			            <td>
			            	<input id="password" value="${member.member_password}" ${member.member_password}/>
			            </td>
			        </tr>
			        <tr>
			            <th>비밀번호 재입력</th>
			            <td>
			            	<input id="password_check" value="${member.member_password}" placeholder="새로운 비밀번호를 다시 입력해 주세요.">
			            	<div id="password_check_result"></div>
			            </td>
			        </tr>
		       
			</tbody>
	</table>
	</form>
		<div class="acceptInfo">
		<br>
		정보제공 동의여부
		<br><br>
		본인은 빵이오 옴니서비스 이용을 위하여 아래와 같이 본인의 정보를 제3자에게 제공하는 것에 동의합니다.
		<br><br>
		[제공 목적]
		<br><br>
		1) 고유 상품/서비스 제공, 유지, 개선, 고도화, 최적화 및 신규 상품/서비스 개발<br>
		2) 온-오프라인 채널 간 연계 및 통합을 통한 다양한 서비스 개발, 제공, 유지, 개선, 고도화 및 최적화<br>
		3) 상품/서비스 이용실적 통계/분석, 시장조사, 인구통계학적 분석, 데이터 분석을 기반으로 한 이용자 간 관계 형성, 고객 성향 분석 및 이를 통한 고객별 맞춤 상품/서비스 개발 및 제공<br>
		4) 고객만족서비스(CS)개선 및 고객과의 커뮤니케이션 능력 향상<br>
		5) 상품/서비스 정보 제공 및 홍보, 경품/사은행사 등 이벤트 참여 기회 제공, 쿠폰, 할인 및 우대 혜택 제공 등 마케팅 및 프로모션 목적<br>
		6) 고객 정보 보호 강화를 위한 외부 침입, 해킹, 악용사례, 보안위험, 기술적 문제 등 감지, 예방 및 대응책 수립
		<br><br>
		[제공 및 활용기간]
		<br><br>
		제공에 동의하신 정보는 동의를 철회하거나 서비스이용 종료 시 파기합니다. 다만, 관련 법령상 특정 항목 보유기간이 제한된 경우에는 그에 따릅니다.
		<br><br>
		[동의거부]
		<br><br>
		모든 동의는 옴니서비스 제공 및 고객 만족 향상을 위한 선택 동의 사항으로 회원은 개인정보의 제공에 대한 동의를 거부할 수 있습니다.<br>
		거부하시는 경우 관련 이벤트 및 프로모션 등 참여가 제한될 수 있으나 빵이오 멤버십 서비스 이용에는 영향을 미치지 않습니다.
		<br><br>
		아래 제공에 동의하신 경우, 본인이 가입한 각 서비스의 가입 시점부터 본 동의 시점까지의 정보도 제공항목에 포함됩니다.
		<br>
		</div>
	
	<div class="buttons">
		<div class="top_buttons">
			<button id="cancel">취소</button>
			<button id="updateMember" >수정</button>
		</div>
		<div class="delete_button_area">
			<button class="deleteMember" id="deleteMember">회원탈퇴 ☞</button>
		</div>
	</div>
	
</div>

<script>

	var password = document.getElementById("password");
	var password_check = document.getElementById("password_check");
	var password_check_result = document.querySelector("#password_check_result");
	
	password.addEventListener('input',password_check_function);
	password_check.addEventListener('input',password_check_function);

	document.getElementById('deleteMember')
	.addEventListener('click', function() {
	window.location.href = '${cpath}/member/deleteMember.do?mid=${member.member_id}';
	});

    	$("#updateMember").on("click", function(){
    	   	 var member_email = $('#email').val();
    	     var member_address = $('#address').val();
    	     var member_nickname = $('#nickname').val();
    	     var member_address_detail = $('#address_detail').val();
    	     var member_address_longitude = $('#address_longitude').val();
    	     var member_address_latitude = $('#address_latitude').val();
    	     var member_password = $('#password').val();
    	        $.ajax({
    				url: "${cpath}/member/updateMember.do",
    				type: "get",
    				data: {
						"member_id":"${member.member_id}",
						"member_email": member_email,
				        "member_address": member_address,
				        "member_nickname": member_nickname,
				        "member_address_detail": member_address_detail,
				        "member_address_longitude": member_address_longitude,
				        "member_address_latitude": member_address_latitude,
				        "member_password": member_password
				      },
    				success: function(responseData){
    					alert('회원 정보를  수정했습니다.');
    					$("#myinfohere").html(responseData);
    				}
    			});
    	    	
    	})
  
	
    document.getElementById('cancel')
			.addEventListener('click', function() {
		alert('정보 수정이 취소되었습니다. 빵이오 메인으로 돌아갑니다.');
		window.location.href = '${cpath}';
	});
    	
   	function get_address() {
   	    new daum.Postcode({
   	        oncomplete: function(data) {
   	            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
   	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
   	            var roadAddr = data.roadAddress; // 도로명 주소 변수
   	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
   	            console.log(data);
   	            //document.getElementById('postcode').value = data.zonecode;
   	            document.getElementById("address").value = roadAddr;
   	            console.log('종료1');
   	           
   	            geocoder.addressSearch(roadAddr, get_position);
   	        }
   	    }).open();
   	    console.log('종료2');
   	}
   	function password_check_function(){
   		console.log(password.value);
   	   
   	    if(password.value==password_check.value){
   	        password_check_result.textContent = '비밀번호가 일치합니다';
   	        password_check_result.style.color = 'green';
   	    }
   	    if(password.value!=password_check.value){
   	        password_check_result.textContent = '비밀번호가 일치하지 않습니다.';
   	        password_check_result.style.color = 'red';
   	    }
   	}
   	
   	
	var get_position = function(result, status) {
   		if (status === kakao.maps.services.Status.OK) {
   			console.log(result);

   	        document.getElementById('address_longitude').value = result[0].x;
   	        document.getElementById("address_latitude").value = result[0].y;
   			console.log(result[0].x); //owner_address_longitude
   			console.log(result[0].y); //owner_address_latitude
   		}
   	};
</script>