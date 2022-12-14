package kr.inyo.munglog.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ChallengeVO {
	private int cl_num;
	private String cl_thumb;
	private String cl_year;
	private String cl_month;
	private String cl_theme;
	private String cl_banner;
	
	//생성자
	public ChallengeVO(String cl_year, String cl_month, String cl_theme) {
		this.cl_year = cl_year;
		this.cl_month = cl_month;
		this.cl_theme = cl_theme;
	}

	public ChallengeVO(int cl_num, String cl_year, String cl_month, String cl_theme) {
		this.cl_num = cl_num;
		this.cl_year = cl_year;
		this.cl_month = cl_month;
		this.cl_theme = cl_theme;
	}
	
	public String getCl_thumb_url() {
		return "/challenge/img" + cl_thumb;
	}
	
	public String getCl_banner_url() {
		return "/challenge/img" + cl_banner;
	}
}
