package kr.inyo.munglog.vo;

import java.util.Date;

import lombok.Data;

@Data
public class LogVO {
	private int lg_num;
	private int lg_mb_num;
	private Date lg_reg_date;
	private String lg_image;
	private int lg_views;
	private String lg_report;
}
