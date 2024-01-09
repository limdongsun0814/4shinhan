package com.shinhan.controller;

import java.io.File;
import java.util.ArrayList;

import java.util.Enumeration;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shinhan.dto.MenuCategoryVO;
import com.shinhan.dto.MenuVO;
import com.shinhan.dto.StoreVO;
import com.shinhan.model.MenuCategoryService;
import com.shinhan.model.MenuManagementService;
import com.shinhan.model.MenuService;
import com.shinhan.model.OwnerService;
import com.shinhan.model.StoreService;
import com.shinhan.util.S3Upload;

@Controller
public class MenuController {
	@Autowired
	OwnerService oService;

	@Autowired
	StoreService sService;

	@Autowired
	MenuService mService;

	@Autowired
	MenuCategoryService mcService;
	
	@Autowired
	S3Upload s3upload;

	Logger logger = LoggerFactory.getLogger(MainController.class);

	StoreVO store;

	@GetMapping("/menuList.do")
	public String MenuDisplay(HttpSession session, Model model) {
		System.out.println("메뉴화면");

//		store = sService.selectStoreByOwnerId((String)session.getAttribute("owner_id"));
		store = (StoreVO) session.getAttribute("store");
		List<MenuVO> menuList = mService.selectAllByStoreId(store.getStore_id());
		logger.info("메뉴화면 진입");
		System.out.println("재고 관리 진입"+ menuList);

		return "menu";
	}

	// 재고관리 페이지 진입
	@GetMapping("/menuContainer.do")
	public String MenuContainerDisplay(HttpSession session, Model model, String keyword) {
		System.out.println("키워드"+ keyword);
		System.out.println("메뉴화면");
		// store =
		// sService.selectStoreByOwnerId((String)session.getAttribute("owner_id"));
		store = (StoreVO) session.getAttribute("store");
		List<MenuVO> menuList = null;
		// 무조건 검색방식. 검색어 없으면 전체 노출
		if (keyword == null || keyword.isEmpty()) {
			menuList = mService.selectAllByStoreId(store.getStore_id());
		} else {
			menuList = mService.selectMenuBySearch(keyword, store.getStore_id());
		}
		logger.info("메뉴컨테이너화면 진입");
		System.out.println(menuList.toString());
		System.out.println("메뉴 컨테이너 store"+store);
		
		
		model.addAttribute("store", store);
		model.addAttribute("menuList", menuList);

		Set<Integer> menuCategorySet = new HashSet<Integer>();
		for (MenuVO menu : menuList) {
			menuCategorySet.add(menu.getMenu_category());
		}
		
		System.out.println("menuCategory set"+menuCategorySet);
		System.out.println("owner_store_id set"+session.getAttribute("owner_store_id"));

		model.addAttribute("owner_store_id", session.getAttribute("owner_store_id"));
		model.addAttribute("menuCategory", mcService.selectCategoryByStoreUse(menuCategorySet));
		return "menuContainer";
	}

	// 메뉴 개별 품절 처리
	@RequestMapping(value = "/soldOutMenu.do", method = { RequestMethod.GET })
	public String soldOutMenu(int menu_id, RedirectAttributes attr) {
		logger.info("메뉴 품절 처리:{}" + menu_id);
		int result = mService.soldOutMenu(menu_id);
		attr.addFlashAttribute("message", result > 0 ? "품절처리 완료" : "품절처리 실패");
		return "redirect:menuList.do";
	}

	// 카테고리 품절 처리
	@RequestMapping(value = "/soldOutCategory.do", method = { RequestMethod.GET })
	public String soldOutByCategory(int menu_category, RedirectAttributes attr) {
		logger.info("카테고리 품절 처리:{}" + menu_category);
		int result = mService.soldOutByCategory(menu_category);
		attr.addFlashAttribute("message", result > 0 ? "품절처리 완료" : "품절처리 실패");
		return "redirect:menuList.do";
	}

