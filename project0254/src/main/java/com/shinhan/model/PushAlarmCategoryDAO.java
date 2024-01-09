package com.shinhan.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.PushAlarmCategoryVO;
import com.shinhan.dto.PushAlarmDTO;

@Repository
public class PushAlarmCategoryDAO {
	@Autowired
	SqlSession sqlSession;
	String namespace = "net.firstzone.pushAlarm."; 
	Logger logger = LoggerFactory.getLogger(PushAlarmCategoryDAO.class);
	
	public List<PushAlarmCategoryVO> PushAlarmCategorySelect() {
		System.out.println();
		
		List<PushAlarmCategoryVO> pushalarmcategory = sqlSession.selectList(namespace + "PushAlarmCategorySelect");
		logger.info(getClass().getSimpleName()+ pushalarmcategory);
		
		return pushalarmcategory;
	}


	
	
}
