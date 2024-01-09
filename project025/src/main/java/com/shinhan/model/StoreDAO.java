package com.shinhan.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.HeartDTO;
import com.shinhan.dto.MenuCategoryVO;
import com.shinhan.dto.MenuTimeVO;
import com.shinhan.dto.MyReviewVO;
import com.shinhan.dto.StoreListDTO;
import com.shinhan.dto.StoreNoticeVO;
import com.shinhan.dto.StoreVO;
import com.shinhan.dto.StoreViewDTO;

@Repository
public class StoreDAO {
	
	@Autowired
	SqlSession sqlSession;
	String namespace = "com.shinhan.store.";
	
	// ��ü ���� ��ȸ
	public List<StoreListDTO> selectAll(Map positionMap) {
		List<StoreListDTO> storeList = sqlSession.selectList(namespace + "selectByDistanceOrderByStar", positionMap);
		System.out.println(storeList.toString());
		return storeList;
	}
	
	// Ư�� ���� ��ȸ
	public StoreVO selectById(int store_id) {
		StoreVO store = sqlSession.selectOne(namespace + "selectById", store_id);
		return store;
	}
	
	public List<MenuTimeVO> selectMenuNamesById(int store_id){
		List<MenuTimeVO> menuTimeList = sqlSession.selectList(namespace + "selectMenuNamesById", store_id);
		return menuTimeList;
	}
	
	// �˻� ��ȸ
	public List<StoreVO> selectByName(String keyword) {
		List<StoreVO> storeList = sqlSession.selectList(namespace + "selectByName", keyword);
		return storeList;
	}
	
	// ���� ���� ��ȸ
	public List<StoreVO> selectHeartStores(String member_id) {
		List<StoreVO> storeList = sqlSession.selectList(namespace + "selectByHeart", member_id);
		return storeList;
	}
	
	// �Ⱦ� ���� ���� ��ȸ
	public List<StoreVO> selectByIsPickup(String sort_type) {
		List<StoreVO> storeList = sqlSession.selectList(namespace + "selectByIsPickup");
		return storeList;
	}
	
	// ��� ���� ���� ��ȸ
	public List<StoreVO> selectByIsDelivery(String sort_type) {
		List<StoreVO> storeList = sqlSession.selectList(namespace + "selectByIsDelivery");
		return storeList;
	}
	
	// ���� ���� ���� ��ȸ
	public List<StoreVO> selectByIsSubscribe() {
		List<StoreVO> storeList = sqlSession.selectList(namespace + "selectByIsSubscribe");
		return storeList;
	}
	
	public int selectByHeart(HeartDTO heartDto) {
		
		return sqlSession.selectOne(namespace+"selectByHeartCnt", heartDto);
	}
	
	// ���� ���� �߰�
	public int insertHeartStore(HeartDTO heartDto) {
		
		return sqlSession.insert(namespace+"insertHeartStore", heartDto);
	}
	
	// ���� ���� ����
	public int deleteHeartStore(HeartDTO heartDto) {
		return sqlSession.delete(namespace+"deleteHeartStore", heartDto);
	}

	//가게 상세페이지 - 리뷰 보기
	public List<MyReviewVO> getStoreReviews(int store_id) {
		return sqlSession.selectList(namespace + "getStoreReviews", store_id);
	}

	//가게 상세페이지 - 찾아오시는 길
	public List<StoreVO> getStoreAddress(int store_id) {
		return sqlSession.selectList(namespace + "getStoreAddress", store_id);
	}

	//메인 - 구독 페이지
	public List<Map<Object, Object>> selectSubscribeStore() {
		return sqlSession.selectList(namespace + "selectSubscribeStore");
	}

	public List<StoreViewDTO> store_search(HashMap<String, Object> search){
		return sqlSession.selectList(namespace+"store_search",search);
	}

	public int selectHeartCount(int store_id) {
		return sqlSession.selectOne(namespace + "selectHeartCount", store_id);
	}

	public int selectReviewCount(int store_id) {
		return sqlSession.selectOne(namespace + "selectReviewCount", store_id);
	}

	/* 
	public List<StoreVO> selectOrderByStar(String order_type) {
		return sqlSession.selectList(namespace + "selectOrderByStar", order_type);
	}

	public List<StoreVO> selectOrderByDistance(String order_type) {
		return sqlSession.selectList(namespace + "selectOrderByDistance", order_type);
	}

	public List<StoreVO> selectOrderByReviewCount(String order_type) {
		return sqlSession.selectList(namespace + "selectOrderByReviewCount", order_type);
	}

	public List<StoreVO> selectOrderBySalesCount(String order_type) {
		return sqlSession.selectList(namespace + "selectOrderBySalesCount", order_type);
	}

	public List<StoreVO> selectOrderByHeartCount(String order_type) {
		return sqlSession.selectList(namespace + "selectOrderByHeartCount", order_type);
	}*/
	
	public List<StoreListDTO> selectOrderByStar(String order_type, Double lat, Double lng) {
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("order_type", order_type);
		map.put("lat", lat);
		map.put("lng", lng);
		
		return sqlSession.selectList(namespace + "selectByDistanceOrderByStar", map);
	}

	public List<StoreListDTO> selectOrderByDistance(String order_type, Double lat, Double lng) {
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("order_type", order_type);
		map.put("lat", lat);
		map.put("lng", lng);
		
		return sqlSession.selectList(namespace + "selectByDistanceOrderByDistance", map);
	}

	public List<StoreListDTO> selectOrderByReviewCount(String order_type, Double lat, Double lng) {
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("order_type", order_type);
		map.put("lat", lat);
		map.put("lng", lng);
		
		return sqlSession.selectList(namespace + "selectByDistanceOrderByReviewCount", map);
	}

	public List<StoreListDTO> selectOrderBySalesCount(String order_type, Double lat, Double lng) {
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("order_type", order_type);
		map.put("lat", lat);
		map.put("lng", lng);
		
		return sqlSession.selectList(namespace + "selectByDistanceOrderBySalesCount", map);
	}

	public List<StoreListDTO> selectOrderByHeartCount(String order_type, Double lat, Double lng) {
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("order_type", order_type);
		map.put("lat", lat);
		map.put("lng", lng);
		
		return sqlSession.selectList(namespace + "selectByDistanceOrderByHeartCount", map);
	}

	public List<StoreNoticeVO> selectNoticeAndEvent(int store_id) {
		return sqlSession.selectList(namespace + "selectNoticeAndEvent", store_id);
	}

	public String selectStoreMadeIn(int store_id) {
		return sqlSession.selectOne(namespace + "selectStoreMadeIn", store_id);
	}
	
}