	// 메뉴 재고 개수 변경
	@GetMapping("/updateMenuCount.do")
	public String updateMenuCnt(int menu_id, int menuCount, RedirectAttributes attr) {
		logger.info("메뉴개수 변경:{}" + menu_id);
		System.out.println("메뉴의 아이디" + menu_id);
		System.out.println("개수 " + menuCount);
		int result = mService.updateMenuCnt(menu_id, menuCount);
		attr.addFlashAttribute("message", result > 0 ? "재고 변경 완료" : "재고 변경 실패");
		return "redirect:menuList.do";
	}

	// 할인페이지 진입
	@GetMapping("/registDiscount.do")
	public String registDiscountDisplay(HttpSession session, Model model) {
		// 가게 선택부 나중엔 세션에 저장해놓을것
		// 메뉴 리스트와 가게에 속한 메뉴의 카테고리 셋 넘기기
//		store = sService.selectStoreByOwnerId((String)session.getAttribute("owner_id"));
		store = (StoreVO) session.getAttribute("store");
		List<MenuCategoryVO> menuCategoryListAll = mcService.selectAllCategory();
		List<MenuVO> menuList = mService.selectAllByStoreId(store.getStore_id());
		List<MenuCategoryVO> menuCategoryList = new ArrayList<MenuCategoryVO>();
		model.addAttribute("store", store);
		model.addAttribute("menuList", menuList);
		Set menuCategorySet = new HashSet<Integer>();
		for (MenuVO menu : menuList) {
			menuCategorySet.add(menu.getMenu_category());
		}
		for (MenuCategoryVO menuCategory : menuCategoryListAll) {
			if (menuCategorySet.contains(menuCategory.getMenu_category_seq())) {
				menuCategoryList.add(menuCategory);
			}
		}
		model.addAttribute("menuCategoryList", menuCategoryList);

		return "registDiscount";
	}

	@PostMapping("/registDiscount.do")
	public String registDiscount(HttpSession session, Model model, HttpServletRequest req) {
		String[] menuIds = req.getParameterValues("menu_id");
		String discountPrice = req.getParameter("discount_price");
		Set<String> menus = new HashSet<String>();
		StringBuilder sb = new StringBuilder();
		sb.append("(");
		for (String menu : menuIds) {
			sb.append(menu + ", ");
		}

		if (sb.length() > 0) {
			sb.setLength(sb.length() - 2);
		}
		sb.append(")");
		System.out.println(sb.toString());

		int result = mService.updateDiscount(sb.toString(), Integer.parseInt(discountPrice));
		System.out.println("결과" + result);
		return "redirect:registDiscount.do";
	}

	
	@GetMapping("/menuInsertNoCategory.do")
	public String menuInsertDisplay(HttpSession session, Model model) {
		System.out.println("메뉴 추가");
//		store = sService.selectStoreByOwnerId((String)session.getAttribute("owner_id"));
		store = (StoreVO)session.getAttribute("store");
		List<MenuCategoryVO> categoryList = mcService.selectAllCategory();
		model.addAttribute("store", store);
		model.addAttribute("menucategory", categoryList);
		model.addAttribute("owner_store_id", session.getAttribute("owner_store_id"));
		
		return "menuInsert";
	}
	
	@GetMapping("/menuInsert.do")
	public String menuInsertDisplay(HttpSession session, Model model, int category_id) {
		System.out.println("메뉴 추가");
//		store = sService.selectStoreByOwnerId((String)session.getAttribute("owner_id"));
		store = (StoreVO) session.getAttribute("store");
		List<MenuCategoryVO> categoryList = mcService.selectAllCategory();
		
		
		model.addAttribute("store", store);
		model.addAttribute("menucategory", categoryList);
		model.addAttribute("owner_store_id", session.getAttribute("owner_store_id"));
		model.addAttribute("nowCategoryId", category_id);

		return "menuInsert";
	}
	
	

	
}