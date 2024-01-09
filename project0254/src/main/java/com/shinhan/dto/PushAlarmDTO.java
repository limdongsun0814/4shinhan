package com.shinhan.dto;

import java.sql.Date;
import lombok.Data;

@Data
public class PushAlarmDTO {
	private int push_alarm_store_id;
	private String push_alarm_title;
	private String push_alarm_content;
	private int push_alarm_category_id;
	private Date push_alarm_datetime;
	private String push_alarm_to_target_id;
}
