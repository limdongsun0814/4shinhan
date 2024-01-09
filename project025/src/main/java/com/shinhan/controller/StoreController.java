package com.shinhan.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shinhan.dto.HeartDTO;
import com.shinhan.dto.MemberVO;
import com.shinhan.dto.MenuCategoryVO;
import com.shinhan.dto.MenuVO;
import com.shinhan.dto.MyReviewVO;
import com.shinhan.dto.StoreListDTO;
import com.shinhan.dto.StoreNoticeVO;
import com.shinhan.dto.StoreVO;
import com.shinhan.dto.StoreViewDTO;
import com.shinhan.model.MemberService;
import com.shinhan.model.MenuService;
import com.shinhan.model.StoreService;
import com.shinhan.page.ItemCriteria;
import com.shinhan.page.ItemPageMaker;
import com.shinhan.page.PageService;
import com.shinhan.util.Cart;

@Controller
@RequestMapping("/store")
public class StoreController {

	Logger logger = LoggerFactory.getLogger(StoreController.class);

	@Autowired
	StoreService storeService;

	@Autowired
	MemberService memberService;

	@Autowired
	MenuService menuService;

	@Autowired
	PageService pageService;

	@Autowired
	Cart cart;

	@GetMapping("/storeSearch.do")
	public String storeSearch(@RequestParam(required = false) String store_search_name, Model model,
			Double lng,Double lat,HttpSession session) {
		model = cart.mini_cart(model, session);
		System.out.println(lng+"................");
		HashMap<String, Object> par = new HashMap<String, Object>();
		if (store_search_name == null) {
			store_search_name = "";
		}
		if(lng==null) {
			par.put("lng", 126.92263631540145);
		}else {
			par.put("lng", (Double)session.getAttribute("lng"));
			System.out.println("lng+++++++++"+((Double)par.get("lng")));
		}
		if(lat==null) {
			par.put("lat", 37.55935630326601);
		}else {
			par.put("lat", (Double)session.getAttribute("lat"));
			System.out.println("lat+++++++++"+((Double)par.get("lat")));
		}
		System.out.println("store_search_name+++++++"+store_search_name);
		par.put("str", "%"+store_search_name+"%");
		List<StoreViewDTO> storeList = storeService.store_search(par);
		Map<Integer, List<StoreViewDTO>> storeMap = new HashMap<Integer, List<StoreViewDTO>>();
		Integer index = 1;
		ArrayList<Integer> page = new ArrayList<Integer>();
		page.add(index);
		int cnt = 0;
		for (StoreViewDTO store : storeList) {
			if (storeMap.get(index) == null) {
				storeMap.put(index, new ArrayList<StoreViewDTO>());
			}
			storeMap.get(index).add(store);
			cnt++;
			if (cnt > 5) {
				cnt = 0;
				index++;
				page.add(index);
			}
		}
		model.addAttribute("storeMap", storeMap);
		model.addAttribute("page", page);
		System.out.println(storeList + store_search_name);
		if(storeMap.size()!=page.size()) {
			System.out.println(storeMap.size());
			page.remove(page.size()-1);
		}
		System.out.println(storeMap.size());
		System.out.println(page.size());
		System.out.println(page);
		if(storeMap.size() == 0) {
			model.addAttribute("store_search_name", store_search_name);
			return "/store/storeNoSearch";
		}
		return "/store/storelist";
	}

	// 전체 가게 조회 (별점순)
	@GetMapping("/getAllStoreList.do")
	public String getAllStoreList(Model model, Double lat, Double lng) {
		List<StoreListDTO> storeList = storeService.selectAllStores(lat, lng);
		model.addAttribute("storeList", storeList);

		System.out.println(storeList.size());

		return "storelist";
	}

	// 가게 필터링 조회 (주문타입, 정렬)
	@GetMapping("/getStoreListByFiltering.do")
	public String getStoreListByFiltering(Model model, String order_type, String sort_type, Double lat, Double lng) {

		System.out.println(order_type + " " + sort_type);
		System.out.println("\n\n\n\nFiltering");
		

		List<StoreListDTO> storeList = storeService.getStoreListByFiltering(order_type, sort_type, lat, lng);
		for (StoreListDTO store : storeList) {
			System.out.println(store.toString());
		}
		model.addAttribute("storeList", storeList);

		System.out.println(storeList.size());

		return "storelist";
	}

	// 전체 가게 조회 (별점순)
	@ResponseBody
	@GetMapping("/getAllStoreListMap.do")
	public List<StoreListDTO> getAllStoreListMap(Double lat, Double lng) {
		List<StoreListDTO> storeList = storeService.selectAllStores(lat, lng);

		logger.info("map:전체가게 조회: " + storeList.toString());

		return storeList;
	}

