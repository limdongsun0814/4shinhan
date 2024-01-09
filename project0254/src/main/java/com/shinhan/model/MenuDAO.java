package com.shinhan.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.MenuVO;

@Repository
public class MenuDAO {
	@Autowired
	SqlSession sqlSession;
	String namespace = "net.firstzone.menu."; 
	Logger logger = LoggerFactory.getLogger(MenuDAO.class);
	
	public List<MenuVO> selectAllByStoreId(int store_id) {
		System.out.println(store_id);
		List<MenuVO> menuList = sqlSession.selectList(namespace + "selectAllByStoreId", store_id);
		logger.info(getClass().getSimpleName()+" 전체 :"+menuList.size()+"건");
		return menuList;
	}
	
	public int soldOutByCategory(int menu_category){
		System.out.println(menu_category);
		int result = sqlSession.update(namespace+"soldOutByCategory", menu_category);
		logger.info("카테고리 개수 수정:{}..성공여부:{}", menu_category, result);
		return result;
	}
	
	
	public int soldOutMenu(int menu_id){
		System.out.println(menu_id);
		int result = sqlSession.update(namespace+"soldOutMenu", menu_id);
		logger.info("개별 개수 수정:{}..성공여부:{}", menu_id, result);
		return result;
	}
	
	public int updateMenuCnt(int menu_id, int menu_count) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("menu_id", menu_id);
		map.put("menu_count", menu_count);
		int result = sqlSession.update(namespace+"updateMenuCnt", map);
		return result;
	}
	
	public int updateDiscount(String menus, int menu_discount_price) {
		Map<String, Object>map = new HashMap<String, Object>();
		System.out.println("메뉴들 "+menus);
		map.put("menus", menus);
		map.put("menu_discount_price", menu_discount_price);
		int result = sqlSession.update(namespace + "updateDiscount", map);
		return result;
	}
	
	public List<MenuVO> selectMenuBySearch(String search_word, int store_id){
		System.out.println(store_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search_word", search_word);
		map.put("store_id", store_id);
		List<MenuVO> menuList = sqlSession.selectList(namespace+"selectMenuBySearch", map);
		System.out.println("받아온 메뉴 개수"+menuList.size());
		return menuList;
	}
	
	

}
