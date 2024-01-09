package com.shinhan.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.shinhan.dto.OwnerVO;
import com.shinhan.dto.testVO;
import com.shinhan.model.testDAO;
import com.shinhan.util.S3Upload;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	testDAO test;
	
	@Autowired
	S3Upload s3upload;
	
	@RequestMapping(value="/join.do")
	public String join() {
		return "jsp/join";
	}
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model,HttpSession session) {
		OwnerVO owner=(OwnerVO)session.getAttribute("owner");
		if(owner != null) {
			return "redirect:/main.do";
		}else {
			return "redirect:/login.do";
		}
	}

	@GetMapping(value="/test.do")//, method=RequestMethod.GET)
	public String test(Model model) {
		logger.info("로거");
		logger.info("==================");
		List<testVO> testList=test.selectAll();
		model.addAttribute("testList",testList);
		return "test";
	}
	
	@GetMapping(value="/test.1")//, method=RequestMethod.GET)
	public String test1(Model model) {
		return "common/ownerHeader";
	}
	@GetMapping(value="/test.2")//, method=RequestMethod.GET)
	public String test2(Model model) {
		return "common/ownerFooter";
	}
	
	@GetMapping("/uploadtest.test")
	   public String uploadtest() {
	      return "test2023-12-25";
	   }
	@PostMapping("/uploadtest.test")
	public String uploadtestpost(MultipartHttpServletRequest multipart) {
	   List<MultipartFile> fileList = multipart.getFiles("chooseFile");
	   long time = System.currentTimeMillis();
	   for (MultipartFile mf : fileList) {
	         String originFileName = mf.getOriginalFilename();
	         String saveFileName = String.format("%d_%s", time, originFileName);
	         try {
	            s3upload.upload(mf, "store/",saveFileName);
	         } catch (Exception e) {
	            e.printStackTrace();
	         }
	      }
	      return "test2023-12-25";
	   }
}
