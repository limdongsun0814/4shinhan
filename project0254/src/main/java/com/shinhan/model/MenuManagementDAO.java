package com.shinhan.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.MenuVO;
import com.shinhan.dto.OwnerVO;

@Repository
public class MenuManagementDAO {
	@Autowired
	SqlSession sqlSession;
	String namespace = "net.firstzone.menu."; 
	Logger logger = LoggerFactory.getLogger(MenuManagementDAO.class);
	
	public MenuVO selectMenuByMenuId(int menu_id) {
		System.out.println(menu_id);
		MenuVO menu = sqlSession.selectOne(namespace + "selectMenuByMenuId" , menu_id);
		logger.info(getClass().getSimpleName()+ menu);
		return menu;
	}
	
	public int menuManagementUpdate(MenuVO menu) {
		System.out.println(menu);
		int result = sqlSession.update(namespace + "menuManagementUpdate" , menu);
		logger.info(getClass().getSimpleName()+ menu);
		return result;
	}
	
	public int menuManagementInsert(MenuVO menu) {
		System.out.println(menu);
		int result = sqlSession.insert(namespace + "menuManagementInsert" , menu);
		logger.info(getClass().getSimpleName()+ menu);
		return result;
	}
	public int menuDelete(int menu_id) {
		int result = sqlSession.delete(namespace + "menuDelete", menu_id);
		System.out.println("deletedao");
		return result;
	}
}
