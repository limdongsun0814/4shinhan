package com.shinhan.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shinhan.dto.MemberUpdateDTO;
import com.shinhan.dto.MemberVO;
import com.shinhan.model.MemberService;


@Controller
@RequestMapping("/member")
public class MemberController {
	
	Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	MemberService memberService;

	
	
	//내 정보 가져오기
	@GetMapping("/printMember.do")//, method=RequestMethod.GET)

	public String printMember(Model model, HttpSession session) {
		MemberVO mem = (MemberVO)session.getAttribute("member");
		MemberVO member=memberService.getMyInfo(mem.getMember_id());
		model.addAttribute("member", member);
		
		return "mypage/myinfo_ajax";
	}
	
	//회원탈퇴 유의사항 페이지로 가기
	@GetMapping("/deleteMember.do")//, method=RequestMethod.GET)
	public String deleteMember(String mid, Model model) {
		model.addAttribute("mid", mid);
		return "deletemember";
	}
	
	//찐 회원탈퇴
	@GetMapping("/deleteMember2.do")//, method=RequestMethod.GET)
	public String deleteMember2(Model model,HttpSession session, String mid,RedirectAttributes attr) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		int result = memberService.deleteMember(member.getMember_id());
		attr.addFlashAttribute("message","회원탈퇴되었습니다.");
		return "redirect:/memberlogin.do";
	}
	
	//회원정보 수정
	@GetMapping("/updateMember.do")//, method=RequestMethod.GET)
	public String updateMember(MemberUpdateDTO memberUpdateDTO) {
		System.out.println(memberUpdateDTO);
		logger.info(memberUpdateDTO.toString());
		int result = memberService.updateMember(memberUpdateDTO);

		return "redirect:/member/printMember.do";
	}
	
	//내 알람 가져오기 - 빵 나오는 시간
	@GetMapping("/getBreadAlarm.do")
	public String getBreadAlarm(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		//member.getMember_id()
		List<Map<Object, Object>> joinList = memberService.getBreadAlarm(member.getMember_id());
		int result = memberService.changeCheckAlarm(member.getMember_id());
		System.out.println("sql 갔다옴"+joinList);
		model.addAttribute("joinList", joinList);
		return "alarm";
	}
	
	@GetMapping("/deleteAllAlarm.do")
	public String deleteAllAlarm(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		int result = memberService.deleteAllAlarm(member.getMember_id());
		return "redirect:/member/getBreadAlarm.do";
	}
	
	@ResponseBody
	@GetMapping("/countNewAlarm.do")
	public String countNewAlarm(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		int alarmCount = memberService.countNewAlarm(member.getMember_id());
		return String.valueOf(alarmCount);
	}
	
	
	//내 알람 가져오기 - 가게 공지
	@GetMapping("/getNoticeAlarm.do")
	public String getNoticeAlarm(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		//member.getMember_id()
		List<Map<Object, Object>> joinList = memberService.getNoticeAlarm(member.getMember_id());
		System.out.println("sql 갔다옴"+joinList);
		model.addAttribute("joinList", joinList);
		return "alarm";
	}
	//내 알람 가져오기 - 구독 알림
	@GetMapping("/getSubscribeAlarm.do")
	public String getSubscribeAlarm(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		//member.getMember_id()
		List<Map<Object, Object>> joinList = memberService.getSubscribeAlarm(member.getMember_id());
		System.out.println("sql 갔다옴"+joinList);
		model.addAttribute("joinList", joinList);
		return "alarm";
	}
}
