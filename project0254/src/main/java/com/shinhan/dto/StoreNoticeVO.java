package com.shinhan.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class StoreNoticeVO {
	
	private int store_notice_seq;
	private int store_notice_store_id;
	private String store_notice_title;
	private String store_notice_content;
	private String store_notice_img_path;
	private Timestamp store_notice_date;
	private int store_notice_view_count;
}
