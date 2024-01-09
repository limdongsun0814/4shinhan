package com.shinhan.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.PaymentGetVO;

@Repository
public class PaymentGetDAO {
	@Autowired
	SqlSession sqlSession;
	String namespace = "net.firstzone.payment."; 
	Logger logger = LoggerFactory.getLogger(PaymentDAO.class);
	
	public List<PaymentGetVO> sellectAllPaymentGet(){
		List<PaymentGetVO> paymentGetList = sqlSession.selectList(namespace + "sellectAllPaymentGet");
		logger.info(getClass().getSimpleName()+" 전체 :"+paymentGetList.size()+"건");
		return paymentGetList;
	}
	
}
