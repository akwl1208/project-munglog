package kr.inyo.munglog.vo;

import java.text.SimpleDateFormat;
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
	
	public String getLg_reg_date_time() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		return format.format(lg_reg_date);
	}
	
	public String getLg_image_url() {
		return "/log/img" + lg_image;
	}
}
