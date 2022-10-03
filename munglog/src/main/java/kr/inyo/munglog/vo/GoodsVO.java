package kr.inyo.munglog.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GoodsVO {
	private int gs_num;
	private String gs_ct_name;
	private String gs_thumb;
	private String gs_name;
	private Date gs_reg_date;
	private String gs_description;
	private String gs_guidance;
}
