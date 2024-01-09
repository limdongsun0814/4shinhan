package com.shinhan.dto;

import lombok.Builder;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class SignUpDTO {
	String id;
	String password;
	String name;
	String email;
	String phone;
	String address;
	String address_detail;
	String address_longitude;
	String address_latitude;
	String regist_code;
}
