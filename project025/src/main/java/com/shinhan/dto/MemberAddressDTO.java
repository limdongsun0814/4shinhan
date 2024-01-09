package com.shinhan.dto;

import lombok.Data;

@Data
public class MemberAddressDTO {
	
	String member_address_member_id;
	String member_address_name;
	String member_address;
	String member_address_detail;
	double member_address_latitude;
	double member_address_longitude;

}