	// 가게 필터링 조회 (주문타입, 정렬)
	@ResponseBody
	@GetMapping("/getStoreListByFilteringMap.do")
	public List<StoreListDTO> getStoreListByFilteringMap(String order_type, String sort_type, Double lat, Double lng) {

		System.out.println(order_type + " " + sort_type);
		System.out.println("\n\n\n\n\nFilteringMap");

		List<StoreListDTO> storeList = storeService.getStoreListByFiltering(order_type, sort_type, lat, lng);
		for (StoreListDTO store : storeList) {
			System.out.println(store.toString());
		}
		//model.addAttribute("mapStoreList", storeList);
		logger.info("map:가게 필터링 조회: " + storeList.toString());

//		return "map";
		return storeList;
	}
	@PostMapping("/getMap.do")
	public String getMap(Model model) {
		
		logger.info("우웩");
		return "map";
	}

	
	@GetMapping("/getStoreDetail.do/{store_id}")
	public String getStoreDetail(@PathVariable("store_id") int store_id, Model model,HttpSession session, @ModelAttribute("cri") ItemCriteria cri) {
		model = cart.mini_cart(model, session);
		
		if(session.getAttribute("member")!=null) {
			MemberVO member = (MemberVO) session.getAttribute("member");
			
			int heart_result = storeService.selectByHeart(
					HeartDTO.builder()
					.heart_member_id(member.getMember_id())
					.heart_store_id(store_id).build());
			System.out.println(heart_result+"+++++++++++++");
			if(heart_result>0) {
				model.addAttribute("myheart", true);
			}else {
				model.addAttribute("myheart", false);
			}
		}
		
		StoreVO store = storeService.selectOne(store_id);
		model.addAttribute("store", store);

		int heart_count = storeService.getHeartCount(store_id);
		model.addAttribute("heart_count", heart_count);

		int review_count = storeService.getReviewCount(store_id);
		model.addAttribute("review_count", review_count);
		
		
		model.addAttribute("menu_names", storeService.selectMenuNamesById(store_id));
		
		model.addAttribute("menuList", pageService.itemList(cri));
		return "storedetail";
	}

	@GetMapping("/getPickupList.do")
	public String getPickupList(Model model, String sort_type) {
		logger.info("pickup");
		List<StoreVO> storeList = storeService.getPickupStores(sort_type);
		for (StoreVO store : storeList) {
			System.out.println(store);
		}
		model.addAttribute("storeList", storeList);

		System.out.println(storeList.size());

		return "storelist";
	}

	@GetMapping("/getDeliveryList.do")
	public String getDeliveryList(Model model, String sort_type) {
		logger.info("delivery");
		List<StoreVO> storeList = storeService.getDeliveryStores(sort_type);
		for (StoreVO store : storeList) {
			System.out.println(store);
		}
		model.addAttribute("storeList", storeList);

		System.out.println(storeList.size());

		return "storelist";
	}

	@GetMapping("/getHeartStore.do")
	public String printHeartStore(Model model, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		List<StoreVO> storeList = storeService.getHeartStores(member.getMember_id());
		MemberVO mem = memberService.getMyInfo(member.getMember_id());

		model.addAttribute("storeList", storeList);

		model.addAttribute("member", mem);
		return "mypage/myheartstores";
	}
//	int result = storeService.deleteHeartStore(
//	HeartDTO.builder()
//	.heart_member_id(member.getMember_id())
//	.heart_store_id(store_id)
//	.build());

	// jsp 만들고 post로 수정 예쩡
	@GetMapping("/deleteHeartStore.do")
	public String deleteHeartStore(Model model, HttpSession session, int store_id) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		int result = storeService.deleteHeartStore(
				HeartDTO.builder().heart_member_id(member.getMember_id()).heart_store_id(store_id).build());

