package com.shinhan.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.StoreNoticeDTO;
import com.shinhan.dto.StoreNoticeVO;

@Service
public class StoreNoticeService {

	@Autowired
	StoreNoticeDAO sndao;
	
	StoreNoticeDTO sndto;
	StoreNoticeVO snvo;



	public List<StoreNoticeVO> StoreNoticeList(int store_notice_store_id) {
		return sndao.StoreNoticeList(store_notice_store_id);

	}

	public StoreNoticeVO StoreNoticeSelect(int store_notice_seq) {
		return sndao.StoreNoticeSelect(store_notice_seq);
	}
	
	public int StoreNoticeUpdate(StoreNoticeVO storeNotice) {
		return sndao.StoreNoticeUpdate(storeNotice);
	}

	public int StoreNoticeInsert(StoreNoticeDTO storeNotice) {
		return sndao.StoreNoticeInsert(storeNotice);
	}
	
	public int StoreNoticeDelete(int store_notice_seq) {
		return sndao.StoreNoticeDelete(store_notice_seq);
	}
	
	
}
