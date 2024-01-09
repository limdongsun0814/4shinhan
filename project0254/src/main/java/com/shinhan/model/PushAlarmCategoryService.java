package com.shinhan.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.PushAlarmCategoryVO;
@Service
public class PushAlarmCategoryService {
	
	@Autowired
	PushAlarmCategoryDAO pcdao;
	
	/*
	 * public List<MenuVO> selectAllByStoreId(int store_id) { return
	 * dao.selectAllByStoreId(store_id); }
	 */
	
	
	public List<PushAlarmCategoryVO> PushAlarmCategorySelect() {
		return pcdao.PushAlarmCategorySelect();
	}
}
