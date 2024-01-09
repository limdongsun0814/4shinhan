package com.shinhan.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CalculateDayCountDTO {
	private Timestamp date;
	private int count;
}
