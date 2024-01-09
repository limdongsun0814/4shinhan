<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
  <head>
	<link href="${pageContext.request.contextPath}/resources/css/paymentHistory.css" rel="stylesheet" type="text/css">
	<!--  <link href="${pageContext.request.contextPath}/resources/css/payment.css" rel="stylesheet" type="text/css"> -->
	<style>
  	.title_abstract{
  		align-items:center;
  		gap: 0 10px;
  	}
  	.payment_container {
  		margin-bottom:20px;
  	}
  	.payment_order_container{
  		padding:15px 20px 10px;
  		margin:10px 0;
  	}
  	.payment_product_container{
  		background-color:#fff;
  		margin-top:5px;
  	}
  	.payment_title{
  		padding:5px 1rem;
  	}
  	.req_content {
  		margin: 15px 10px;
  	}
  	.address_content{
  		margin:0 10px 10px;
  	}
  	.address_title{
  		margin-bottom: 10px; 
  	}
  	.payment_request {
  		height:6rem;
  	}
  	

  	</style> 
  </head>

    <c:forEach items="${paymentListNow}" var="payment">
      <div class="payment_container">
        <div class="payment_title flexbox">
          <h3>
            <c:forEach items="${paymentGetList}" var="paymentGet">
              <c:if
                test="${paymentGet.payment_get_id == payment.payment_get_id}"
              >
                <span
                  class="payment_get"
                  data-get="${paymentGet.payment_get_id}"
                >
                  ${paymentGet.payment_get_content}
                </span>
              </c:if>
            </c:forEach>
            ${payment.payment_seq}
          </h3>
          <div class="flexbox title_abstract">
            <h3>메뉴 ${payment.totalCount } 개</h3>
            <span><b>-</b></span>
            <h3>${payment.totalPrice - payment.totalDiscountPrice} 원</h3>
            <span><b>-</b></span>
            <h3>${payment.payment_type_name}</h3>
          </div>
          <button
            class="paymentStatus"
            onclick="sendStatus(this);"
            data-status="${payment.payment_status_id}"
            data-seq="${payment.payment_seq}"
            data-path="${payment.member_ip_path}"
            data-get="${payment.payment_get_id }"
            data-member_id = "${payment.payment_member_id }"
          >
            상태전송
          </button>
        </div>
        <div class="payment_text_container">
          <div class="flexbox payment_request">
            <div class="req_title">요청사항</div>
            <div class="req_content">${payment.payment_request_content }</div>
          </div>
          <div class="flexbox payment_member_info">
            <div class="req_title">주문자연락처</div>
            <div class="req_content">${payment.member_phone}</div>
          </div>
          <c:if
            test="${payment.payment_get_id==1 || payment.payment_get_id==3}"
          >
            <div class="flexbox payment_member_info">
              <div class="req_title address_title">주소</div>
              <div class="req_content address_content">
              	<span>${payment.payment_address} </span>
              	<span>${payment.payment_address_detail} </span>
              </div>
              
            </div>
          </c:if>
          
        </div>
        <div class="payment_order_container">
          <div class="flexbox payment_order_info">
            <h6>주문정보</h6>
            <div>${payment.payment_date }</div>
          </div>
          <!-- 품목 map에 저장되어있는 품목 리스트 -->
          <div class="payment_product_container">
            <div class="product_row">
        	    <h4 class="product_head">메뉴</h4>
                <h4>수량</h4>
                <h4>할인액</h4>
                <h4>금액</h4>
        	  </div>
            <c:forEach
              items="${paymantProductMap[payment.payment_seq]}"
              var="paymentProduct"
            >
              <div class="product_row">
                <h4 class="product_menu">${paymentProduct.payment_product_menu_name}</h4>
                <h4>${paymentProduct.payment_product_count}개</h4>
                <h4>${paymentProduct.payment_product_discount_price}원</h4>
                <h4>${paymentProduct.payment_product_price}원</h4>
              </div>
            </c:forEach>
          </div>
        </div>
      </div>
    </c:forEach>
    <script>
    var titles = document.querySelectorAll(".payment_title");
	console.log(titles);
	for(var i = 0; i < titles.length; i++){
		
		if(titles[i].children[0].children[0].dataset.get == 1){
			titles[i].style.backgroundColor = "#D8F49C";
		} else if(titles[i].children[0].children[0].dataset.get == 2){
			titles[i].style.backgroundColor = "#FFEC9F";
		}	
	}
	
	var paymentOn = document.querySelector("#paymentOn");
	paymentOn.addEventListener('click', ()=>{
		
	});
	
    </script>