		return "mypage/myheartstores";
	}

	@PostMapping("/deleteHeartStoreAjax.do")
	@ResponseBody
	public Map<String, Object> deleteHeartStoreAjex(Model model, HttpSession session, int store_id,
			RedirectAttributes attr) {
		Map<String, Object> result_map = new HashMap<String, Object>();
		if (session.getAttribute("member") == null) {
			result_map.put("login_check", false);
			result_map.put("result", "로그인이 필요한 기능입니다.");
		} else {
			result_map.put("login_check", true);
			MemberVO member = (MemberVO) session.getAttribute("member");
			
			int result = storeService.deleteHeartStore(
					HeartDTO.builder()
					.heart_member_id(member.getMember_id())
					.heart_store_id(store_id).build());
			if (result > 0) {
				result_map.put("result", "찜을 해제했습니다.");
			} else {
				result_map.put("result", "찜 해제를 실패했습니다.");
			}
		}
		return result_map;
	}

	@PostMapping("/insertHeartStoreAjax.do")
	@ResponseBody
	public Map<String, Object> insertHeartStore(Model model, HttpSession session, int store_id,
			RedirectAttributes attr) {
		Map<String, Object> result_map = new HashMap<String, Object>();
		if (session.getAttribute("member") == null) {
			result_map.put("login_check", false);
			result_map.put("result", "찜하시려면 먼저 로그인을 해주세요.");
		} else {
			result_map.put("login_check", true);
			MemberVO member = (MemberVO) session.getAttribute("member");
			
			int result = storeService.addHeartStore(HeartDTO.builder()
					.heart_member_id(member.getMember_id())
					.heart_store_id(store_id).build());
			if (result > 0) {
				result_map.put("result", "찜했습니다.");
			} else {
				result_map.put("result", "찜하기를 실패했습니다.");
			}
		}
		return result_map;
	}

	/**
	 * 
	 * 가게 조회할 떄 동네 필터링해야 함~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!
	 * 
	 */

	@GetMapping("/getStoreReviews.do")
	public String getStoreReviews(Model model, int store_id) {
		List<MyReviewVO> reviewList = storeService.getStoreReviews(store_id);
		model.addAttribute("reviewList", reviewList);
		System.out.println(store_id + ":" + reviewList);
		return "store/storereview";
	}

	@GetMapping("/getStoreAddress.do")
	public String getStoreAddress(Model model, int store_id) {
		List<StoreVO> storeAddress = storeService.getStoreAddress(store_id);
		model.addAttribute("storeAddress", storeAddress);
		return "store/storeroute";
	}

	@GetMapping("/getStoreNotice.do")
	public String getStoreNotice(Model model, int store_id) {
		List<StoreNoticeVO> noticeList = storeService.getStoreNotice(store_id);
		model.addAttribute("noticeList", noticeList);
		
		logger.info(noticeList.toString());
		
		return "store/noticeandevent";
	}
	
	@GetMapping("/getIngredientsInfo.do")
	public String getIngredientsInfo(Model model, int store_id) {
		Map<String, String> ingredientsMap = storeService.getIngredientsInfo(store_id);
		model.addAttribute("ingredientsMap", ingredientsMap);
		return "store/ingredientsinfo";
	}
	
	
	@GetMapping("/getMenuListPage.do")
	public String getMenuListPage(Model model, int store_id) {

		model.addAttribute("store_id", store_id);
		
		List<MenuCategoryVO> menu_category_list =menuService.getMenuCategoryList(store_id);
		model.addAttribute("menu_category_list", menu_category_list);
		logger.info("ㅇㄹㄴ후ㅗㅠㄴ이후냐;루ㅏㄷ."+menu_category_list.toString());

		return "store/menu";
	}

	// 가게 상세->메뉴 리스트 조회
	@GetMapping("/getMenuList.do")
	public String getMenuList(Model model, @ModelAttribute("cri") ItemCriteria cri) {

//		List<MenuVO> menuList=menuService.getAllMenuOfStore(store_id);
//		model.addAttribute("menuList", menuList);

		logger.info(cri.toString());

		model.addAttribute("menuList", pageService.itemList(cri));
		model.addAttribute("store_id", cri.getStore_id());

		ItemPageMaker pageMaker = new ItemPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotal_count(pageService.itemCount(cri));

		model.addAttribute("pageMaker", pageMaker);

		return "store/menulist";
	}

	// 가게 상세-> 메뉴 ->메뉴 검색
	@GetMapping("/searchMenu.do")
	public String getMenuSearch(Model model, @ModelAttribute("cri") ItemCriteria cri, String keyword) {

		logger.info(cri.toString());
		logger.info(keyword);

		model.addAttribute("menuList", pageService.searchItemList(cri, keyword));
		model.addAttribute("store_id", cri.getStore_id());

		ItemPageMaker pageMaker = new ItemPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotal_count(pageService.searchItemCount(cri, keyword));

		model.addAttribute("pageMaker", pageMaker);

		return "store/menulist";
	}

	// 메뉴 상세 페이지 + 메뉴 리뷰
	@GetMapping("/getMenuDetail.do")
	public String getMenuDetail(Model model, int menu_id) {

		MenuVO menu = menuService.getMenuDetail(menu_id);
		model.addAttribute("menu", menu);

		// 랜덤 메뉴
		List<MenuVO> randomMenuList = menuService.getRandomMenuList(menu.getMenu_store_id());
		logger.info(randomMenuList.toString());
		model.addAttribute("randomMenuList", randomMenuList);

		return "menudetail";
	}
}
