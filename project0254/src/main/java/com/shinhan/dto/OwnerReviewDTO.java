package com.shinhan.dto;

import java.sql.Timestamp;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class OwnerReviewDTO {
	
	private int payment_seq;
	private String owner_review_content;
	private Timestamp owner_review_date;
	
	
	
}
