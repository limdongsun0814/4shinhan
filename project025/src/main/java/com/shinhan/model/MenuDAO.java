package com.shinhan.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.BestMenuDTO;
import com.shinhan.dto.MenuCategoryVO;
import com.shinhan.dto.MenuVO;
import com.shinhan.dto.MyReviewVO;


@Repository
public class MenuDAO {

	@Autowired
	SqlSession sqlSession;
	String namespace = "com.shinhan.menu.";
	
	public List<MenuVO> selectByStore(int store_id) {
		List<MenuVO> menuList = sqlSession.selectList(namespace + "selectByStore", store_id);
		return menuList;
	}
	
	public MenuVO selectById(int menu_id) {
		MenuVO menu=sqlSession.selectOne(namespace+"selectById", menu_id);
		return menu;
	}

	public List<MyReviewVO> selectReviewByMenu(int menu_id) {
		List<MyReviewVO> reviewList=sqlSession.selectList(namespace+"selectReviewByMenu", menu_id);
		return reviewList;
	}

	public List<BestMenuDTO> selectMenuOrderBySales() {
		List<BestMenuDTO> menuList=sqlSession.selectList(namespace+"selectMenuOrderBySales");
		return menuList;
	}

	public List<MenuVO> selectMenuRandomly(int store_id) {
		List<MenuVO> menuList=sqlSession.selectList(namespace+"selectMenuRandomly", store_id);
		return menuList;
	}
	
	public List<MenuCategoryVO> selectMenuCategory(int store_id) {
		return sqlSession.selectList(namespace+"selectMenuCategory", store_id);
	}
}
