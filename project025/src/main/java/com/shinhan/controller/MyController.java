package com.shinhan.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.shinhan.dto.LoginDTO;
import com.shinhan.dto.MemberVO;
import com.shinhan.dto.MyReviewSubmitDTO;
import com.shinhan.dto.MyReviewVO;
import com.shinhan.dto.MySubscribeDTO;
import com.shinhan.dto.OrderListDTO;
import com.shinhan.model.LoginService;
import com.shinhan.model.MemberService;
import com.shinhan.model.MyPageService;
import com.shinhan.util.Cart;
import com.shinhan.util.S3Upload;

@Controller
@RequestMapping("/mypage")
public class MyController {
	Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MyPageService myPageService;
	
	@Autowired
	MemberService memberService;

	@Autowired
	Cart cart;

	@Autowired
	LoginService login_service;
	

	@Autowired
	S3Upload s3upload;
	//마이페이지 메인
	@GetMapping("/myPageMain.do")
	public String mypage(HttpSession session,Model model,@SessionAttribute("member") MemberVO member) {
		model = cart.mini_cart(model, session);
		logger.info("Welcome home! The client locale is {}.");
		LoginDTO login = new LoginDTO();
		login.setId(member.getMember_id());
		login.setPassword(member.getMember_password());
		MemberVO member_new = login_service.login_check(login);
		session.setAttribute("member", member_new);
		
		//MemberVO member = (MemberVO)session.getAttribute("member");
		//MemberVO memberInfo = memberService.getMyInfo(member.getMember_id());


		return "mypage/mypage";
	}
	
	//찜한 가게 리스트
	//@GetMapping("/getHeartList.do")
	//public String getHeartList() {
	//	logger.info("Welcome home! The client locale is {}.");
	//	return "mypage/myheartstores";
	//}
	
	
	
	
	@PostMapping("/checkPassword.do")
	@ResponseBody
	public String checkPassword(HttpSession session,
		 String enteredPassword) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		String member_id = member.getMember_id();
		String storedPassword = memberService.getPasswordByMemberId(member_id);
		
