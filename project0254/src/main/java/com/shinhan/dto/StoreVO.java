package com.shinhan.dto;

import lombok.Data;

@Data
public class StoreVO {
	private int store_id;
	private String store_owner_id;
	private boolean store_is_pickup;
	private boolean store_is_delivery;
	private boolean store_is_subscribe;
	private String store_name;
	private String store_address;
	private String store_address_detail;
	private double store_address_latitude;
	private double store_address_longitude;
	private String store_phone;
	private int store_min_delivery_price;
	private int store_avg_delivery_predict_time;
	private String store_operation_hour;
	private boolean store_is_open;
	private String store_closed_date;
	private String store_introduce;
	private String store_made_in;
	private int store_view_count;
	private int store_pay_tier;
	private int store_delivery_fee;
	private String store_ip_path;
	private String store_img_thumbnail_path;
	private String store_img_path;
}
