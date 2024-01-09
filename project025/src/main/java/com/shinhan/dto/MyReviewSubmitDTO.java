package com.shinhan.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Data
public class MyReviewSubmitDTO {
	private int payment_seq;
	private String member_review_title;
	private String member_review_content;
	private String member_review_img_path;
	private Date member_review_date;
	private boolean member_review_recommend;
	private int member_review_score_number;
	private String member_review_member_id;
}
