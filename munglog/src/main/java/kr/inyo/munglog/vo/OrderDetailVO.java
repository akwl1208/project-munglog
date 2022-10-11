package kr.inyo.munglog.vo;

import lombok.Data;

@Data
public class OrderDetailVO {
	private int od_num;
	private String od_or_code;
	private int od_ot_num;
	private int od_amount;
	private int od_total_price;
	private String od_state;
}
