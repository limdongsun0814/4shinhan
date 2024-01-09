package com.shinhan.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class PaymentDTO {
	private int payment_seq;
	private String payment_member_id;
	private String payment_store_id;
	private int payment_type;
	private String payment_request_content;
	private int payment_delivery_fee;
	private int payment_coupon_id;
	private int payment_mileage_price;
	private int payment_point_price;
	private Timestamp payment_date;
	private int payment_get_id;
	private String payment_address;
	private String payment_address_detail;
	private double payment_address_latitude;
	private double payment_address_longitude;
	private boolean payment_is_cancel;
	private String payment_cancel_content;
	private int payment_status_id;
	private int payment_predict_time;
	private int totalPrice;
	private int totalDiscountPrice;
	private int totalCount;
	private String member_ip_path;
	private String payment_get_content;
	private String payment_status_name;
	private String abstract_menu_name;
	private String member_phone;
	private String payment_type_name;
	private String payment_merchant_uid;
}
