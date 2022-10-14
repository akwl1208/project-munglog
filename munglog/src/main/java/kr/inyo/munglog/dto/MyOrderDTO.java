package kr.inyo.munglog.dto;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class MyOrderDTO {
	//화면에 필요한 변수
	private int od_num; //주문 상세
	private String or_code; //주문
	private int ot_num; //옵션
	private int ad_num; //배송
	private int gs_num; //굿즈 
	//주문 상세
	private int od_amount;
	private int od_total_price;
	private String od_state;
	//주문
	private Date or_date;
	private int or_point_amount;
	private int or_pay_amount;
	private Date or_refund_period; //환불 가능 기간
	//옵션
	private String ot_name;
	//굿즈
	private String gs_thumb;
	private String gs_name;
	//배송지
	private String ad_recipient;
	private String ad_phone;
	private String ad_post_code;
	private String ad_address;
	private String ad_detail;
	private String ad_request;
	
	public String getGs_thumb_url() {
		return "/goods/img" + gs_thumb;
	}
	
	public String getOd_total_price_str() {
		DecimalFormat format = new DecimalFormat("#,###");
		String str = format.format(od_total_price) + "원";
		return str;
	}
	
	public String getOd_amount_str() {
		return od_amount + "개";
	}
	
	public String getOr_date_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.format(or_date);
	}
}
