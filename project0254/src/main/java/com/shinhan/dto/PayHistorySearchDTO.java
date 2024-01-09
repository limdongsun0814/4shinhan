package com.shinhan.dto;


import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class PayHistorySearchDTO {
	int store_id;
	int month;
	int year;
}
