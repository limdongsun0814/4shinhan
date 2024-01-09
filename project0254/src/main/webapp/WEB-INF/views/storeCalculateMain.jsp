<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
<!DOCTYPE html>
<html>
<head>
<style>
.all_wrapper {
	padding:0 10%;
	width:100%;
	position:relative;
}
.goTop{
	top:9%;
}
.goBottom{
	top:18%;
}
.goButton{
    	position:absolute;
    	right:5%;
    	text-align:center;
    }
    .goButton > img {
    	width:1.8rem;
    }
    .goButton div{
    	font-weight:600;
    	font-size:0.8rem;
    }
.all_wrapper > h1 {
	text-align:center;
}
.buttons_wrapper, .dates{
	width:100%;
	justify-content:space-between;
}
.button > input {
	margin-right:5px;
}
.dates > input {
	width:30%;
}
.buttons_wrapper {
	margin-bottom:10px;
}
.dates {
	margin-bottom:20px;
}
.calculate_wrapper {
	display:grid;
	grid-template-columns:1fr 1fr;
	grid-gap:10px;
}

.no_canvas {
	text-align:center;
	padding:8rem 0;
	/* color:#a6a6a6; */
}
.no_canvas img{
	width:2.5rem;
}
.no_canvas h2 {
	font-size:1.5rem;
}

.no_display{
	display:none;
}

</style>
<meta charset="UTF-8">
<title>Calculate | 빵이오4</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</head>

<body>
<%@ include file="/WEB-INF/views/common/ownerHeader.jsp"%>
<div class="all">
	<div class="side">
		<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>
	</div>
	<div class="all_wrapper">
		<div class="goButton goTop" onclick="location.href='paymentHistory.do'">
			<img src="./resources/images/calendar-broken.svg">
			<div>주문내역 가기</div>
		</div>
		<div class="goButton goBottom" onclick="getAllByMonth()">
			<img src="./resources/images/calendar-broken.svg">
			<div>한달통계 보기</div>
		</div>
		<h1>${store.store_name} 통계</h1>
		<div class="flexbox buttons_wrapper">
			<label for="option">옵션 선택:</label>
				<div class="flexbox button">
				<input type="checkbox" id="option-all" name="option" value="all">
			  	<label for="option-all">전체</label><br>
				</div>
				<div class="flexbox button">
				<input type="checkbox" id="option-DayCount" name="option" value="DayCount">
			  	<label for="option-DayCount">결제건수</label><br>
				</div>
				<div class="flexbox button">
				<input type="checkbox" id="option-DayPrice" name="option" value="DayPrice">
			  	<label for="option-DayPrice">결제액</label><br>
				</div>
				<div class="flexbox button">
				<input type="checkbox" id="option-MenuCount" name="option" value="MenuCount">
			  	<label for="option-MenuCount">메뉴 판매량</label><br>
				</div>
				<div class="flexbox button">
				<input type="checkbox" id="option-MenuPrice" name="option" value="MenuPrice">
			  	<label for="option-MenuPrice">메뉴별 금액 비율</label><br>
				</div>


			
		</div>
		<div class="flexbox dates">
			<label for="start-date">시작일:</label>
			  <input type="text" id="start-date" name="start-date" readonly><br>
			
			  <label for="end-date">종료일:</label>
			  <input type="text" id="end-date" name="end-date" readonly><br>
			  <button onclick="getSelectedOptions()">선택 확인</button>
		</div>
		<div class="no_canvas">
			<img src="./resources/images/calculator-linear.svg">
			<h2>날짜와 옵션을 선택해서 통계를 확인하세요!</h2>
		</div>
		<div class="calculate_wrapper">
			<div>
	  			<canvas id="myChart" class="chart"></canvas>
			</div>
			<div>
				<canvas id="dayPrice" class="chart"></canvas>
			</div>
			<div>
				<canvas id="doughnut" class="chart"></canvas>
			</div>
			<div>
				<canvas id="menuPrice" class="chart"></canvas>
			</div>
		</div>
	</div>
	
</div>
<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
</body>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
  <script>
    flatpickr("#start-date", {
      dateFormat: "Y-m-d",
      enableTime: false
    });

    flatpickr("#end-date", {
      dateFormat: "Y-m-d",
      enableTime: false
    });
  </script>
<script>
//차트 객체 전역으로 저장
var chart_array=[];
var colors = [];


