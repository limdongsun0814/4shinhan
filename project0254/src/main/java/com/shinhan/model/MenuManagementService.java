package com.shinhan.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.MenuVO;
@Service
public class MenuManagementService {
	
	@Autowired
	MenuManagementDAO mdao;
	
	/*
	 * public List<MenuVO> selectAllByStoreId(int store_id) { return
	 * dao.selectAllByStoreId(store_id); }
	 */
	
	
	public MenuVO selectMenuByMenuId(int menu_id) {
		return mdao.selectMenuByMenuId(menu_id);
	}
	
	public int menuManagementUpdate(MenuVO menu) {
		return mdao.menuManagementUpdate(menu);
	}
	
	public int menuManagementInsert(MenuVO menu) {
		return mdao.menuManagementInsert(menu);
	}
	
	public int menuDelete(int menu_id) {
		System.out.println("deleteservice");
		return mdao.menuDelete(menu_id);
	}
}
