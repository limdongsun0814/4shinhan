package com.shinhan.model;

import java.util.List;
import java.util.Set;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.MenuCategoryVO;
import com.shinhan.dto.MenuVO;

@Repository
public class MenuCategoryDAO {
	@Autowired
	SqlSession sqlSession;
	String namespace = "net.firstzone.menu."; 
	Logger logger = LoggerFactory.getLogger(MenuCategoryDAO.class);
	
	public MenuCategoryVO selectByMenuCategory(int menu_category_seq) {
		System.out.println(menu_category_seq);
		
		MenuCategoryVO menucategory = sqlSession.selectOne(namespace + "selectByMenuCategory" , menu_category_seq);
		logger.info(getClass().getSimpleName()+ menucategory);
		
		return menucategory;
	}
	
	public List<MenuCategoryVO> selectAllCategory() {
		List<MenuCategoryVO> menucategorylist =sqlSession.selectList(namespace+"selectAllCategory");
		return menucategorylist;
	}
	
	public List<MenuCategoryVO> selectCategoryByStoreUse(Set<Integer> set) {
		List<MenuCategoryVO> menucategorylist =sqlSession.selectList(namespace+"selectCategoryByStoreUse", set);
		return menucategorylist;
	}
	
}