//HTML 요소들을 가져옵니다.
const allCheckbox = document.getElementById('option-all');
const otherCheckboxes = document.querySelectorAll('input[name="option"]:not(#option-all)');

// all 버튼의 클릭 이벤트 리스너를 추가합니다.
allCheckbox.addEventListener('click', function() {
  if (allCheckbox.checked) {
    // all 버튼이 선택되었을 경우, 나머지 옵션들을 선택합니다.
    otherCheckboxes.forEach(function(checkbox) {
      checkbox.checked = true;
    });
  } else {
    // all 버튼이 선택 해제되었을 경우, 다른 옵션들을 선택 해제합니다.
    otherCheckboxes.forEach(function(checkbox) {
      checkbox.checked = false;
    });
  }
});




function getSelectedOptions() {
    var checkboxes = document.getElementsByName("option");
    var startDate = document.querySelector("#start-date").value;
    var inputDate = document.querySelector("#end-date");
    var selectedDate = new Date(inputDate.value);
    selectedDate.setDate(selectedDate.getDate() + 1);
    var endDate = selectedDate.toISOString().split('T')[0];
    
    //기존 차트 객체 있으면 destroy
    console.log(chart_array.length);
    for(let i=0; i<chart_array.length; i++){
    	chart_array[i].destroy();
    }
    

    
    var selectedOptions = [];
    
	var charts = document.querySelectorAll(".chart");
	
	
    for (var i = 0; i < checkboxes.length; i++) {
    	if(checkboxes[i].value === 'all'){
    		continue;
    	}
    	else if (checkboxes[i].checked) {
        	selectedOptions.push(checkboxes[i].value);
        }
    }
    
    if(checkboxes.length>0){
    	document.querySelector('.no_canvas').classList.add('no_display');
    } else {
    	document.querySelector('.no_canvas').classList.remove('no_display');
    }
    
    console.log(selectedOptions);
	
    for(var i=0; i<selectedOptions.length; i++){
    	console.log(selectedOptions[i]);
    	if(selectedOptions[i] === "DayCount"){
    		console.log("DayCount");
    		getAjaxResultByDay(startDate, endDate, "${pageContext.request.contextPath}/selectCalculateDayCount.do", charts[i], "일 별 결제건수");
    	} else if (selectedOptions[i] === "DayPrice"){
    		console.log("DayPrice");
    		getAjaxResultByDay(startDate, endDate, "${pageContext.request.contextPath}/selectCalculateDayPrice.do", charts[i], "일 별 결제액");
    	} else if (selectedOptions[i] === "MenuCount"){
    		console.log("MenuCount");
    		getAjaxResultByDoughnut(startDate, endDate, "${pageContext.request.contextPath}/selectDoughnutMenuCount.do", charts[i], "메뉴 별 개수비");
    	} else if (selectedOptions[i] === "MenuPrice"){
    		console.log("MenuPrice");
    		getAjaxResultByDoughnut(startDate, endDate, "${pageContext.request.contextPath}/selectDoughnutMenuPrice.do", charts[i], "메뉴 별 결제액비");
    	} 
    }
  }
  
	function getMonthDates() {
	  var startDate = new Date();
	  startDate.setMonth(startDate.getMonth() - 1);
	  var endDate = new Date();

	  var startYear = startDate.getFullYear();
	  var startMonth = ("0" + (startDate.getMonth() + 1)).slice(-2);
	  var startDateStr = ("0" + startDate.getDate()).slice(-2);

	  var endYear = endDate.getFullYear();
	  var endMonth = ("0" + (endDate.getMonth() + 1)).slice(-2);
	  var endDateStr = ("0" + endDate.getDate()).slice(-2);

	  var startDateString = startYear + "-" + startMonth + "-" + startDateStr;
	  var endDateString = endYear + "-" + endMonth + "-" + endDateStr;

	  return { startDate: startDateString, endDate: endDateString };
	}
  
  function getAllByMonth(){
	  console.log("한달 버튼");
	  //기존 차트 객체 destroy
	  console.log(chart_array.length);
	  for(let i=0; i<chart_array.length; i++){
	    	chart_array[i].destroy();
	    }
	  //초기 화면 안보이게 설정
	  document.querySelector('.no_canvas').classList.add('no_display');
	  
	  var dates = getMonthDates();
	  var startDate = dates.startDate;
	  var endDate = dates.endDate;
	  
	  //input 에 일자 표기
	  document.querySelector('#start-date').value = startDate;
	  document.querySelector('#end-date').value = endDate;
	  
	  console.log(startDate,endDate);
	  
	  
	  var charts = document.querySelectorAll(".chart");
	  //각각 4분할 1,2,3,4에 넣기
	  getAjaxResultByDay(startDate, endDate, "${pageContext.request.contextPath}/selectCalculateDayCount.do", charts[0], "일 별 결제건수");
	  getAjaxResultByDay(startDate, endDate, "${pageContext.request.contextPath}/selectCalculateDayPrice.do", charts[1], "일 별 결제액");
	  getAjaxResultByDoughnut(startDate, endDate, "${pageContext.request.contextPath}/selectDoughnutMenuCount.do", charts[2], "메뉴 별 개수비");
	  getAjaxResultByDoughnut(startDate, endDate, "${pageContext.request.contextPath}/selectDoughnutMenuPrice.do", charts[3], "메뉴 별 결제액비");
  }
  
  function getAjaxResultByDay(startDate, endDate, inputUrl, canvas, title){
	  $.ajax({
			url:inputUrl,
			data: {
				"startDate":startDate,
				"endDate":endDate	
			},
			success: function(responseData){
				console.log(responseData);
				drawDayCount(responseData.dateList, responseData.countList, canvas, title);
				
			},
			error: function(){
				console.log("error");
			}
		})
  }
  
  function getAjaxResultByDoughnut(startDate, endDate, inputUrl, canvas, intitle){
	  $.ajax({
			url:inputUrl,
			data: {
				"startDate":startDate,
				"endDate":endDate	
			},
			success: function(responseData){
				console.log(responseData);
				drawDoughnutByCategory(responseData.menuList, responseData.countList, canvas, intitle);
				
			},
			error: function(){
				console.log("error");
			}
		})
  }
  
  function drawDayCount(dateList, countList, ctx, title){
	  let dateStringList = dateList.map(timestamp => timestampToString(timestamp));
	  console.log(ctx);
		if (ctx && typeof ctx.destroy === 'function') {
			ctx.destroy();
			}
	  var chart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	      labels: dateStringList,
	      datasets: [{
	        label: '${store.store_name} '+title,
	        data: countList,
	        borderWidth: 1
	      }]
	    },
	    options: {
	      scales: {
	        y: {
	          beginAtZero: true
	        }
	      }
	    }
	  });
	  chart_array.push(chart);
	  
  }
  
  //메뉴 별 시 전체 판매 건수에서 일정 미만 차지하는 메뉴는 기타로 합치기. sql에서 확인해보기
  function drawDoughnutByCategory(labelList, dataList, ctx, intitle) {
	  console.log(colors);
	  if(colors.length === 0 || colors.length !== labelList.length){
		  colors = getRandomRGBColorList(labelList.length);
	  }
	  if (ctx && typeof ctx.destroy === 'function') {
			ctx.destroy();
			}
	  var chart = new Chart(ctx, {
	    type: 'doughnut',
	    data: {
	      labels: labelList,
	      datasets: [{
	        data: dataList,
	        backgroundColor: colors,
	        hoverOffset: 4
	      }]
	    },
	    options: {
	      responsive: true,
	      plugins: {
	        legend: {
	          position: 'top',
	        },
	        title: {
	            display: true,
	            text: intitle,
	            font: {
	              size: 16,
	              weight: 'bold'
	            }
	          },
	      },
	    },
	  });
	  chart_array.push(chart);
	}
  
  
  
  function timestampToString(timestamp) {
	    var date = new Date(timestamp);
	    var year = date.getFullYear();
	    var month = ("0" + (date.getMonth() + 1)).slice(-2);
	    var day = ("0" + date.getDate()).slice(-2);
	    return year + "-" + month + "-" + day;
	}
  
  
  //랜덤 RGB 색깔 리스트
  function getRandomRGBColorList(length) {
	  var colorList = [];
	  for (var i = 0; i < length; i++) {
	    var red = Math.floor(Math.random() * 256);
	    var green = Math.floor(Math.random() * 256);
	    var blue = Math.floor(Math.random() * 256);
	    var color = 'rgb(' + red + ', ' + green + ', ' + blue + ')';
	    colorList.push(color);
	  }
	  console.log(colorList);
	  return colorList;
	}


  
</script>
</html>