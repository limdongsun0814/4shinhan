package com.shinhan.page;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.MenuVO;

@Service
public class PageService {
	
	@Autowired
	PageDAO dao;

	public List<MenuVO> itemList(ItemCriteria cri) {
		return dao.getMenuList(cri);
	}

	public int itemCount(ItemCriteria cri) {
		return dao.getMenuCount(cri);
	}
	
	public List<MenuVO> searchItemList(ItemCriteria cri, String keyword) {
		return dao.getMenuListBySearch(cri, keyword);
	}
	
	public int searchItemCount(ItemCriteria cri, String keyword) {
		System.out.println(dao.getMenuCount(cri, keyword));
		return dao.getMenuCount(cri, keyword);
	}

}
