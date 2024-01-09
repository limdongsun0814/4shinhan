package com.shinhan.model;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.MenuCategoryVO;

@Service
public class MenuCategoryService {

	@Autowired
	MenuCategoryDAO mcdao;

	/*
	 * public List<MenuVO> selectAllByStoreId(int store_id) { return
	 * dao.selectAllByStoreId(store_id); }
	 */

	public MenuCategoryVO selectByMenuCategory(int menu_category_seq) {

		return mcdao.selectByMenuCategory(menu_category_seq);

	}

	public List<MenuCategoryVO> selectAllCategory() {

		return mcdao.selectAllCategory();

	}
	
	public List<MenuCategoryVO> selectCategoryByStoreUse(Set<Integer> set) {
		return mcdao.selectCategoryByStoreUse(set);
	}

}
