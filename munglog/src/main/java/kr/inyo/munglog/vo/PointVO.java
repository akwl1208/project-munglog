package kr.inyo.munglog.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class PointVO {
	private int pi_num;
	private int pi_mb_num;	
	private String pi_process; //적립 또는 사용
	private Date pi_date;
	private	String pi_history;
	private int pi_amount;
	
	public String getPi_date_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.format(pi_date);
	}
}
