package com.shinhan.dto;

import lombok.Data;

@Data
public class paymentProductInsertDTO {
	int payment_product_payment_id;
	String store_name;
	String menu_name;
	int payment_product_count;
	int payment_product_price;
	int payment_product_discount_price;
}
