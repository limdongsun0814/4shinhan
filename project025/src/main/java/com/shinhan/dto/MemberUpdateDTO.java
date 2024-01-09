package com.shinhan.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MemberUpdateDTO {
	
	private String member_id;
	private String member_email;
	private String member_address;
	private String member_address_detail;
	private Double member_address_latitude;
	private Double member_address_longitude;
	private String member_password;
	private String member_nickname;
	
}
