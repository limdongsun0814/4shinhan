package com.shinhan.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MyReviewDTO {
	
	private int payment_seq;
	private String member_review_title;
	private String member_review_content;
	private String member_review_img_path;
	private Timestamp member_review_date;
	private boolean member_review_recommend;
	private int member_review_score_number;
	private String owner_review_content;
	private Timestamp owner_review_date;
	private String member_review_member_id;
	private Timestamp payment_date;
	private int total_payment_product_count;
	private String menu_name;
}
