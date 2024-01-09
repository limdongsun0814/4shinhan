package com.shinhan.dto;

import java.sql.Date;

import lombok.Data;


@Data
public class memberSingUpDTO {
	
	
	String id;
	String name;
	String nickname;
	String password;
	String email;
	String phone;
	String address;
	String address_detail;
	Double address_latitude;
	Double address_longitude;
	Date birthday;

}
