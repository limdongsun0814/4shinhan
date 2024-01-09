package com.shinhan.dto;

import lombok.Data;

@Data
public class CartUpdateDTO {
	String menu_name;
	String store_name;
	String member_id;
	int cnt;
}
