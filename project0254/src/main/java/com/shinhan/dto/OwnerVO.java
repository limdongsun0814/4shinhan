package com.shinhan.dto;

import lombok.Data;

@Data
public class OwnerVO{
	String owner_id;
	String owner_name;
	String owner_password;
	String owner_email;
	String owner_phone;
	String owner_address;
	String owner_address_detail;
	Double owner_address_latitude;
	Double owner_address_longitude;
	String owner_regist_code;
}
