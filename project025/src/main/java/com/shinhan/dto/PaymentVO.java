package com.shinhan.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class PaymentVO {
	private int payment_seq;
	private String payment_member_id;
	private int payment_store_id;
	private int payment_type;
	private String payment_request_content;
	private int payment_delivery_fee;
	private int payment_coupon_id;
	private int payment_mileage_price;
	private int payment_point_price;
	private Date payment_date;
	private int payment_get_id;
	private String payment_address;
	private String payment_address_detail;
	private Double payment_address_latitude;
	private Double payment_address_longitude;
	private boolean payment_is_cancel;
	private String payment_cancel_content;
	private int payment_status_id;
	private int payment_predict_time;
	
	private String store_name;
	private int total_amount;
}
