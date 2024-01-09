package com.shinhan.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.CalculateDayCountDTO;
import com.shinhan.dto.CalculateDayPriceDTO;
import com.shinhan.dto.CalculateMenuCountDTO;
import com.shinhan.dto.CalculateMenuPriceDTO;

@Repository
public class StoreCalculateDAO {
	
	@Autowired
	SqlSession sqlSession;
	String namespace = "net.firstzone.storeCalculate."; 
	Logger logger = LoggerFactory.getLogger(StoreCalculateDAO.class);
	
	public List<CalculateDayCountDTO> selectCalculateDayCount(int store_id, String startDate, String endDate){
		System.out.println("들어옴"+startDate);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("store_id", store_id);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		List<CalculateDayCountDTO> result = sqlSession.selectList(namespace+"selectCalculateDayCount", map);
		return result;
	}
	
	public List<CalculateDayPriceDTO> selectCalculateDayPrice(int store_id, String startDate, String endDate){
		System.out.println("들어옴"+startDate);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("store_id", store_id);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		List<CalculateDayPriceDTO> result = sqlSession.selectList(namespace+"selectCalculateDayPrice", map);
		return result;
	}
	
	public List<CalculateMenuCountDTO> selectDoughnutMenuCount(int store_id, String startDate, String endDate){
		System.out.println("들어옴"+startDate);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("store_id", store_id);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		List<CalculateMenuCountDTO> result = sqlSession.selectList(namespace+"selectDoughnutMenuCount", map);
		return result;
	}
	
	public List<CalculateMenuPriceDTO> selectDoughnutMenuPrice(int store_id, String startDate, String endDate){
		System.out.println("들어옴"+startDate);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("store_id", store_id);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		List<CalculateMenuPriceDTO> result = sqlSession.selectList(namespace+"selectDoughnutMenuPrice", map);
		return result;
	}
}
