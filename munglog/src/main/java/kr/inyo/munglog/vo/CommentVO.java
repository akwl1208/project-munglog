package kr.inyo.munglog.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CommentVO {
	private int cm_num;
	private int cm_mb_num;
	private Date cm_reg_date;
	private	String cm_content;
	private int cm_bd_num;
	private int cm_dp_num;
	private String cm_report;
}
