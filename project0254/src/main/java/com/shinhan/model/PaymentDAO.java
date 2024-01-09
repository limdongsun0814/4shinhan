package com.shinhan.model;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.MemberIpDTO;
import com.shinhan.dto.PayStatusDTO;
import com.shinhan.dto.PaymentDTO;
import com.shinhan.dto.PaymentProductVO;
import com.shinhan.dto.PaymentVO;

@Repository
public class PaymentDAO {
	@Autowired
	SqlSession sqlSession;
	String namespace = "net.firstzone.payment.";
	Logger logger = LoggerFactory.getLogger(PaymentDAO.class);
	
	
	public List<PaymentVO> selectNowPaymentByStoreId(int store_id){
		List<PaymentVO> paymentListNow = sqlSession.selectList(namespace + "selectNowPaymentByStoreId", store_id);
		//logger.info(getClass().getSimpleName() + "가게 현재 주문: " +paymentListNow.size()+"건");
		return paymentListNow;
	}
	
	public List<PaymentProductVO> selectProductByPaymentId(int payment_id){
		List<PaymentProductVO> paymentProductList = sqlSession.selectList(namespace + "selectProductByPaymentId", payment_id);
		//logger.info(getClass().getSimpleName() + "가게 주문 품목: " +paymentProductList.size()+"건");
		return paymentProductList;
	}
	
	public List<MemberIpDTO> selectMemberPathByid(String ids){
		List<MemberIpDTO> memberIpList = sqlSession.selectList(namespace + "selectMemberPathByid", ids);
		return memberIpList;
	}

	public List<PaymentDTO> selectNowPaymentDTOByStoreId(int store_id){
		List<PaymentDTO> paymentListNow = sqlSession.selectList(namespace + "selectNowPaymentDTOByStoreId", store_id);
		//logger.info(getClass().getSimpleName() + "가게 현재 주문: " +paymentListNow.size()+"건");
		return paymentListNow;
	}
	
	public int updatePaymentStatus(PayStatusDTO payStatus) {
		int result = sqlSession.update(namespace+"updatePaymentStatus", payStatus);
		return result;
	}
	
	
	
	
}
