<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<script>
	setTimeout(f1,200);
	function f1(){
		var message = "${message}";
		console.log(message);
		if (message != "") {
			alert(message);
		}
	}
	
	Kakao.init('c9ae8a414e60beaf76f05c1954ec86eb'); //발급받은 키 중 javascript키를 사용해준다.
	console.log(Kakao.isInitialized()); // sdk초기화여부판단
	//카카오로그인
	function kakaoLogin() {
	    Kakao.Auth.login({
	      success: function (response) {
	        Kakao.API.request({
	          url: '/v2/user/me',
	          success: function (response) {

	        	  console.log(response.id);
	        	  console.log(response['kakao_account']);
	        	  console.log(response['kakao_account'].email);
	        	  console.log(response['kakao_account'].profile.nickname+'#'+response.id);
	        	  
	        	  var form = document.createElement("form");
				  form.setAttribute("method","post");
				  form.setAttribute("action","kakaologinCheck.do");
	        	  var obj = {"email":response['kakao_account'].email, "nickname":response['kakao_account'].profile.nickname+'#'+response.id};
	        	  
	        	  for(let key in obj){
	        		  var input = document.createElement("input");
	        		  input.setAttribute("type","hidden");
	        		  input.setAttribute("name",key);
	        		  input.setAttribute("value",obj[key]);
	        		  form.appendChild(input);
	        	  }
	        	  document.body.appendChild(form);
	        	  form.submit();
	        	  
	          },
	          fail: function (error) {
	            console.log(error)
	          },
	        })
	      },
	      fail: function (error) {
	        console.log(error)
	      },
	    })
	  }
</script>