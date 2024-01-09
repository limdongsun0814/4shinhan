package com.shinhan.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class BestMenuDTO {
	private int menu_id;
	private String store_name;
	private int menu_category;
	private String menu_name;
	private String menu_thumb_image_path;
	private int menu_price;
	private Boolean menu_is_signature;
	private Integer menu_discount_price;
}
