package com.shinhan.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class StoreListDTO {
	
	int store_id;
	String store_owner_id;
	boolean store_is_pickup;
	boolean store_is_delivery;
	boolean store_is_subscribe;
	String store_name;
	String store_address;
	String store_address_detail;
	Double store_address_latitude;
	Double store_address_longitude;
	String store_phone;
	int store_min_delivery_price;
	int store_avg_delivery_predict_time;
	String store_operation_hour;
	boolean store_is_open;
	String store_closed_date;
	String store_introduce;
	String store_made_in;
	int store_view_count;
	int store_pay_tier;
	int store_delivery_fee;
	Double store_avg_score_number;
	String store_ip_path;
	private String store_img_thumbnail_path;
	private String store_img_path;
	private Double distance;
}
