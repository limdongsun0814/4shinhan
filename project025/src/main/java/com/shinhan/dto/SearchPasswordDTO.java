package com.shinhan.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class SearchPasswordDTO {
	String search_password_id;
	Date search_password_brithday;
	String search_password_phone;
	String search_password_name;
}
