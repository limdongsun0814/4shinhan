package com.shinhan.dto;

import lombok.Data;

@Data
public class TotalCartDTO {
	Integer total_price;
	Integer total_discount_price;
	Integer store_delivery_fee;
	Integer total;
}
