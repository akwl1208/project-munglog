package kr.inyo.munglog.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	private String or_code;
	private int or_mb_num;
	private int ad_num;
	private String or_email;
	private Date or_date;
	private String or_payment;
	private int or_point_amount;
	private int or_pay_amount;
	private Date or_refund_period;
}
