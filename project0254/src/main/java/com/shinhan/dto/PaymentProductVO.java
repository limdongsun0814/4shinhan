package com.shinhan.dto;

import lombok.Data;

@Data
public class PaymentProductVO {
	private int payment_product_payment_id;
	private int payment_product_menu_id;
	private int payment_product_count;
	private int payment_product_price;
	private int payment_product_discount_price;
	private String payment_product_menu_name;
}
