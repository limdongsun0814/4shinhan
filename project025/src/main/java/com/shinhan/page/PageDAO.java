package com.shinhan.page;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.MenuVO;



@Repository
public class PageDAO {
	
	@Autowired
	SqlSession sqlSession;
	String namespace = "com.shinhan.menu.";
	
	public List<MenuVO> getMenuList(ItemCriteria cri) {
		List<MenuVO> menuList = sqlSession.selectList(namespace + "selectMenuPagination", cri);
		
		System.out.println(cri.toString());
		System.out.println(menuList.toString());
		
		return menuList;
	}
	
	public List<MenuVO> getMenuListBySearch(ItemCriteria cri, String keyword) {
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("store_id", cri.getStore_id());
		map.put("row_start", cri.getRow_start());
		map.put("row_end", cri.getRow_end());
		map.put("keyword", keyword);
		
		System.out.println(cri.getStore_id());
		System.out.println(cri.getRow_start());
		System.out.println(cri.getRow_end());


		List<MenuVO> menuList = sqlSession.selectList(namespace + "selectMenuBySearch", map);
		
		for (MenuVO menu: menuList) {
			System.out.println(menu.toString());
		}
		
		return menuList;
	}
	
	public int getMenuCount(ItemCriteria cri) {
		int menuCount = sqlSession.selectOne(namespace + "menuCount", cri);
		
		System.out.println(menuCount);
		return menuCount;
	}
	
	public int getMenuCount(ItemCriteria cri, String keyword) {
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("cri", cri);
		map.put("keyword", keyword);
		
		int menuCount = sqlSession.selectOne(namespace + "menuCountBySearch", map);
		System.out.println("menuCount: "+menuCount);
		return menuCount;
	}
}
