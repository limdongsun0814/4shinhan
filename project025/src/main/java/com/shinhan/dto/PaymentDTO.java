package com.shinhan.dto;

import lombok.Data;

@Data
public class PaymentDTO {
	String payment_member_id; //o
	int payment_store_id;
	int payment_type;  //o
	String payment_request_content; //o
	int payment_get_id; //o
	String payment_address; //o
	String payment_address_detail; //o
	double payment_address_latitude; //o
	double payment_address_longitude; //o
	int payment_seq;
	int mileage;
	String payment_merchant_uid;
}
