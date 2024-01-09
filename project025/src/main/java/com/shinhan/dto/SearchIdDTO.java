package com.shinhan.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class SearchIdDTO {
	String search_id_name;
	String search_id_phone;
	Date search_id_birthdate;
}
