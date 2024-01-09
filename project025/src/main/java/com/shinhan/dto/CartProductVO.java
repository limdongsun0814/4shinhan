package com.shinhan.dto;

import lombok.Data;

@Data
public class CartProductVO {
	String cart_product_member_id;
	int cart_product_menu_id;
	int cart_product_count;
	boolean cart_product_is_check;
}
