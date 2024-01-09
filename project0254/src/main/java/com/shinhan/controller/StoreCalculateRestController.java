package com.shinhan.controller;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shinhan.dto.CalculateDayCountDTO;
import com.shinhan.dto.CalculateDayPriceDTO;
import com.shinhan.dto.CalculateMenuCountDTO;
import com.shinhan.dto.CalculateMenuPriceDTO;
import com.shinhan.model.StoreCalculateService;

@RestController
public class StoreCalculateRestController {
	@Autowired
	StoreCalculateService scService;
	Logger logger = LoggerFactory.getLogger(StoreCalculateRestController.class);
	
	@GetMapping(value="/selectCalculateDayCount.do", produces = "application/json")
	public Map<String, Object> selectCalculateDayCount(HttpSession session, String startDate, String endDate){
		int storeId = (int) session.getAttribute("owner_store_id");
		List<CalculateDayCountDTO> dcList = scService.selectCalculateDayCount(storeId, startDate, endDate);
		
		//각 열 리스트로 변환
		List<Timestamp> dateList = dcList.stream()
                .map(CalculateDayCountDTO::getDate)
                .collect(Collectors.toList());
		List<Integer> countList = dcList.stream()
                .map(CalculateDayCountDTO::getCount)
                .collect(Collectors.toList());
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("dateList", dateList);
		map.put("countList", countList);
		
		
		return map;
	}
	
	@GetMapping(value="/selectCalculateDayPrice.do", produces = "application/json")
	public Map<String, Object> selectCalculateDayPrice(HttpSession session, String startDate, String endDate){
		int storeId = (int) session.getAttribute("owner_store_id");
		List<CalculateDayPriceDTO> dcList = scService.selectCalculateDayPrice(storeId, startDate, endDate);
		
		//각 열 리스트로 변환
		List<Timestamp> dateList = dcList.stream()
                .map(CalculateDayPriceDTO::getDate)
                .collect(Collectors.toList());
		List<Integer> priceList = dcList.stream()
                .map(CalculateDayPriceDTO::getPrice)
                .collect(Collectors.toList());
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("dateList", dateList);
		map.put("countList", priceList);
		
		
		return map;
	}
	
	@GetMapping(value="/selectDoughnutMenuCount.do", produces = "application/json")
	public Map<String, Object> selectDoughnutMenuCount(HttpSession session, String startDate, String endDate){
		int storeId = (int) session.getAttribute("owner_store_id");
		List<CalculateMenuCountDTO> dcList = scService.selectDoughnutMenuCount(storeId, startDate, endDate);
		
		//각 열 리스트로 변환
		List<String> menuList = dcList.stream()
                .map(CalculateMenuCountDTO::getMenu_name)
                .collect(Collectors.toList());
		List<Integer> countList = dcList.stream()
                .map(CalculateMenuCountDTO::getTotal_count)
                .collect(Collectors.toList());
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menuList", menuList);
		map.put("countList", countList);
		
		return map;
	}
	
	@GetMapping(value="/selectDoughnutMenuPrice.do", produces = "application/json")
	public Map<String, Object> selectDoughnutMenuPrice(HttpSession session, String startDate, String endDate){
		int storeId = (int) session.getAttribute("owner_store_id");
		List<CalculateMenuPriceDTO> dcList = scService.selectDoughnutMenuPrice(storeId, startDate, endDate);
		
		//각 열 리스트로 변환
		List<String> menuList = dcList.stream()
                .map(CalculateMenuPriceDTO::getMenu_name)
                .collect(Collectors.toList());
		List<Integer> countList = dcList.stream()
                .map(CalculateMenuPriceDTO::getTotal_price)
                .collect(Collectors.toList());
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menuList", menuList);
		map.put("countList", countList);
		
		return map;
	}
	
	
}
