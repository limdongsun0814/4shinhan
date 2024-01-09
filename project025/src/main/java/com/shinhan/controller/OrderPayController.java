package com.shinhan.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.shinhan.dto.LoginDTO;
import com.shinhan.dto.MemberAddressDTO;
import com.shinhan.dto.MemberAddressVO;
import com.shinhan.dto.MemberVO;
import com.shinhan.dto.OrderPayDTO;
import com.shinhan.dto.PaymentDTO;
import com.shinhan.dto.PaymentTypeVO;
import com.shinhan.dto.deleteCartDTO;
import com.shinhan.dto.getStoreId;
import com.shinhan.dto.paymentProductInsertDTO;
import com.shinhan.dto.paymentResultDTO;
import com.shinhan.model.CartService;
import com.shinhan.model.LoginService;
import com.shinhan.model.MemberService;
import com.shinhan.model.PayMentService;
import com.shinhan.util.Cart;

@Controller
public class OrderPayController {

	Logger logger = LoggerFactory.getLogger(OrderPayController.class);


	@Value("${imp.api.key}")
	private String apiKey;

	@Value("${imp.api.secretkey}")
	private String secretKey;

	@Autowired
	MemberService member_service;

	@Autowired
	PayMentService payment_service;

	@Autowired
	Cart cart;
	@Autowired
	CartService cart_service;

	@Autowired
	LoginService login_service;

	@PostMapping("/payment/paymentend.do")
	public String paymentend(int store_id, String store_ip_path, RedirectAttributes attr, int total_fee, int mileage,
			String address_name, String[] menu, String payment_get_id, String payment_request_content, int payment_type,
			String store_name, @RequestParam(required = false) String payment_merchant_uid, HttpSession session,
			@SessionAttribute("member") MemberVO member) {
		PaymentDTO payment = new PaymentDTO();
		payment.setPayment_type(payment_type);
		payment.setPayment_request_content(payment_request_content);
		payment.setPayment_get_id(payment_get_id.equals("delivery") ? 1 : 2);
		payment.setMileage(mileage);
		if(payment_merchant_uid!=null) {
			payment.setPayment_merchant_uid(payment_merchant_uid);
		}
		paymentResultDTO paymentProduct_list = new paymentResultDTO();
		List<paymentProductInsertDTO> menu_list = new ArrayList<paymentProductInsertDTO>();

		if (payment_get_id.equals("delivery")) {
			MemberAddressVO memberaddress = new MemberAddressVO();
			memberaddress.setMember_address_name(address_name);
			memberaddress.setMember_address_member_id(member.getMember_id());
			memberaddress = member_service.get_memberaddress(memberaddress);

			payment.setPayment_address(memberaddress.getMember_address());
			payment.setPayment_address_detail(memberaddress.getMember_address_detail());
			payment.setPayment_address_latitude(memberaddress.getMember_address_latitude());
			payment.setPayment_address_longitude(memberaddress.getMember_address_longitude());

			paymentProduct_list.setPayment_address(memberaddress.getMember_address());
			paymentProduct_list.setPayment_address_detail(memberaddress.getMember_address_detail());
		}

		payment.setPayment_member_id(member.getMember_id());
		getStoreId getstoreid = new getStoreId();
		getstoreid.setStore_name(store_name);
		getstoreid.setMenu_name(menu[0].split("_")[0]);
		System.out.println(payment);

		int payment_seq = payment_service.insert_payment(payment, getstoreid);
		paymentProduct_list.setPayment_date(payment_service.get_payment_date(payment_seq - 1));
		paymentProduct_list.setPayment_seq(payment_seq);
		paymentProduct_list.setMember_name(member.getMember_name());
		paymentProduct_list.setMember_phone(member.getMember_phone());
		paymentProduct_list.setPayment_request_content(payment_request_content);

		int total_cnt = 0;
		int total_not_discount_price = 0;
		int total_discount_price = 0;
		int store_delivery_fee = 0;
		int total_price = 0;

		for (String menu_one : menu) {

			deleteCartDTO deleteCart = new deleteCartDTO();
			deleteCart.setMember_id(member.getMember_id());
			deleteCart.setMenu_name(menu_one.split("_")[0]);
			deleteCart.setStore_name(store_name);
			cart_service.delete_Cart(deleteCart);

			paymentProductInsertDTO payProductInsert = new paymentProductInsertDTO();
			payProductInsert.setPayment_product_payment_id(payment_seq - 1);
			payProductInsert.setMenu_name(menu_one.split("_")[0]);
			payProductInsert.setPayment_product_count(Integer.parseInt(menu_one.split("_")[1]));
			payProductInsert.setPayment_product_discount_price(Integer.parseInt(menu_one.split("_")[2]));
			payProductInsert.setPayment_product_price(Integer.parseInt(menu_one.split("_")[3]));
			payProductInsert.setStore_name(store_name);
			payment_service.insert_payment_product(payProductInsert);

			total_cnt += Integer.parseInt(menu_one.split("_")[1]);
			total_not_discount_price += Integer.parseInt(menu_one.split("_")[3]);
			total_discount_price += Integer.parseInt(menu_one.split("_")[2]);

			menu_list.add(payProductInsert);
		}

		if (payment_get_id.equals("delivery")) {
			store_delivery_fee = total_fee;
		}

		total_price = total_not_discount_price - total_discount_price + store_delivery_fee;
		paymentProduct_list.setMenu_list(menu_list);

		paymentProduct_list.setTatal_cnt(total_cnt);
		paymentProduct_list.setTotal_not_discount_price(total_not_discount_price);
		paymentProduct_list.setTotal_discount_price(total_discount_price);
		paymentProduct_list.setStore_delivery_fee(store_delivery_fee);
		paymentProduct_list.setTotal_price(total_price);
		paymentProduct_list.setPayment_get_id(payment_get_id);

		LoginDTO login = new LoginDTO();
		login.setId(member.getMember_id());
		login.setPassword(member.getMember_password());
		MemberVO member_new = login_service.login_check(login);
		session.setAttribute("member", member_new);

		attr.addFlashAttribute("payment_seq", payment_seq - 1);
		attr.addFlashAttribute("paymentProduct_list", paymentProduct_list);

		attr.addFlashAttribute("store_id", store_id);
		attr.addFlashAttribute("store_ip_path", store_ip_path);

		return "redirect:/payment/paymentend.do";
	}

