package com.shinhan.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.MenuVO;
import com.shinhan.dto.PushAlarmDTO;
import com.shinhan.dto.PushAlarmVO;

@Repository
public class PushAlarmDAO {
	@Autowired
	SqlSession sqlSession;
	String namespace = "net.firstzone.pushAlarm."; 
	Logger logger = LoggerFactory.getLogger(PushAlarmDAO.class);
	
	public int PushAlarmInsert(PushAlarmDTO pushAlarm) {
		System.out.println(pushAlarm);
		int result = sqlSession.insert(namespace + "PushAlarmInsert" , pushAlarm);
		
		logger.info(getClass().getSimpleName()+ pushAlarm);
		
		return result;
	}
	
	public PushAlarmVO pushAlarmResend(int push_alarm_id) {
		System.out.println(push_alarm_id);
		PushAlarmVO result = sqlSession.selectOne(namespace + "PushAlarmResend" , push_alarm_id);
		
		logger.info(getClass().getSimpleName()+ push_alarm_id);
		
		return result;
	}
	
	public List<PushAlarmVO> PushAlarmList(int push_alarm_store_id) {
		List<PushAlarmVO> pushalarmlist = sqlSession.selectList(namespace + "PushAlarmList" , push_alarm_store_id);
		return pushalarmlist;
	}
	

	
}
