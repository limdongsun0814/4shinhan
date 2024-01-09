package com.shinhan.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.StoreImgPathVO;
import com.shinhan.dto.StoreVO;

@Service("sService")
public class StoreService {
	@Autowired
	StoreDAO dao;
	
	public int close(StoreVO store) {
		return dao.close(store);
	}
	public int open(StoreVO store) {
		return dao.open(store);
	}
	
	public List<StoreVO> selectStoreByOwnerId(String owner_id) {
		return dao.selectStoreByOwnerId(owner_id);
	}
	
	public StoreVO selectStoreByStoreId(int store_id) {
		return dao.selectStoreByStoreId(store_id);
	}
	
	
	public int updateStorePathById(int store_id, String store_ip_path) {
		return dao.updateStorePathById(store_id, store_ip_path);
	}

	public int storeNameCheck(String store_name) {
		return dao.storeNameCheck(store_name);
	}
	public int storeUpdate(StoreVO store) {
		return dao.storeUpdate(store);
	}
	public int storeInsert(StoreVO store) {
		return dao.storeInsert(store);
	}
	public int storeImgPathInsert(StoreImgPathVO store) {
		return dao.storeImgPathInsert(store);
	}
}
