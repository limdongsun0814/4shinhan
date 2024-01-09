package com.shinhan.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.shinhan.dto.CartProductVO;
import com.shinhan.dto.CartStoreDTO;
import com.shinhan.dto.MemberVO;
import com.shinhan.dto.TotalCartDTO;
import com.shinhan.dto.deleteCartDTO;
import com.shinhan.model.CartService;

@Controller
public class CartController {
	@Autowired
	CartService cart_service;	
	@PostMapping("/CartInsert.do")
	public String CartInser(Model model,HttpSession session,RedirectAttributes attr, CartProductVO CartProduct) {
		if(session.getAttribute("member")==null) {
			attr.addFlashAttribute("message","장바구니에 담으려면 먼저 로그인을 해주세요");
			return "redirect:/memberlogin.do";
		}
		MemberVO member=(MemberVO)session.getAttribute("member");
		CartProduct.setCart_product_member_id(member.getMember_id());
		System.out.println(CartProduct);
		
		int result=cart_service.insert_cart(CartProduct);
		if(result==0) {
			attr.addFlashAttribute("message","담기에 실패했습니다.");
		}else{
			attr.addFlashAttribute("message","담아졌습니다.");
			return "redirect:/cart.do";
		}
		return "redirect:/";
	}
	@PostMapping("/deleteCart.do")
	public String deleteCart(deleteCartDTO CartProduct,HttpSession session) {
		//가게에 메뉴 제거
		MemberVO member=(MemberVO)session.getAttribute("member");
		CartProduct.setMember_id(member.getMember_id());
		cart_service.delete_Cart(CartProduct);
		return"redirect:/cart.do";
	}
	@PostMapping("/deleteCartStore.do")
	public String deleteCartStore(deleteCartDTO CartProduct,HttpSession session) {
		//가게 제거
		MemberVO member=(MemberVO)session.getAttribute("member");
		CartProduct.setMember_id(member.getMember_id());
		cart_service.delete_cart_store(CartProduct);
		return"redirect:/cart.do";
	}
	
	@GetMapping("/cart.do")
	public String test(Model model,RedirectAttributes attr,@SessionAttribute(value="member",required = false) MemberVO member, HttpSession session) throws JsonProcessingException {
		if(session.getAttribute("member")==null) {
		  	attr.addFlashAttribute("message","로그인을 해주세요."); 
			return "redirect:/memberlogin.do";
		}
		String id = member.getMember_id();
		HashMap<String, Object> input = new HashMap<String, Object>();
		input.put("id", id);
		input.put("lng", (Double)session.getAttribute("lng"));
		input.put("lat", (Double)session.getAttribute("lat"));
		List<CartStoreDTO> cart_list = cart_service.get_cart_store_list(input);
		if(cart_list != null) {
			Map<String, ArrayList<CartStoreDTO>> result_cart = new HashMap<String, ArrayList<CartStoreDTO>>();
			Map<String, TotalCartDTO> total_cart = new HashMap<String, TotalCartDTO>();
			int total_price =0 ;
			int total_discount_price =0 ;
			int total =0;
			for(CartStoreDTO cart:cart_list) {
				
				if(result_cart.get(cart.getStore_name())==null) {
					result_cart.put(cart.getStore_name(), new ArrayList<CartStoreDTO>());
				}
				if(total_cart.get(cart.getStore_name())==null) {
					total_price =0 ;
					total_discount_price =0 ;
					total_cart.put(cart.getStore_name(), new TotalCartDTO());
				}
				result_cart.get(cart.getStore_name()).add(cart);
				
				total_price+=cart.getMenu_price();
				total_discount_price+=cart.getMenu_discount_price();
				total_cart.get(cart.getStore_name()).setStore_delivery_fee(cart.getStore_delivery_fee());
				total_cart.get(cart.getStore_name()).setTotal_price(total_price);
				total_cart.get(cart.getStore_name()).setTotal_discount_price(total_discount_price);
			
				total = total_price + cart.getStore_delivery_fee() - total_discount_price;
				total_cart.get(cart.getStore_name()).setTotal(total);
			}
			model.addAttribute("cart_list",result_cart); 
			model.addAttribute("total_cart",total_cart); 
			if(member!=null) {
				model.addAttribute("member",member); 
			}
		}
		return "cart/cart";
	}
	@PostMapping("/CartInsertOne.do")
	@ResponseBody
	public Map<String, Object> CartInsertOne(CartProductVO CartProduct,HttpSession session,RedirectAttributes attr) {
		Map<String, Object> result_map = new HashMap<String, Object>();
		if(session.getAttribute("member")==null) {
			result_map.put("login_check", false);
			result_map.put("result", "장바구니에 담으려면 먼저 로그인을 해주세요.");
		}else {
			result_map.put("login_check", true);
			MemberVO member = (MemberVO) session.getAttribute("member");
			CartProduct.setCart_product_count(1);
			CartProduct.setCart_product_member_id(member.getMember_id());
			System.out.println(CartProduct);
			int result=cart_service.insert_cart(CartProduct);
			if(result>0) {
				result_map.put("result", "담아졌습니다.");
			}else{
				result_map.put("result", "담기에 실패했습니다.");
			}
		}
		return result_map;
	}
	
	

}
