<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c9ae8a414e60beaf76f05c1954ec86eb&libraries=services,clusterer,drawing"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<script>

var geocoder = new kakao.maps.services.Geocoder();
var origin_div_doc = document.getElementById("origin_div");
var join = document.getElementById("join");
var img_index = 0;
var made_index= ${made_in_index}-1;
var store_name_check = document.getElementById("store_name_check");

store_name_check.onclick=store_name_check_function;
setTimeout(alert_function,200);


function get_position(result, status) {
	if (status === kakao.maps.services.Status.OK) {
		console.log(result);

        document.getElementById('store_address_longitude').value = result[0].x;
        document.getElementById("store_address_latitude").value = result[0].y;
		console.log(result[0].x); //owner_address_longitude
		console.log(result[0].y); //owner_address_latitude
	}
}

function get_address() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            console.log(data);
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address_line").value = roadAddr;
            //document.getElementById("address").style.display= block; //" = roadAddr;
            console.log(roadAddr);
            //console.log(document.getElementById("address"));
            console.log('종료1');
            
            geocoder.addressSearch(roadAddr, get_position);
        }
    }).open();
    console.log('종료2');
}

function add_origin(){
    made_index++;
    var out = origin_div_doc.innerHTML
    $("#origin_div").append(` <input class="input-origin" required name="store_made_in_arr" id="store_made_in_left_`+made_index+`"
			placeholder="Registe Number" /> <span id="span_`+made_index+`">:</span> <input class="input-origin" required name="store_made_in_arr" id="store_made_in_right_`+made_index+`"
			placeholder="Registe Number" /> <br> `);
}
function remove_origin(){
    document.getElementById("store_made_in_left_"+made_index).remove();
    document.getElementById("store_made_in_right_"+made_index).remove();
    document.getElementById("span_"+made_index).remove();
    made_index--;
}

function store_name_check_function() {
	var store_name_value = document.getElementById("store_name").value;
	console.log(store_name_value);
	var store_name_object = {
		"store_name" : store_name_value
	};
	console.log(store_name_value);
	console.log(store_name_object);
	console.log("${path}/storeInsert/storeNameCheck.do");
	$.ajax({
		type : "POST",
		url : "storeNameCheck.do",
		data : store_name_object,
		success : function(res) {
			 if (res.result == true) {
				join.disabled = true;
				alert('.');
			} else {
				join.disabled = false;
				alert('중복된 아이디가 없습니다.');
			} 
		},
		error : function() {
			alert('ajex 실패');
		}
	});
}
function alert_function(){
	var message = "${message}";
	console.log(message);
	if (message != "") {
		alert(message);
	}
}

//var thumbnail = 
function setThumbnail(event) {
    var reader = new FileReader();

    console.log(event.target.id);
	var img_id = event.target.id.split('_')[0];
    console.log("event",event);
    
    reader.onload = function(event) {
    var img = document.getElementById("0_img");
    img.src=event.target.result;
     /* img.setAttribute("src", event.target);
     img.setAttribute("id", img_id+"_"+"img"); */
    console.log(event.target.id);
    console.log(event.target);
    console.log(img);
     //document.querySelector("div#img_container").appendChild(img);
   };
    reader.readAsDataURL(event.target.files[0]);
 }
function setImgPath(event) {
    var reader = new FileReader();

    console.log(event.target.id);
	var img_id = event.target.id.split('_')[0];
    console.log("event",event);
    
    reader.onload = function(event) {
    var img = document.getElementById("1_img");
    img.src=event.target.result;
     /* img.setAttribute("src", event.target);
     img.setAttribute("id", img_id+"_"+"img"); */
    console.log(event.target.id);
    console.log(event.target);
    console.log(img);
     //document.querySelector("div#img_container").appendChild(img);
   };
    reader.readAsDataURL(event.target.files[0]);
 }


function imgs_chage(event) {
	var index=event.target.value;
		console.log(index,img_index);
		for(let i =0; i< img_index;i++){
			if(index==i){
				document.getElementById(i+'_img').style.display="block";
				//document.getElementById(i+'_img_input').style.display="block";
				document.getElementById(i+'_file').style.display="block";
			}else{
				document.getElementById(i+'_img').style.display="none";
				//document.getElementById(i+'_img_input').style.display="none";
				document.getElementById(i+'_file').style.display="none";
			}
		}
	
}

function add_img_function(){
	//var img_input = document.createElement("input");
	var option = document.createElement("option");
	var img_pring = document.createElement("img");
	
	img_pring.setAttribute("src", "${path}/resources/images/notStoreImg.png");
	img_pring.setAttribute("id", img_index+"_"+"img");
	//img_input.setAttribute("name", "imgs_source");
	
    
	//img_input.type="file";
	//img_input.id=img_index+"_file";
	//img_input.onchange= thumbnail;
	
	option.value=img_index;
	
	if(img_index!=0){
		//img_pring.style.display="none";
		//img_input.style.display="none";
		option.innerText=img_index+": 대표이미지";
	}else{
		option.innerText=img_index+": 썸네일이미지";
	}
	console.log(option);
	
	
	document.querySelector("#imgs").appendChild(option);
    document.querySelector("div#img_container").appendChild(img_pring);
    //document.querySelector("div#file").appendChild(img_input);
	img_index++;
}
</script>