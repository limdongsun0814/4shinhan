package com.shinhan.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MySubscribeDTO {
	private int payment_id;
	private String subscribe_store_name;
	private int subscribe_use_count;
	private Date subscribe_start_date;
	private String subscribe_store_img_path;
	private int subscribe_total_week;
	private String subscribe_case_content;
	private String subscribe_delivery_time;
	private String subscribe_member_name;
	
	//private String subscribe_name;
}
