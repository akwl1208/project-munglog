package kr.inyo.munglog.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	private int bd_num;
	private String bd_type;
	private int bd_mb_num;
	private Date bd_reg_date;
	private String bd_title;
	private	String bd_content;
	private int bd_views;
	private String bd_category;
	private String bd_ct_detail;
}
