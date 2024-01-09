package com.shinhan.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CalculateDayPriceDTO {
	private Timestamp date;
	private int price;
}

