package com.shinhan.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.shinhan.dto.CartStoreDTO;
import com.shinhan.dto.CartUpdateDTO;
import com.shinhan.dto.MemberVO;
import com.shinhan.model.CartService;

@Component
public class Cart {
	
	@Autowired
	CartService cart_service;
	
	public Model mini_cart(Model model,HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		System.out.println("mini_cart"+member);
		if(session.getAttribute("member")!=null) {
			HashMap<String, Object> input = new HashMap<String, Object>();
			input.put("id", member.getMember_id());
			input.put("lng", (Double)session.getAttribute("lng"));
			input.put("lat", (Double)session.getAttribute("lat"));
			System.out.println("aaaa"+(Double)session.getAttribute("lng"));
			List<CartStoreDTO> cart_list =cart_service.get_cart_store_list(input);
			Map<String, ArrayList<CartStoreDTO>> result_cart = new HashMap<String, ArrayList<CartStoreDTO>>();
			for(CartStoreDTO cart:cart_list) {
				if(result_cart.get(cart.getStore_name())==null) {
					result_cart.put(cart.getStore_name(), new ArrayList<CartStoreDTO>());
				}
				result_cart.get(cart.getStore_name()).add(cart);
			}
			System.out.println(cart_list);
			System.out.println(result_cart);
			model.addAttribute("cart_list",result_cart); 
		}
		return model;
	}
	
	public String payment(String storeName, String get_id,Model model,String[] menu,Integer fee_value,HttpSession session ) {
		System.out.println(storeName);
		System.out.println(get_id);
		System.out.println(Arrays.toString(menu));
		int total_price = 0;
		int total_dis_price =0;
		int total_cnt = 0;
		int total_fee =0;
		MemberVO member = (MemberVO)session.getAttribute("member");
		HashMap<String, Integer> menu_cnt = new HashMap<String, Integer>();
		HashMap<String, Integer> menu_disprice = new HashMap<String, Integer>();
		HashMap<String, Integer> menu_price = new HashMap<String, Integer>();
		for(String str:menu) {
			CartUpdateDTO cartupdate = new CartUpdateDTO();
			cartupdate.setStore_name(storeName);
			cartupdate.setMember_id(member.getMember_id());
			cartupdate.setMenu_name(str.split("_")[0]);
			cartupdate.setCnt(Integer.parseInt(str.split("_")[2]));
			cart_service.update_Cart(cartupdate);
			
			menu_cnt.put(str.split("_")[0], Integer.parseInt(str.split("_")[2]));
			menu_disprice.put(str.split("_")[0], Integer.parseInt(str.split("_")[3])*Integer.parseInt(str.split("_")[2]));
			menu_price.put(str.split("_")[0], Integer.parseInt(str.split("_")[1])*Integer.parseInt(str.split("_")[2]));
			
			total_dis_price += Integer.parseInt(str.split("_")[3])*Integer.parseInt(str.split("_")[2]);
			total_price += Integer.parseInt(str.split("_")[1])*Integer.parseInt(str.split("_")[2]);
			total_cnt += Integer.parseInt(str.split("_")[2]);
		}
		if(!get_id.equals("pick_up")) {
			total_fee= fee_value;
			System.out.println(fee_value);
		}
		int total = total_price - total_dis_price + total_fee;
		System.out.println(total_cnt);
		System.out.println(total_price);
		System.out.println(total_dis_price);
		System.out.println(total_fee);
		System.out.println(total);
		model.addAttribute("total_cnt",total_cnt);
		model.addAttribute("total_price",total_price);
		model.addAttribute("total_dis_price",total_dis_price);
		model.addAttribute("total_fee",total_fee);
		model.addAttribute("total",total);
		model.addAttribute("get_id",get_id);
		model.addAttribute("menu_cnt",menu_cnt);
		model.addAttribute("menu_disprice",menu_disprice);
		model.addAttribute("menu_price",menu_price);
//		PaymentDTO payment = new PaymentDTO();
//		payment.setPayment_member_id("dongdong");
//		payment.setPayment_store_id(1);
//		payment.setPayment_type(1);
//		payment.setPayment_request_content("테스트");
//		payment.setPayment_get_id(1);
//		payment.setPayment_address("test");
//		payment.setPayment_address_detail("test_상세");
//		payment.setPayment_address_latitude(12.123);
//		payment.setPayment_address_longitude(12.123);
//		payment_service.insert_payment(payment);
		return "payment/dongtest";
	}
}
