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

import com.shinhan.dto.StoreNoticeDTO;
import com.shinhan.dto.StoreNoticeVO;
import com.shinhan.model.StoreNoticeService;
import com.shinhan.util.S3Upload;

@Controller
public class StoreNoticeController {

	@Autowired
	StoreNoticeService snService;

	
	@Autowired
	S3Upload s3upload;
	
	Logger logger = LoggerFactory.getLogger(MainController.class);

	StoreNoticeDTO storeNoticeDTO;
	StoreNoticeVO storeNoticeVO;

	@GetMapping("/storeNotice.do")
	public String StoreNoticeList(HttpSession session, Model model) {

		int storeId = (int) session.getAttribute("owner_store_id");

		/*
		 * List<Date> paymentDate = srService.selectPaymentDate(storeId);
		 * model.addAttribute("paymentDate", paymentDate);
		 */

		List<StoreNoticeVO> storeNoticeList = snService.StoreNoticeList(storeId);
		System.out.println("1차확인storenotice");

		model.addAttribute("storeNoticeList", storeNoticeList);
		System.out.println(storeId);
		System.out.println(storeNoticeList);
		return "storeNotice";

	}

	@GetMapping("/storeNoticeSelect.do")
	public String StoreNoticeSelect(Integer store_notice_seq, HttpSession session, Model model) {

		int storeId = (int) session.getAttribute("owner_store_id");

		StoreNoticeVO storeNotice = snService.StoreNoticeSelect(store_notice_seq);
		System.out.println(storeNotice);

		model.addAttribute("storeNotice", storeNotice);
		return "storeNoticeSelect";

	}

	@PostMapping("/storeNoticeUpdate.do")
	public String StoreNoticeUpdate(StoreNoticeVO storeNotice, HttpSession session, MultipartHttpServletRequest multipart) {

		List<MultipartFile> fileList = multipart.getFiles("new_store_notice_img_path");
		
		long time = System.currentTimeMillis();
		System.out.println("Null로 나오는게 정상: "+storeNotice);
		
		
		if(!fileList.get(fileList.size()-1).isEmpty()) { //new_file이 비어있지 않으면 수정파일 입력되었음 의미
			for (MultipartFile mf : fileList) {
				String originFileName = mf.getOriginalFilename(); 
				String saveFileName = String.format("%d_%s", time, originFileName);
				try {
					String img_path = s3upload.upload(mf, "notice/", saveFileName);
					storeNotice.setStore_notice_img_path(img_path);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		
		int result = snService.StoreNoticeUpdate(storeNotice);
		// return "redirect:/menuManagement.do?menu_id="+menu.getMenu_id();
		return "redirect:/storeNotice.do";
	}

	@GetMapping("/storeNoticeInsert.do")
	public String StoreNoticeInsert(HttpSession session, Model model) {
		System.out.println("insert 들어옴");
		return "storeNoticeInsert";
	}

	@PostMapping("/storeNoticeInsert.do")
	public String StoreNoticeInsert(MultipartHttpServletRequest multipart, StoreNoticeDTO storeNotice,
			HttpSession session, Model model) {
		// int storeId = (int) session.getAttribute("owner_store_id");

//		List<MultipartFile> fileList = multipart.getFiles("store_notice_img_path123");
//		ServletContext application = session.getServletContext();
//		String path = application.getRealPath("./resources/store");
//		File fileDir = new File(path);
//		if (!fileDir.exists()) {
//			fileDir.mkdirs();
//		}
//		long time = System.currentTimeMillis();
//		for (MultipartFile mf : fileList) {
//			String originFileName = mf.getOriginalFilename();
//			String saveFileName = String.format("%d_%s", time, originFileName);
//			storeNotice.setStore_notice_img_path(saveFileName);
//			try {
//				mf.transferTo(new File(path, saveFileName));
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//
//		
		
		
		List<MultipartFile> fileList = multipart.getFiles("store_notice_img_path1");
		
		
		long time = System.currentTimeMillis();
		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename(); 
			String saveFileName = String.format("%d_%s", time, originFileName);
			try {
				String img_path = s3upload.upload(mf, "notice/", saveFileName);  //s3에 업로드 한 뒤 url 받아옴
				storeNotice.setStore_notice_img_path(img_path);  // 받은 url vo로 보냄
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		int result = snService.StoreNoticeInsert(storeNotice);

		return "redirect:/storeNotice.do";
	}

	@PostMapping("/storeNoticeDelete.do")
	public String StoreNoticeDelete(@RequestParam("store_notice_seq") int store_notice_seq) {
		int result = snService.StoreNoticeDelete(store_notice_seq);
		System.out.println("삭제controller체크");
		return "redirect:/storeNotice.do";
		
	}

	/*
	 * int result = dService.deleteDept(deptid);
	 * attr.addFlashAttribute("deptMessage",result>0?"���� ����":"���� ����");
	 * 
	 */

}
