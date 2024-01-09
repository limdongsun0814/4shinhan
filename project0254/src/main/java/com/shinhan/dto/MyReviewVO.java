package com.shinhan.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MyReviewVO {
	
	private int payment_seq;
	private String member_review_title;
	private String member_review_content;
	private String member_review_img_path;
	private Date member_review_date;
	private boolean member_review_recommend;
	private int member_review_score_number;
	private String owner_review_content;
	private Date owner_review_date;
	private String member_review_member_id;
}
