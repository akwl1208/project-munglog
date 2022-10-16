package kr.inyo.munglog.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReviewVO {
	private int rv_num;
	private int rv_od_num;
	private Date rv_reg_date;
	private String rv_rating;
	private	String rv_content;
	private String rv_image;
	private String rv_report;
	
	//생성자
	public ReviewVO(int rv_od_num, String rv_rating, String rv_content, String rv_image) {
		this.rv_od_num = rv_od_num;
		this.rv_rating = rv_rating;
		this.rv_content = rv_content;
		this.rv_image = rv_image;
	}
	
	public ReviewVO(int rv_num, int rv_od_num, String rv_rating, String rv_content, String rv_image) {
		this.rv_num = rv_num;
		this.rv_od_num = rv_od_num;
		this.rv_rating = rv_rating;
		this.rv_content = rv_content;
		this.rv_image = rv_image;
	}
	
	public String getRv_image_url() {
		return "/review/img" + rv_image;
	}
}
