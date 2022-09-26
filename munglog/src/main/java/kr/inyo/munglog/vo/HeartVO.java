package kr.inyo.munglog.vo;

import java.util.Date;

import lombok.Data;

@Data
public class HeartVO {
	private int ht_num;
	private int ht_mb_num;
	private int ht_lg_num;
	private Date ht_reg_date;
	private String ht_state;
}
