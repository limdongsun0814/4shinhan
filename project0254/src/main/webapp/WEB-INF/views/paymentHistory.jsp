<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment History | 빵이오4</title>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js'></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/payment.css">
	<style>
		#calendar{
			width:90%;
			text-align:center;
			margin-left:5%;
		}
		.inner_calendar{
			margin-top:auto;
			margin-left:auto;
			padding-right:5px;
			padding-bottom:3px;
		} 
		
		.inner_calendar > p{
			margin:0;
			padding-left:5px;
			text-align:right;
			font-size:0.8rem;	
		}
		
		.fc .fc-bg-event{
			opacity:1 !important;
			display:flex;
			align-items:center;
	
		}
		.pagenation {
			text-align:center;
			margin-top:5px;
			font-size:1rem;
			font-weight:500;
		}
		.pagenation span{
			margin-right:5px;
		}
	</style>
    <script>
  	//페이징용 페이지번호 초기화
    let currentPage = 1;
    const rowsPerPage = 5;
    
    window.onload = function(){
    	//const today = new Date().getTime();
    	//var data = getCalendar(today);
    	realTimeClock();
    }
    
    
    //dom load에서 불러오기
    document.addEventListener('DOMContentLoaded', function(){
    	let array = [];
    	var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',
       // prev 버튼 클릭 이벤트 핸들러
       	  headerToolbar: {
				start: 'prev', // 이전 달 버튼
				center: 'title',
				end: 'next' // 다음 달 버튼
		  },
          
          // next 버튼 클릭 이벤트 핸들러
          customButtons: {
        	prev: {
	              click: function() {
	                calendar.prev(); // 이전 달로 이동
	                //console.log(calendar.currentData.currentDate.getMonth()+1);
	              	//calendar.fetchEvents();
	                AjaxMonth(calendar.currentData.currentDate.getMonth()+1, calendar.currentData.currentDate.getFullYear(), calendar);
	                var target = document.querySelector("#table_container");
	              	var targetDetail = document.querySelector('#detail_container');
	                target.innerHTML = '';
	              	targetDetail.innerHTML = '';
	              }
	          },
            next: {
              click: function() {
                calendar.next(); // 다음 달로 이동
                //console.log("다음달");
                //calendar.fetchEvents();
                AjaxMonth(calendar.currentData.currentDate.getMonth()+1, calendar.currentData.currentDate.getFullYear(), calendar);
                var target = document.querySelector("#table_container");
              	var targetDetail = document.querySelector('#detail_container');
                target.innerHTML = '';
              	targetDetail.innerHTML = '';
              }
            }
          },
          fixedWeekCount:false,
          events:array,
          eventContent: function(arg) {
        	  var count = arg.event.extendedProps.count;
        	  var price = arg.event.extendedProps.price;
        	  var menuCount = arg.event.extendedProps.menuCount;
        	  
        	  var el = document.createElement('div');
        	  el.classList.add('inner_calendar');
        	  el.innerHTML = `<p>총 건수: \${count}</p>
        		  			  <p>매출액: \${price}</p>
        		  			  <p>판매 수량: \${menuCount}</p>`;
        	  //el.innerHTML = "총 건수: " + count + ", 매출액: " + price + ", 판매 수량: "+menuCount;
        	  
        	  // 이 객체를 반환합니다.
        	  return { domNodes: [el] };
          }
          
          
        });
        
        
        calendar.render();
        
        AjaxMonth(calendar.currentData.currentDate.getMonth()+1, calendar.currentData.currentDate.getFullYear(), calendar);    
        
        //여기서 붙이나?
	    //calendar.fetchEvents;
	    
	    
	    
        //
        /* calendar.on('dateClick', function(info) {
        	var calCell = document.querySelectorAll("#calendar td.fc-day");
        	calCell.forEach(function(element) {
        	  element.closest('td').style.border = "";
        	});
        	
        	info.jsEvent.target.closest('td').style.border = "2px solid black";

      	}); */
    	
    });
    
    
    //해당 Month 불러오기
    function AjaxMonth(month, year, calendar) {
    	realTimeClock();
        /* var month = calendar.currentData.currentDate.getMonth()+1;
        var year = calendar.currentData.currentDate.getFullYear(); */
/* 	        console.log(month);
		console.log("현재 날짜 yyyy-mm-dd", month);
		console.log("현재 날짜 yyyy-mm-dd", year); */
		responseData = "";
        $.ajax({
          url: '${pageContext.request.contextPath}/paymentHistoryList.do',
          type: 'GET',
          data: {
            'webMonth': month,
            'webYear': year,
          },
          async: false,
          success: function(responseData) {
/* 	        	//날짜별 개수 세기
        	console.log("ajax 다녀옴");
        	console.log(responseData); */
        		calendar.removeAllEvents();//기존 event 제거
        		console.log(responseData);
				let countByDate = {};
        		let priceByDate = {};
        		let menuCountByDate = {};
				responseData.forEach(function(e){
					let dateString = formatDate(e['payment_date']);
					
					if (countByDate[dateString]) {
					  countByDate[dateString]++;
					  priceByDate[dateString] = priceByDate[dateString] + e['totalPrice'] - e['totalDiscountPrice'];
					  menuCountByDate[dateString] = menuCountByDate[dateString] + e['totalCount'];

					} else {
					  countByDate[dateString] = 1;
					  priceByDate[dateString] = e['totalPrice'] - e['totalDiscountPrice'];
					  menuCountByDate[dateString] = e['totalCount'];
					}
				});
				console.log("count by date 마지막",countByDate);
				//개수 Object map으로 바꿔서 일자별 순차 처리.
				let countArray = new Array();
				array = [];
				countArray = Object.entries(countByDate).map(function([date, count]) {
					  if (count >= 10) {
					    array.push(new makeData(date, "#F8C9DF", count, priceByDate[date], menuCountByDate[date]));
					  } else if (count >= 5) {
						  array.push(new makeData(date, "#B1D6E4", count, priceByDate[date], menuCountByDate[date]));
					  } else {
						  array.push(new makeData(date, "#D8F49C", count, priceByDate[date], menuCountByDate[date]));
					  }
				});
				
	            
	            calendar.off('dateClick'); //기존 click 이벤트 제거
	              
	            calendar.on('dateClick', info => dateClickFunc(info, countByDate, priceByDate, menuCountByDate, responseData));
				
				//console.log("countArray", countArray);
				// 받아온 이벤트 데이터를 달력에 추가(색깔 추가)
	            calendar.addEventSource(array);
				//날짜 따라 클릭 시 보여주는 이벤트 추가
				console.dir(calendar);
				

	            // 달력을 다시 렌더링
	            calendar.render();
            
          },
          error: function() {
            console.log('이벤트를 가져오는데 실패하였습니다.');
          }
        });
      
    
    };
    
    function dateClickFunc(info, countByDate, priceByDate, menuCountByDate, responseData) {
		//선택 시 검정 테두리
    	var calCell = document.querySelectorAll("#calendar td.fc-day");
    	calCell.forEach(function(element) {
    	  element.closest('td').style.border = "";
    	});
    	
    	info.jsEvent.target.closest('td').style.border = "2px solid black";
	  
 
    	// 주문 내역 불러오기
    	showPaymentList(responseData, info.dateStr, countByDate, priceByDate, menuCountByDate);
  	}
    
    
    function formatDate(inputDate) {
    	var timestamp = inputDate;
		var date = new Date(timestamp);
    	  var year = date.getFullYear();
    	  var month = String(date.getMonth() + 1).padStart(2, '0');
    	  var day = String(date.getDate()).padStart(2, '0');
    	  return year + '-' + month + '-' + day;
    	}
    
    //calendar data 만들기
    function makeData(start, backgroundColor, count, totalPrice, menuCount){
    	this.start = start;
    	this.overlap = false;
        this.display = 'background';
    	this.backgroundColor = backgroundColor;
    	this.title = document.createElement('div');
    	this.extendedProps = {
    			count:count,
    			price:totalPrice,
    			menuCount:menuCount
    	}
    }
    
    function showPaymentList(responseData, date, countByDate, priceByDate, menuCountByDate){
    	var target = document.querySelector("#table_container");
    	var targetDetail = document.querySelector('#detail_container');
    	var count = countByDate[date]!==undefined?countByDate[date]:0;
    	var price = priceByDate[date]!==undefined?priceByDate[date]:0;
    	var menuCount = menuCountByDate[date]!==undefined?menuCountByDate[date]:0;
    	target.innerHTML = '';
    	targetDetail.innerHTML = '';
    	var output = `
    	<div style="display:flex; justify-content:space-between">
    		<h3>총 건수:\${count}건 | 매출액:\${price}원 | 판매수량:\${menuCount}개</h3>
    		<h3 class="select_date">\${date}</h3>
    	</div>
    	<table class="table history_table">
			<tr class="history_header">
				<th>주문</th>
				<th>메뉴</th>
				<th>상태</th>
				<th>총 수량</th>
				<th>금액</th>
			</tr>
    	`;

    	responseData.forEach(function(e){
     		if(formatDate(e['payment_date'])==date){
     			output += 
     			`<tr class="history_row" data-seq="\${e['payment_seq']}">
     				<td>\${e['payment_get_content']}\${e['payment_seq']}</td>
     				<td class="abstract_menu_name">\${e['abstract_menu_name']}</td>
     				<td>\${e['payment_status_name']}</td>
     				<td>\${e['totalCount']}</td>
     				<td>\${e['totalPrice'] - e['totalDiscountPrice']}</td>

     			</tr>
     			`;
     		} 
     	}); 
    	
    	var page = `<div class="pagenation">`;
    	for(let i=0; i<count/rowsPerPage; i++){
    		page += `
    			<span onclick='goToPage(this)'>\${i+1}</span>
    		`;	
    	}
    	console.log("길이:",count);
    	
    	target.innerHTML = output+"</table>" + page + "</div>";
    	var cols = document.querySelectorAll('.history_row')
    	cols.forEach(function(col) {
    		col.addEventListener("click", function(e){
    			var targetSeq = e.target.parentNode.dataset.seq;
				const targetObj = responseData.find(obj => obj.payment_seq === parseInt(targetSeq));
				showDetailHistory(targetObj);
    		});
		});
    	
    	displayFirst();
    	
    }
    
    
 // 테이블의 모든 행을 가져옵니다.
    function displayRows() {
    	
      var rows = document.querySelectorAll('.history_table .history_row');
    	console.log("행 숨기기", rows);
      // 먼저 모든 행을 숨깁니다.
      for (let i = 0; i < rows.length; i++) {
        rows[i].style.display = 'none';
      }

      // 현재 페이지에 해당하는 행만 보여줍니다.
      const start = (currentPage - 1) * rowsPerPage;
      const end = start + rowsPerPage;
      for (let i = start; i < end && i < rows.length; i++) {
        rows[i].style.display = '';
      }
      
    }

    //첫 페이지 보이기(처음 해당일 누를 때)
    function displayFirst() {
    	
    	  var rows = document.querySelectorAll('.history_table .history_row');
    		console.log("행 숨기기", rows);
    	  // 먼저 모든 행을 숨깁니다.
    	  for (let i = 0; i < rows.length; i++) {
    	    rows[i].style.display = 'none';
    	  }

    	  // 현재 페이지에 해당하는 행만 보여줍니다.
    	  const start = 0;
    	  const end = start + rowsPerPage;
    	  for (let i = start; i < end && i < rows.length; i++) {
    	    rows[i].style.display = '';
    	  }
    	  
    	  btn = document.querySelector('.pagenation span');
    	  btn.style.fontWeight = 600;
    	  
    	}

    // 페이지를 이동하는 함수입니다.
    function goToPage(element) {
		btns = document.querySelectorAll('.pagenation span');
		btns.forEach((b)=>{
			console.log("b임", b);
			
			b.style.fontWeight=500;
		})
		
    	
    	element.style.fontWeight = 600;
      	currentPage = element.textContent;
      	displayRows();
    }
    
    
    function DateKR(timestamp){
    	const date = new Date(timestamp);
    	const options = { year: 'numeric', month: 'long', day: 'numeric', hour: 'numeric', minute: 'numeric', second: 'numeric', hour12: false };
    	const formattedDateTime = date.toLocaleString('ko-KR', options);
    	return formattedDateTime;
    }
    
    
    function showDetailHistory(e){
    	var detailContainer = document.querySelector('#detail_container');
    	var output = `
    	<div class="payment_container">
    	  <div class="payment_title flexbox">
    	  	<h3>\${e['payment_get_content']} \${e['payment_seq']}</h3>
    	  	<div class="paymentStatus">\${e.payment_status_name}
    	  	</div>
    	  </div>
    	  <div class="payment_text_container">
    	    <div class="flexbox payment_request">
    	      <div class="req_title">요청사항</div>
              <div class="req_content">\${e.payment_request_content}</div>
    	    </div>
    	    <div class="flexbox payment_member_info">
              <div class="req_title">주문자연락처</div>
              <div class="req_content">\${e.member_phone}</div>
            </div>
    	    <div class="flexbox payment_address_info" style="display:\${e.payment_get_id===2?'none':'flex'}">
    	      <div class="req_title">주소</div>
    	      <div class="req_content">
    	        <span>\${e.payment_address} </span>
                <span>\${e.payment_address_detail} </span>
              </div>
            </div>
    	  </div>
    	  <div class="payment_order_container">
    	  	<div class="flexbox payment_order_info">
          	  <h6>주문정보</h6>
          	  <div class="order_time">\${DateKR(e.payment_date) }
          	  </div>
        	</div>
        	<div class="payment_product_container">
        	  <div class="product_row">
        	    <h4 class="product_head">메뉴</h4>
                <h4>수량</h4>
                <h4>할인액</h4>
                <h4>금액</h4>
        	  </div>
              
        	`;
    	$.ajax({
    		url:"${pageContext.request.contextPath}/paymentHistoryProduct.do",
    		type:"get",
    		data:{
    			"payment_seq":e['payment_seq'],
    		},
    		success: function(responseData){
    			
    			responseData.forEach(function(product){
    				output += `
    					<div class="product_row">
    					  <h4 class="product_menu">\${product['payment_product_menu_name']}</h4>
        				  <h4>\${product['payment_product_count']}</h4>
        				  <h4>\${product['payment_product_discount_price']}</h4>
        				  <h4>\${product['payment_product_price']}</h4>
        				</div>
    				`;
    			});
    			output+=`
    			<div class="product_row">
    				<h4 class="product_head">총액</h4>
    				<h4>\${e.totalCount}</h4>
    				<h4></h4>
    				<h4>\${e.totalPrice - e.totalDiscountPrice}</h4>
    			</div>
    			`;
    			detailContainer.innerHTML = output +"</div></div></div>";
    		},
    		error: function(){
				console.log("error");
			}
    	}) 
    	
    }
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/clock.js" type="text/javascript"></script>
    
    <link href="${pageContext.request.contextPath}/resources/css/paymentHistory.css" rel="stylesheet" type="text/css">
    
