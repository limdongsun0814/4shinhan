package com.shinhan.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberVO {

	String member_id;
	String member_name;
	String member_nickname;
	String member_password;
	String member_email;
	String member_phone;
	String member_address;
	String member_address_detail;
	Double member_address_latitude;
	Double member_address_longitude;
	Date member_birthdate;
	int member_tier;
	boolean member_push_ok;
}
