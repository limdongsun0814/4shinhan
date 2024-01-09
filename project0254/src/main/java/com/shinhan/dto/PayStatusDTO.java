package com.shinhan.dto;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class PayStatusDTO {
	int payment_seq;
	int payment_status_id;
	int payment_get_id;
}
