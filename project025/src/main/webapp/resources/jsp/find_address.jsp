<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c9ae8a414e60beaf76f05c1954ec86eb&libraries=services,clusterer,drawing"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<script>

//<input> 비밀번호,<input>비밀번호 확인 
var password = document.getElementById("password");
var password_check = document.getElementById("password_check");
var password_check_boolean = false;
var address_check_boolean = false;

//<input> 아이디, <input button> 아이디확인 button
var id_document = document.getElementById('id');
var id_check = document.getElementById("id_check");

//<p>비밀번호 일치 확인
var password_check_result = document.querySelector("#password_check_result");

//<input button> 회원가입 button
var join = document.getElementById('join');

// 아마도 주소입력???
var geocoder = new kakao.maps.services.Geocoder();



//살리지 못한 기능들 
var email_document = document.getElementById('email');
//var email_check = document.getElementById("email_check");
var phone_document = document.getElementById('phone');
//var phone_check = document.getElementById("phone_check");
//var regist_code_document = document.getElementById('regist_code');
//var regist_code_check = document.getElementById("regist_code_check"); 


//비밀번호,비밀번호 확인  후  둘이 같은지 확인하는 function
password.addEventListener('input',password_check_function);
password_check.addEventListener('input',password_check_function);



//각 유효성 검사
id_document.addEventListener('input',id_str_check);
//email_document.addEventListener('input',email_str_check);
//phone_document.addEventListener('input',phone_str_check);
//regist_code_document.addEventListener('input',regist_code_str_check);


id_check.onclick=id_check_function;
//email_check.onclick=email_check_function;
//phone_check.onclick=phone_check_function;
//regist_code_check.onclick=regist_cophonee_check_function;

id_str_check();
//email_str_check();
//phone_str_check();
//regist_code_str_check();

function id_check_function() {
	var id_value = id_document.value;
	console.log(id_value);
	var id_object = {
		"id" : id_value
	};
	$.ajax({
		type : "POST",
		url : "idCheck.do",
		data : id_object,//JSON.stringify(id_object),
		//contentType: "application/json; charset=utf-8;",
		success : function(res) {
			if (res.result == true) {
				join.disabled = true;
				id_check_boolean = false;
				alert('이미 사용 중인 아이디입니다.');
			} else {
				id_check_boolean = true;
				check();
				alert('사용할 수 있는 아이디입니다.');
			}
		},
		error : function() {
			alert('ajex 실패');
		}
	});
}

//회원가입 button 활성화 여부를 판단하기 위한 것
var id_check_boolean = false;
//var email_check_boolean = false;
//var phone_check_boolean = false;
//var regist_code_check_boolean = false;


// 주소 가져오기
function get_address() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            console.log(data);
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = roadAddr;
            address_check_boolean=true;
            check();
            console.log('종료1');
           
            geocoder.addressSearch(roadAddr, get_position);
        }
    }).open();
    console.log('종료2');
}


//id 유효성 검사
function id_str_check(){
    join.disabled = true;
    var id_len = id_document.value.length;
    /* 최소 4, 최대 15 */
    if(id_len >= 4 && id_len <= 15){
        id_check.disabled = false;
    }else{
        id_check.disabled = true;
    }
}

//이메일 유효성 검사
function email_str_check(){
    join.disabled = true;
    var email_str_value = email_document.value;
    console.log(email_str_value.indexOf('@'));
    if(email_str_value.length-email_str_value.indexOf('@') >= 2 && email_str_value.indexOf('@')>0){
        //email_check.disabled = false;
    }else{
        //email_check.disabled = true;
    }
}

//전화번호 유효성 검사
/* function phone_str_check(){
    join.disabled = true;
    var phone_str_value = phone_document.value;
    if(phone_str_value.length >= 1){
        phone_check.disabled = false;
    }else{
        phone_check.disabled = true;
    }
} */

