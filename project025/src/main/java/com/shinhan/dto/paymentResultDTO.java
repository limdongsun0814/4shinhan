package com.shinhan.dto;

import java.util.List;

import lombok.Data;

@Data
public class paymentResultDTO {
	String payment_date;  //체크 사항
	int payment_seq;
	String member_name;
	String member_phone;
	String payment_address;
	String payment_address_detail;
	String payment_request_content;  
	List<paymentProductInsertDTO> menu_list;  //완
	int tatal_cnt;
	int total_not_discount_price;
	int total_discount_price;
	int store_delivery_fee;
	int total_price;
	String payment_get_id;
}
