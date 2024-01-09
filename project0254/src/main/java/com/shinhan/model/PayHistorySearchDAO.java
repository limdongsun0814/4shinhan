package com.shinhan.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.PayHistorySearchDTO;
import com.shinhan.dto.PaymentDTO;
import com.shinhan.dto.PaymentVO;

@Repository
public class PayHistorySearchDAO {
	@Autowired
	SqlSession sqlSession;
	String namespace = "net.firstzone.payment.";
	Logger logger = LoggerFactory.getLogger(PayHistorySearchDAO.class);
	
	
	public List<PaymentDTO> payHistorySearchByMonth(PayHistorySearchDTO payHistory){
		List<PaymentDTO> paymentListMonth = sqlSession.selectList(namespace + "payHistorySearchByMonth", payHistory);
		return paymentListMonth;
	}
	
}