//사장님 사업자 번호 유효성 검사
/*  function regist_code_str_check(){
    join.disabled = true;
    var regist_code_str_value = regist_code_document.value;
    if(regist_code_str_value.length >= 1){
        regist_code_check.disabled = false;
    }else{
        regist_code_check.disabled = true;
    }
}  */



function id_check_function(){
    var id_value = id_document.value;
    console.log(id_value);
    var id_object = {"id":id_value};
    $.ajax({
        type:"POST",
        url:"idCheck.do",
        data:id_object,//JSON.stringify(id_object),
        //contentType: "application/json; charset=utf-8;",
        success:function(res){
            if(res.result==true){
                join.disabled = true;
            	id_check_boolean = false;
                alert('이미 사용 중인 아이디입니다.');
            }else{
            	id_check_boolean = true;
                check();
                //id_document.disabled = true;
                alert('사용할 수 있는 아이디입니다.');
            }
        },
        error:function(){
            alert('ajex 실패');
        }
    });
}

//이메일 중복 검사
/*  function email_check_function(){
    var email_value = email_document.value;
    console.log(email_value);
    var email_object = {"email":email_value};
    $.ajax({
        type:"POST",
        url:"emailCheck.do",
        data:email_object,//JSON.stringify(id_object),
        //contentType: "application/json; charset=utf-8;",
        success:function(res){
            if(res.result==true){
                join.disabled = true;
                alert('이메일이 중복되었습니다.');
            }else{
            	email_check_boolean = true;
                check();
                alert('중복된 이메일이 없습니다.');
            }
        },
        error:function(){
            alert('ajex 실패');
        }
    }); 
} */

//번호 중복 검사
/*  function phone_check_function(){
    var phone_value = phone_document.value;
    console.log(phone_value);
    var phone_object = {"phone":phone_value};
    $.ajax({
        type:"POST",
        url:"phoneCheck.do",
        data:phone_object,//JSON.stringify(id_object),
        //contentType: "application/json; charset=utf-8;",
        success:function(res){
            if(res.result==true){
                join.disabled = true;
                alert('전화번호가 중복되었습니다.');
            }else{
            	phone_check_boolean = true;
                check();
                alert('중복된 전화번호가 없습니다.');
            }
        },
        error:function(){
            alert('ajex 실패');
        }
    });
}  */

//사업자등록번호 중복 검사
 /* function regist_code_check_function(){
    var regist_code_value = regist_code_document.value;
    console.log(regist_code_value);
    var regist_code_object = {"regist_code":regist_code_value};
    $.ajax({
        type:"POST",
        url:"registCodeCheck.do",
        data:regist_code_object,//JSON.stringify(id_object),
        //contentType: "application/json; charset=utf-8;",
        success:function(res){
            if(res.result==true){
                join.disabled = true;
                alert('아이디가 중복되었습니다.');
            }else{
            	regist_code_check_boolean = true;
                check();
                alert('중복된 아이디가 없습니다.');
            }
        },
        error:function(){
            alert('ajex 실패');
        }
    });
}  */



//비밀번호 ,비밀번호확인  둘 비교
function password_check_function(){
	console.log(password.value);
    join.disabled = true;  //이거 굳이 있어야할까요?
    if(password.value==password_check.value){
        password_check_result.textContent = '비밀번호가 일치합니다';
        password_check_result.style.color = 'green';
        password_check_result.style.fontSize='10px';
        password_check_boolean=true;
        //join.disabled = false;
        check();
    }
    if(password.value!=password_check.value){
    	password_check_boolean=false;
        password_check_result.textContent = '비밀번호가 일치하지 않습니다.';
        password_check_result.style.color = 'red';
        password_check_result.style.fontSize='10px';
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
function alert_function(){
	var message = "${message}";
	console.log(message);
	if (message != "") {
		alert(message);
	}
}

 function check(){
	if(id_check_boolean&&password_check_boolean&&address_check_boolean){
        join.disabled = false;
	}
}
</script>