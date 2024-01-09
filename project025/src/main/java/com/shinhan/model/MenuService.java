package com.shinhan.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.BestMenuDTO;
import com.shinhan.dto.MenuCategoryVO;
import com.shinhan.dto.MenuVO;
import com.shinhan.dto.MyReviewVO;

@Service
public class MenuService {
	@Autowired
	MenuDAO dao;
	
	public List<MenuVO> getAllMenuOfStore(int store_id) {
		return dao.selectByStore(store_id);
	}
	
	public MenuVO getMenuDetail(int menu_id) {
		return dao.selectById(menu_id);
	}
	
	public List<MyReviewVO> getMenuReview(int menu_id) {
		return dao.selectReviewByMenu(menu_id);
	}

	public List<BestMenuDTO> getBestMenuList() {
		return dao.selectMenuOrderBySales();
	}

	public List<MenuVO> getRandomMenuList(int store_id) {
		return dao.selectMenuRandomly(store_id);
	}
	
	public List<MenuCategoryVO> getMenuCategoryList(int store_id) {
		return dao.selectMenuCategory(store_id);
	}
}