	@GetMapping("/payment/paymentend.do")
	public String paymentList(HttpServletRequest request, Model model) {
		Map<String, ?> flashData = RequestContextUtils.getInputFlashMap(request);
		logger.info(flashData.toString());
		if(flashData!=null) {
			for(String key:flashData.keySet()) {
				model.addAttribute(key,flashData.get(key));
			}
		}
		return "payment/paymentend";
	}

//	@GetMapping("/memberDeliverAddressInfo.do")
	@PostMapping("/payment/paymentInsert.do")
	public String memberAddressTest(int store_id, String store_ip_path, String storeName, String get_id, Model model,
			String[] menu, Integer fee_value, HttpSession session) {
		System.out.println(store_ip_path);
		MemberVO membervo = (MemberVO) session.getAttribute("member");
		cart.payment(storeName, get_id, model, menu, fee_value, session);
		List<PaymentTypeVO> paymenttype = payment_service.selectAllPaymentType();

		String memberId = membervo.getMember_id();

		System.out.println("여기는 oderpage :" + membervo.toString());
		System.out.println(memberId);
		System.out.println(paymenttype.toString());

		List<MemberAddressDTO> member_address = member_service.get_memberaddress_list(memberId);
		Map<String, MemberAddressDTO> member_address_map = new HashMap<String, MemberAddressDTO>();
		Map<Integer, String> payment_type_use = new HashMap<Integer, String>();
		for (MemberAddressDTO data : member_address) {
			System.out.println(data);
			member_address_map.put(data.getMember_address_name(), data);
		}
		model.addAttribute("storeName", storeName);
		model.addAttribute("member_address_list", member_address);
		model.addAttribute("member_address_map", member_address_map);
		model.addAttribute("login_member_id", memberId);
		model.addAttribute("login_member_phone", membervo.getMember_phone());
		model.addAttribute("get_id", get_id);
		model.addAttribute("member", membervo);
		model.addAttribute("store_id", store_id);
		model.addAttribute("store_ip_path", store_ip_path);
		for (PaymentTypeVO typedata : paymenttype) {
			System.out.println(typedata);
			payment_type_use.put(typedata.getPayment_type_seq(), typedata.getPayment_type());

		}

		model.addAttribute("payment_type_use", paymenttype);

		return "oderpayPage02";
	}

	@PostMapping("/payment/addmoreAddress.do")
	public String addmorAddress(HttpSession session, Model model, MemberAddressDTO MemberAddress) {

		MemberVO member = (MemberVO) session.getAttribute("member");
		String member_id = member.getMember_id();
		MemberAddress.setMember_address_member_id(member_id);

		System.out.println(MemberAddress);
		int result = member_service.addMoreMemberAddress(MemberAddress);
		System.out.println(result);
		List<MemberAddressDTO> member_address = member_service.get_memberaddress_list(member_id);
		Map<String, MemberAddressDTO> member_address_map = new HashMap<String, MemberAddressDTO>();

		for (MemberAddressDTO data : member_address) {
			System.out.println(data);
			member_address_map.put(data.getMember_address_name(), data);
		}

		if (result == 0) {
			model.addAttribute("message", "다른 배송지명을 입력해주세요.");
		} else {
			model.addAttribute("message", "배송지가 추가되었습니다.");
		}

		model.addAttribute("member_address_list", member_address);
		model.addAttribute("member_address_map", member_address_map);
		model.addAttribute("login_member_id", member_id);
		model.addAttribute("login_member_phone", member.getMember_phone());

		return "ajax/addressAjax";
	}
}
