package com.shinhan.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.HeartDTO;
import com.shinhan.dto.MenuCategoryVO;
import com.shinhan.dto.MenuTimeVO;
import com.shinhan.dto.MyReviewVO;
import com.shinhan.dto.StoreListDTO;
import com.shinhan.dto.StoreNoticeVO;
import com.shinhan.dto.StoreVO;
import com.shinhan.dto.StoreNoticeVO;
import com.shinhan.dto.StoreViewDTO;


@Service
public class StoreService {

	@Autowired
	StoreDAO dao;
	
	// ��ü ���� ��ȸ
	public List<StoreListDTO> selectAllStores(Double lat, Double lng) {
		Map<String, Double> positionMap=new HashMap<String, Double>();
		positionMap.put("lat", lat);
		positionMap.put("lng", lng);
		return dao.selectAll(positionMap);
	}
	
	// Ư�� ���� ��ȸ (����ID)
	public StoreVO selectOne(int store_id) {
		return dao.selectById(store_id);
	}
	
	// ���� �˻� (���� �̸�)
	public List<StoreVO> searchStoresByName(String keyword) {
		return dao.selectByName(keyword);
	}
	
	// ���� ���� ��ȸ
	public List<StoreVO> getHeartStores(String member_id) {
		return dao.selectHeartStores(member_id);
	}
	
	// �Ⱦ� ���� ���� ��ȸ
	public List<StoreVO> getPickupStores(String sort_type){
		return dao.selectByIsPickup(sort_type);
	}
	
	// ��� ���� ���� ��ȸ
	public List<StoreVO> getDeliveryStores(String sort_type){
		return dao.selectByIsDelivery(sort_type);
	}
	
	// ���� ���� ���� ��ȸ
	public List<StoreVO> getSubscribeStores(){
		return dao.selectByIsSubscribe();
	}

	public int selectByHeart(HeartDTO heartDto) {
		return dao.selectByHeart(heartDto);
	}
	// ���� ���� �߰�
	public int addHeartStore(HeartDTO heartDto) {
		return dao.insertHeartStore(heartDto);
	}
	// ���� ���� ����
	
	public int deleteHeartStore(HeartDTO heartDto) {
		return dao.deleteHeartStore(heartDto);
	}
	
	//가게 상세페이지 - 리뷰 보기
	public List<MyReviewVO> getStoreReviews(int store_id) {
		return dao.getStoreReviews(store_id);
	}

	//가게 상세페이지 - 찾아오시는 길
	public List<StoreVO> getStoreAddress(int store_id) {
		return dao.getStoreAddress(store_id);
	}

	//메인 - 구독 페이지 
	public List<Map<Object, Object>> selectSubscribeStore() {
		return dao.selectSubscribeStore();
	}
	public List<StoreViewDTO> store_search(HashMap<String, Object> search){
		return dao.store_search(search);
}

	public int getHeartCount(int store_id) {
		return dao.selectHeartCount(store_id);
	}

	public int getReviewCount(int store_id) {
		return dao.selectReviewCount(store_id);
	}

	public List<StoreListDTO> getStoreListByFiltering(String order_type, String sort_type, Double lat, Double lng) {
		
		System.out.println("orderType"+order_type);
		System.out.println("sortType"+sort_type);
		
	    if (sort_type.equals("star")){
	    	System.out.println("Service: star");
	    	return dao.selectOrderByStar(order_type, lat, lng);
	    } else if(sort_type.equals("distance")){
	    	System.out.println("Service: distance");
	    	return dao.selectOrderByDistance(order_type, lat, lng);
	    } else if(sort_type.equals("review")){
	    	System.out.println("Service: review");
	    	return dao.selectOrderByReviewCount(order_type, lat, lng);
	    } else if(sort_type.equals("sales")){
	    	System.out.println("Service: sales");
	    	return dao.selectOrderBySalesCount(order_type, lat, lng);
	    } else if(sort_type.equals("heart")){
	    	System.out.println("Service: heart");
	    	return dao.selectOrderByHeartCount(order_type, lat, lng);
	    } else {
	    	System.out.println("Service: star");
	    	return dao.selectOrderByStar(order_type, lat, lng);
	    }
	}

	public List<StoreNoticeVO> getStoreNotice(int store_id) {
		return dao.selectNoticeAndEvent(store_id);
	}

	public Map<String, String> getIngredientsInfo(int store_id) {
		String ingredientsString=dao.selectStoreMadeIn(store_id);
		
		Map<String, String> ingInfo=new HashMap<String, String>();
		
		for (String str: ingredientsString.split(",")) {
			String[] tmpStr=str.split(":");
			ingInfo.put(tmpStr[0], tmpStr[1]);
		}
		System.out.println(ingInfo.toString());
		
		return ingInfo;
	}
	
	
	public List<MenuTimeVO> selectMenuNamesById(int store_id){
		return dao.selectMenuNamesById(store_id);
	}

}
