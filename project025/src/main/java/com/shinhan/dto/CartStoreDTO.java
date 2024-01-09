package com.shinhan.dto;

import lombok.Data;

@Data
public class CartStoreDTO {
	String store_name;
	String menu_image_path;
	String menu_name;
	Integer menu_price;
	int menu_count;
	int menu_discount_price;
	int store_id;
	String store_ip_path;
	Integer store_delivery_fee;
	Boolean store_is_pickup;
	Boolean store_is_delivery;
	Integer cart_product_count;
	int distance;
}
