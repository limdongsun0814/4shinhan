package com.shinhan.controller;

import java.util.List;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shinhan.dto.MenuCategoryVO;
import com.shinhan.dto.MenuVO;
import com.shinhan.dto.StoreVO;
import com.shinhan.model.MenuCategoryDAO;
import com.shinhan.model.MenuCategoryService;
import com.shinhan.model.MenuManagementService;
import com.shinhan.model.OwnerService;
import com.shinhan.model.StoreService;
import com.shinhan.util.S3Upload;

@Controller
public class MenuManagementController {
	@Autowired
	OwnerService oService;
	
	@Autowired
	StoreService sService;
	
	@Autowired
	MenuManagementService mmService;
	
	@Autowired
	MenuCategoryService mcService;
	
	@Autowired
	MenuCategoryDAO mDAO; //
	
	@Autowired
	S3Upload s3upload;
	
	StoreVO store;
	
	Logger logger = LoggerFactory.getLogger(MenuManagementController.class);
	
	MenuVO menu;
	List<MenuCategoryVO> menuCategoryList;
	
	@GetMapping("/menuManagement.do")
	public String MenuManagementDisplay(HttpSession session, Model model, int menu_id) {
		System.out.println("메뉴관리");
		menu = mmService.selectMenuByMenuId(menu_id);
		menuCategoryList = mcService.selectAllCategory();
		
		System.out.println("메뉴다녀옴");
		logger.info("메뉴화면 진입" );
		model.addAttribute("menu", menu);
		model.addAttribute("menucategory", menuCategoryList);
		/*
		 * model.addAttribute("menucategory", menucategory);
		 * System.out.println(menucategory +"2"); model.addAttribute("menucategory",
		 * mDAO.selectAllCategory());
		 */
		
		return "menuManagement";	
	}
	
	@PostMapping("/menuManagement.do")
	public String menuManagementUpdate(MenuVO menu ,RedirectAttributes attr, MultipartHttpServletRequest multipart) {

		List<MultipartFile> fileList = multipart.getFiles("new_menu_image_path");
		List<MultipartFile> fileThumbList = multipart.getFiles("new_menu_thumb_image_path");
		
		long time = System.currentTimeMillis();
		System.out.println("filelist"+fileList.get(fileList.size()-1));
		System.out.println("filelist"+fileList.get(fileList.size()-1).isEmpty());
		System.out.println("filelist"+fileThumbList.get(fileThumbList.size()-1));
		System.out.println("filelist"+fileThumbList.get(fileThumbList.size()-1).isEmpty());
		if(!fileList.get(fileList.size()-1).isEmpty()) { //new_file이 비어있지 않으면 수정파일 입력되었음 의미
			for (MultipartFile mf : fileList) {
				String originFileName = mf.getOriginalFilename(); 
				String saveFileName = String.format("%d_%s", time, originFileName);
				try {
					String img_path = s3upload.upload(mf, "menu/", saveFileName);
					menu.setMenu_image_path(img_path);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		if(!fileThumbList.get(fileThumbList.size()-1).isEmpty()) {
			for (MultipartFile mf : fileThumbList) {
				String originFileName = "thumb_"+mf.getOriginalFilename(); 
				String saveFileName = String.format("%d_%s", time, originFileName);
				try {
					String img_thumb_path = s3upload.upload(mf, "menu/", saveFileName);
					menu.setMenu_thumb_image_path(img_thumb_path);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		System.out.println("안바꾸면 기존 그대로 나오는게 정상: "+menu);
		
		int result = mmService.menuManagementUpdate(menu);
		//return "redirect:/menuManagement.do?menu_id="+menu.getMenu_id();
		return "redirect:/menuList.do";
	}
	
	@PostMapping("/menuInsert.do")
	public String menuManagementInsert(MenuVO menu ,RedirectAttributes attr, MultipartHttpServletRequest multipart) {
		logger.info("메뉴 넣기", menu.toString());
		
		List<MultipartFile> fileList = multipart.getFiles("img_menu_path");
		List<MultipartFile> fileThumbList = multipart.getFiles("img_menu_thumb_path");
		
		
		long time = System.currentTimeMillis();
		if(!fileList.get(fileList.size()-1).isEmpty()) { 
			for (MultipartFile mf : fileList) {
				String originFileName = mf.getOriginalFilename(); 
				String saveFileName = String.format("%d_%s", time, originFileName);
				try {
					String img_path = s3upload.upload(mf, "menu/", saveFileName);  //s3에 업로드 한 뒤 url 받아옴
					menu.setMenu_image_path(img_path);  // 받은 url vo로 보냄
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} else {
			menu.setMenu_image_path(null);
		}
		if(!fileThumbList.get(fileThumbList.size()-1).isEmpty()) { 
			for (MultipartFile mf : fileThumbList) {
				String originFileName = "thumb_" + mf.getOriginalFilename(); 
				String saveFileName = String.format("%d_%s", time, originFileName);
				try {
					String img_thumb_path = s3upload.upload(mf, "menu/", saveFileName);
					menu.setMenu_thumb_image_path(img_thumb_path);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}else {
			menu.setMenu_thumb_image_path(null);
		}
		
		int result = mmService.menuManagementInsert(menu);  //sql db에 최종저장
		
		return "redirect:/menuList.do";
	}
	
	@PostMapping("/menuDelete.do")
	public String menuDelete(@RequestParam("menu_id") int menu_id) {
		int result = mmService.menuDelete(menu_id);
		System.out.println("deletecontroller");
		return "redirect:/menuList.do";
	}
}
