package com.shinhan.dto;

import lombok.Builder;
import lombok.Data;
import lombok.ToString;


@ToString
@Data
@Builder
public class LoginDTO {
	String id;
	String password;
}