		System.out.println(member_id);
		System.out.println(enteredPassword);
		System.out.println(storedPassword);
		if (storedPassword.equals(enteredPassword)) {
            return "success";
        } else {
            return "failure";
        }
	}
	
	
	//회원 정보 수정 페이지
	@GetMapping("/getMyInfo.do")
	public String getMyInfo() {
		return "mypage/myinfo";
	}
	
	//주문 내역 조회
	@GetMapping("/getOrderList.do")
	public String getOrderList() {
		return "mypage/myorderlist";
	}
	
	//전체 (픽업 + 배달) 주문 내역 조회
	@GetMapping("/getAllOrderList.do")
	public String getAllOrderList(Model model, HttpSession session, String period) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		//member.getMember_id() 
		
		logger.info("asdfasldkfajksdfhkasfd");
		logger.info(period);
		logger.info(member.getMember_id());
		List<OrderListDTO> paymentList = myPageService.selectAllOrderList(member.getMember_id(), period);
		System.out.println("SASDFASDFASDF");
		System.out.println(paymentList.toString());
		model.addAttribute("paymentList", paymentList);
		
		return "orderlist";
	}
	//픽업 주문 내역 조회
	@GetMapping("/getPickUpOrder.do")
	public String getPickUpOrder(Model model, HttpSession session, String period) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		//member.getMember_id() 
		List<OrderListDTO> paymentList = myPageService.selectPickUpOrder(member.getMember_id(), period);
		model.addAttribute("paymentList", paymentList);
		return "orderlist";
	}
	//배달 주문 내역 조회
	@GetMapping("/getDeliveryOrder.do")
	public String getDeliveryOrder(Model model, HttpSession session, String period) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		//member.getMember_id() 
		List<OrderListDTO> paymentList = myPageService.selectDeliveryOrder(member.getMember_id(), period);
		model.addAttribute("paymentList", paymentList);
		return "orderlist";
	}
	
	//주문 내역 상세 조회
	@GetMapping("/getOrderDetail.do")
	public String getOrderDetail(Model model, int payment_seq) {
		//model.addAttribute("payment_id", payment_id);
		System.out.println("상세들어옴" + payment_seq);
		List<Map<Object, Object>> joinList = myPageService.getOrderDetail(payment_seq);
		System.out.println("sql 갔다옴"+joinList);
		model.addAttribute("joinList", joinList);
		//return "redirect:/mypage/getOrderList.do";
		return "mypage/myorderdetail";
	}
	
	//구독 내역 조회
	@GetMapping("/getMySubList.do")
	public String getMySubList(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		//member.getMember_id() 
		List<MySubscribeDTO> mySubscribe = myPageService.getMySubList(member.getMember_id());
		System.out.println("sql 갔다옴"+mySubscribe);
		model.addAttribute("mySubscribe", mySubscribe);
		return "mypage/mysublist";
	}
	
	//리뷰 내역 조회
	@GetMapping("/getReviewList.do")
	public String getReviewList(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		List<MyReviewVO> reviewList = 
				myPageService.selectAllByPaymentId(member.getMember_id() );
		model.addAttribute("reviewList", reviewList);
		System.out.println(reviewList);
		return "mypage/myreview";
	}
	
	//리뷰 삭제
	@GetMapping("/deleteReview.do")
	public String deleteReview(Model model, int payment_id) {
		//model.addAttribute("payment_id", payment_id);
		System.out.println("삭제들어옴" + payment_id);
		int result = myPageService.deleteReview(payment_id);
		System.out.println("sql 갔다옴"+result);

		return "redirect:/mypage/getReviewList.do";
	}
	
	//리뷰 썼는지 체크해서 true면 "리뷰목록페이지" false면 "리뷰 쓰는 페이지"
	@GetMapping("/checkReview.do")
	public String checkReview(Model model, HttpSession session, int payment_seq) {
		System.out.println("checkReview 들어옴" + payment_seq);
		boolean reviewExists = myPageService.checkReview(payment_seq);
		System.out.println("sql 갔다옴" + reviewExists);
		
		if(reviewExists) {
			return "redirect:/mypage/getReviewList.do";
		}else {
			MemberVO member = (MemberVO)session.getAttribute("member");
			return "redirect:/mypage/writeReviewPage.do?payment_seq=" + payment_seq;
		}
		
	}
	
	//리뷰 쓰는 페이지
	@GetMapping("/writeReviewPage.do")
	public String writeReview(int payment_seq) {
		return "mypage/myReviewWritePage";
	}
	
	//리뷰 등록
	@PostMapping("/submitReview.do")
	public String submitReview(MyReviewSubmitDTO myReviewSubmitDTO, Model model, HttpSession session, int payment_seq) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		myReviewSubmitDTO.setMember_review_member_id(member.getMember_id());
		int result = myPageService.submitReview(myReviewSubmitDTO);
		System.out.println(result);
		List<MyReviewVO> reviewList = 
				myPageService.selectAllByPaymentId(member.getMember_id() );
		model.addAttribute("reviewList", reviewList);
		
		return "mypage/myreview";
	}
	
	//문의 내역 조회
	@GetMapping("/getMyQnaList.do")
	public String getMyQnaList() {
		return "mypage/myqna";
	}
	
	@PostMapping("/submitReviewImg.do/{payment_seq}")
	public String submitReviewImg(MultipartHttpServletRequest multipart, HttpSession session, @PathVariable("payment_seq")int payment_seq) {
		System.out.println("submitReviewImg 들어옴" + payment_seq);
		List<MultipartFile> fileList = multipart.getFiles("files");
		MemberVO member = (MemberVO)session.getAttribute("member");
		
	      long time = System.currentTimeMillis();
	      for (MultipartFile mf : fileList) {
	         String originFileName = mf.getOriginalFilename();
	         String saveFileName = String.format("%d_%s", time, originFileName);
	         try {
	            String filePath = s3upload.upload(mf, "review/",saveFileName);
	            Map<String, Object> params = new HashMap<>();
	            params.put("payment_seq", payment_seq);
	            params.put("filePath", filePath);
	            myPageService.submitReviewImg(params);
	            return "mypage/myreview";
	         } catch (Exception e) {
	            e.printStackTrace();
	         }
	         
	      }
	     
	     
		return "mypage/myreview";
	}
	
}
