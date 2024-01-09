package com.shinhan.dto;

import lombok.Data;

@Data
public class CalculateMenuPriceDTO {
	private String menu_name;
	private int total_price;
}