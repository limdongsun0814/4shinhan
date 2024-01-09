package com.shinhan.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.MenuVO;
@Service
public class MenuService {
	
	@Autowired
	MenuDAO dao;
	
	
	public List<MenuVO> selectAllByStoreId(int store_id) {
		return dao.selectAllByStoreId(store_id);
	}
	
	public int soldOutByCategory(int menu_category){
		return dao.soldOutByCategory(menu_category);
	}
	
	
	public int soldOutMenu(int menu_id){
		return dao.soldOutMenu(menu_id);
	}
	
	public int updateMenuCnt(int menu_id, int menu_count) {
		return dao.updateMenuCnt(menu_id, menu_count);
	}
	
	public int updateDiscount(String menus, int menu_discount_price) {
		return dao.updateDiscount(menus, menu_discount_price);
	}
	
	public List<MenuVO> selectMenuBySearch(String search_word, int store_id){
		return dao.selectMenuBySearch(search_word, store_id);
	}
	
	
}
