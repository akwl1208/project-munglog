package kr.inyo.munglog.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class ReviewDTO {
	//화면에 필요한 변수
	private int rv_num;
	private int rv_od_num;
	private Date rv_reg_date;
	private int rv_rating;
	private String rv_content;
	private String rv_image;
	private String rv_report;
	//굿즈
	private int gs_num;
	private String gs_name; //굿즈명
	private String ot_name; //옵션명
	private String mb_nickname; //닉네임 
	
	public String getRv_image_url() {
		return "/review/img" + rv_image;
	}
	
	public String getRv_reg_date_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.format(rv_reg_date);
	}

}
