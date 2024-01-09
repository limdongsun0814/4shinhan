package com.shinhan.model;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.CartProductVO;
import com.shinhan.dto.CartStoreDTO;
import com.shinhan.dto.CartUpdateDTO;
import com.shinhan.dto.deleteCartDTO;

@Service
public class CartService {
	@Autowired
	CartDAO cart_dao;
	public List<CartStoreDTO> get_cart_store_list(HashMap<String, Object> id) {
		return cart_dao.get_cart_store_list(id);
	}

	public void update_Cart(CartUpdateDTO cartUpdate) {
		cart_dao.update_Cart(cartUpdate);
	}
	public void delete_Cart(deleteCartDTO deleteCart) {
		cart_dao.delete_Cart(deleteCart);
	}
	public int insert_cart(CartProductVO cartproduct) {
		return cart_dao.insert_cart(cartproduct);
	}
	public void delete_cart_store(deleteCartDTO deleteCart) {
		cart_dao.delete_cart_store(deleteCart);
	}
	
}
