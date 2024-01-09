package com.shinhan.dto;

import lombok.Data;

@Data
public class paymentProductVO {
	int payment_product_payment_id;
	int payment_product_menu_id;
	int payment_product_count;
	int payment_product_price;
	int payment_product_discount_price;
	String payment_product_menu_name;
}
