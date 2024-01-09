package com.shinhan.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.shinhan.dto.MenuCategoryVO;
import com.shinhan.dto.MenuVO;
import com.shinhan.dto.PushAlarmDTO;
import com.shinhan.dto.PushAlarmVO;
import com.shinhan.model.PushAlarmCategoryDAO;
import com.shinhan.model.PushAlarmCategoryService;
import com.shinhan.model.PushAlarmDAO;
import com.shinhan.model.PushAlarmService;

@Controller
public class PushAlarmController {

	@Autowired
	PushAlarmService pService;

	@Autowired
	PushAlarmDAO pDAO; //

	@Autowired
	PushAlarmCategoryDAO pcDAO;

	Logger logger = LoggerFactory.getLogger(PushAlarmController.class);

	MenuVO menu;
	List<MenuCategoryVO> menuCategoryList;

	PushAlarmVO pushAlarmVO;

	@Autowired
	PushAlarmCategoryService pcService;

	@GetMapping("/pushAlarmResend.do")
	public String pushAlarmResend(Integer push_alarm_id, HttpSession session, Model model) {
		System.out.println("뜬다" + push_alarm_id);
		System.out.println("aa:" + session.getAttribute("owner_store_id"));
		logger.info("알람 진입", session.getAttribute("owner_store_id"));
		// int result = pService.PushAlarmInsert(pushAlarm);
		// 이정보는 sql을 입력할 때 필요한 값이고
		// 양식 띄울 때에는 push_alarm_category 정보를 가져오는게 맞다
		PushAlarmVO push11 = pService.pushAlarmResend(push_alarm_id);
		
		model.addAttribute("push_alarm_category_id", pcService.PushAlarmCategorySelect());
		model.addAttribute("push_alarm", push11);
		System.out.println("push11값" + push11);
		return "pushAlarmResend";
	}

	@GetMapping("/pushAlarmList.do")
	public String PushAlarmList(HttpSession session, Model model) {
		// 서비스를 실행 모델에 붙여서 넘긴다
		int storeId = (int) session.getAttribute("owner_store_id");
		System.out.println("확인2차" + storeId);
		List<PushAlarmVO> pushAlarmList = pService.PushAlarmList(storeId);
		System.out.println("확인" + pushAlarmList);
		List<ArrayList<PushAlarmVO>> result_AlarmList = new ArrayList<ArrayList<PushAlarmVO>>();
		int cnt=0;
		int index = 0;
		result_AlarmList.add(new ArrayList<PushAlarmVO>());
		for(PushAlarmVO pushAlarm : pushAlarmList) {
			result_AlarmList.get(index).add(pushAlarm);
			cnt++;
			if(cnt == 4) {
				result_AlarmList.add(new ArrayList<PushAlarmVO>());
				index++;
				cnt=0;
			}
		}
		for(int i=0; i<result_AlarmList.size();i++) {
			if(result_AlarmList.get(i).size()==0) {
				result_AlarmList.remove(i);
			}
		}
		System.out.println(result_AlarmList);
		model.addAttribute("pushAlarmList", pushAlarmList);
		model.addAttribute("pushAlarmListIndex", result_AlarmList.size());
		System.out.println("확인3차");
		/*
		 * model.addAttribute("pushAlarmList", pushAlarmList); model.addAttribute("",);
		 * 
		 * logger.info("알람 목록 진입");
		 */
		return "pushAlarmList";
	}

	@PostMapping("/pushAlarmList.do")
	public String pushAlarmList(HttpSession session, Model model, PushAlarmDTO pushAlarm) {
		logger.info("포스트 알람", pushAlarm.toString());
		// PushAlarmDTO PushAlarm = new PushAlarmDTO();
		/*
		 * PushAlarm.setPush_alarm_store_id(store_id);
		 * PushAlarm.setPush_alarm_title("제목 테스트");
		 * PushAlarm.setPush_alarm_content("내용 테스트");
		 * PushAlarm.setPush_alarm_category_id(1); long time = 1702017070899L; Date date
		 * = new Date(time); PushAlarm.setPush_alarm_datetime(date);
		 * PushAlarm.setPush_alarm_to_target_id("대상테스트");
		 */

		int storeId = (int) session.getAttribute("owner_store_id");
		List<PushAlarmVO> pushAlarmList = pService.PushAlarmList(storeId);
		model.addAttribute("pushAlarmList", pushAlarmList);

		logger.info("pushAlarm", pushAlarm);
		pService.PushAlarmInsert(pushAlarm);
//		pService.PushAlarmInsert();

		// int result = pService.PushAlarmInsert(pushAlarm);
		// 이정보는 sql을 입력할 때 필요한 값이고
		// 양식 띄울 때에는 push_alarm_category 정보를 가져오는게 맞다
		return "redirect:/pushAlarmList.do";
	}

	@GetMapping("/pushAlarmInsert.do")
	public String PushAlarmInsert(Integer push_alarm_id, HttpSession session, Model model) {
		System.out.println("뜬다" + push_alarm_id);
		System.out.println("aa:" + session.getAttribute("owner_store_id"));
		logger.info("알람 진입", session.getAttribute("owner_store_id"));
		// int result = pService.PushAlarmInsert(pushAlarm);
		// 이정보는 sql을 입력할 때 필요한 값이고
		// 양식 띄울 때에는 push_alarm_category 정보를 가져오는게 맞다

		model.addAttribute("push_alarm_category_id", pcService.PushAlarmCategorySelect());
		return "pushAlarmInsert";
	}

	@PostMapping("/pushAlarmInsert.do")
	public String PushAlarmInsertPost(HttpSession session, Model model, PushAlarmDTO pushAlarm) {
		logger.info("포스트 알람", pushAlarm.toString());
		// PushAlarmDTO PushAlarm = new PushAlarmDTO();
		/*
		 * PushAlarm.setPush_alarm_store_id(store_id);
		 * PushAlarm.setPush_alarm_title("제목 테스트");
		 * PushAlarm.setPush_alarm_content("내용 테스트");
		 * PushAlarm.setPush_alarm_category_id(1); long time = 1702017070899L; Date date
		 * = new Date(time); PushAlarm.setPush_alarm_datetime(date);
		 * PushAlarm.setPush_alarm_to_target_id("대상테스트");
		 */

		int storeId = (int) session.getAttribute("owner_store_id");
		List<PushAlarmVO> pushAlarmList = pService.PushAlarmList(storeId);
		model.addAttribute("pushAlarmList", pushAlarmList);

		logger.info("pushAlarm", pushAlarm);
		pService.PushAlarmInsert(pushAlarm);
//		pService.PushAlarmInsert();

		// int result = pService.PushAlarmInsert(pushAlarm);
		// 이정보는 sql을 입력할 때 필요한 값이고
		// 양식 띄울 때에는 push_alarm_category 정보를 가져오는게 맞다
		return "redirect:/pushAlarmList.do";
	}
}
