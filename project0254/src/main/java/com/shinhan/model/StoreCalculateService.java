package com.shinhan.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.CalculateDayCountDTO;
import com.shinhan.dto.CalculateDayPriceDTO;
import com.shinhan.dto.CalculateMenuCountDTO;
import com.shinhan.dto.CalculateMenuPriceDTO;

@Service
public class StoreCalculateService {
	@Autowired
	StoreCalculateDAO dao;
	
	public List<CalculateDayCountDTO> selectCalculateDayCount(int store_id, String startDate, String endDate){
		return dao.selectCalculateDayCount(store_id, startDate, endDate);
	}
	
	public List<CalculateDayPriceDTO> selectCalculateDayPrice(int store_id, String startDate, String endDate){
		return dao.selectCalculateDayPrice(store_id, startDate, endDate);
	}
	
	public List<CalculateMenuCountDTO> selectDoughnutMenuCount(int store_id, String startDate, String endDate){
		return dao.selectDoughnutMenuCount(store_id, startDate, endDate);
	}
	
	public List<CalculateMenuPriceDTO> selectDoughnutMenuPrice(int store_id, String startDate, String endDate){
		return dao.selectDoughnutMenuPrice(store_id, startDate, endDate);
	}
}