</head>
<body>
<%@ include file="/WEB-INF/views/common/ownerHeader.jsp"%>
<div class="all">
<div class="side">
	<%@ include file="/WEB-INF/views/common/ownerSideBar.jsp"%>
</div>
<div class="all_container">
<div class="goButton" onclick="location.href='storeCalculate.do'">
	<img src="./resources/images/calculator-linear.svg">
	<div>가게분석 가기</div>
</div>
<div class="color_legend">
	<div class="color_box flexbox">
		<div class="color ten"></div>
		<div> 10건 이상</div>
	</div>
	<div class="color_box flexbox">
		<div class="color five"></div>
		<div> 5건 이상</div>
	</div>
	<div class="color_box flexbox">
		<div class="color one"></div>
		<div> 1건 이상</div>
	</div>
<!-- 	<div class="color_box flexbox">
		<div>오늘: </div>
		<div class="color today"></div>
	</div> -->
</div>
<div class="flexbox" id="title_box">
	<h3 class="owner_title">주문이력</h3>
	<h4>현재 시간: <span id="clock"></span></h4>
</div>
	<div id='calendar'></div>
	<div id='table_container'></div>
	<div id="detail_container"></div>
</div>
</div>
<%@ include file="/WEB-INF/views/common/ownerFooter.jsp"%>
</body>
<script>

</script>
</html>