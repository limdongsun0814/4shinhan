package com.shinhan.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Data
//store_is_pickup 이랑 store_is_delivery 추가
public class OrderListDTO {
	private int order_id;
	private Date order_payment_date;
	private String order_store_image;
	private String order_store_name;
	private int order_status_id;
	private int order_delivery_fee;
	private int order_amount;
	private int order_discount_price;
	
	 
}
