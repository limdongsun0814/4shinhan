<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <!-- path 어떻게 해야할 지 생각하기 -->
 <button
            class="paymentStatus"
            onclick="sendStatus(this);"
            data-status="${paystatus.payment_status_id}"
            data-seq="${paystatus.payment_seq}"
            data-path="${path}"
            data-get="${paystatus.payment_get_id }"
            data-member_id = "${member_id }"
          >
</button>

          
