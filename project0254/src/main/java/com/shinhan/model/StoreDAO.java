package com.shinhan.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.StoreImgPathVO;
import com.shinhan.dto.StoreVO;

@Repository
public class StoreDAO {
	@Autowired
	SqlSession sqlSession;
	String namespace = "net.firstzone.store.";
	
	public int close(StoreVO store) {
		int result=sqlSession.update(namespace + "storeClose", store);
		return result;
	}
	public int open(StoreVO store) {
		int result=sqlSession.update(namespace + "storeOpen", store);
		return result;
	}
	
	public List<StoreVO> selectStoreByOwnerId(String owner_id) {
		List<StoreVO> store = sqlSession.selectList(namespace + "selectStoreByOwnerId", owner_id);
		return store;
	}
	
	public StoreVO selectStoreByStoreId(int store_id) {
		StoreVO store = sqlSession.selectOne(namespace + "selectStoreByStoreId", store_id);
		return store;
	}
	
	public int updateStorePathById(int store_id, String store_ip_path) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("store_id", store_id);
		map.put("store_ip_path", store_ip_path);
		int result = sqlSession.update(namespace+"updateStorePathById", map);
		return result;
	}
	public int storeNameCheck(String store_name) {
		int result = sqlSession.selectOne(namespace+"storeNameCheck",store_name);
		return result;
	}
	public int storeInsert(StoreVO store) {
		int result = sqlSession.insert(namespace+"insertStore",store);
		return result;
	}
	public int storeUpdate(StoreVO store) {
		int result = sqlSession.update(namespace+"UpdateStore",store);
		return result;
	}
	public int storeImgPathInsert(StoreImgPathVO store) {
		int result = sqlSession.insert(namespace+"insertStoreImgPath",store);
		return result;
	}
}

