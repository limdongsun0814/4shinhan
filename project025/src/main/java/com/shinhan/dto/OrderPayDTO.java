package com.shinhan.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class OrderPayDTO {
	private String store_name;
	private int payment_type;
	private String payment_get_id;
	private int total_fee;
	private int store_id;
	private String store_ip_path;
	private String payment_request_content;
	private String address_name;
	private int mileage;
	private String[] arr;
}
