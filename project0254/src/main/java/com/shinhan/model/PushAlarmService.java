package com.shinhan.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.PushAlarmDTO;
import com.shinhan.dto.PushAlarmVO;
@Service
public class PushAlarmService {
	
	@Autowired
	PushAlarmDAO pdao;
	
	/*
	 * public List<MenuVO> selectAllByStoreId(int store_id) { return
	 * dao.selectAllByStoreId(store_id); }
	 */
	
	
	public int PushAlarmInsert(PushAlarmDTO pushAlarm) {
		return pdao.PushAlarmInsert(pushAlarm);
	}
	
	public PushAlarmVO pushAlarmResend(int push_alarm_id) {
		return pdao.pushAlarmResend(push_alarm_id);
	}
	
	
	
	public List<PushAlarmVO> PushAlarmList(int push_alarm_store_id){
		return pdao.PushAlarmList(push_alarm_store_id);
	}
}
