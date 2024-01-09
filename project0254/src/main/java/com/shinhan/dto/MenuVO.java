package com.shinhan.dto;

import lombok.Data;

@Data
public class MenuVO {
	 private int menu_id;
	 private int menu_store_id;
	 private int menu_category;
	 private String menu_name;
	 private String menu_image_path;
	 private String menu_thumb_image_path;
	 private int menu_count;
	 private int menu_price;
	 private String menu_describe;
	 private boolean menu_is_signature;
	 private boolean menu_is_hot;
	 private boolean menu_is_subscribe;
	 private int menu_discount_price;
	 private int menu_time;
	 private int menu_making_count;
}
