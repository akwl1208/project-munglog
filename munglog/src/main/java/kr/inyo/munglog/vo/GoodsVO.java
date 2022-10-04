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
	//가격 : 옵션 가격 중 가장 낮은 가격
	private int gs_price;
	
	public String getGs_thumb_url() {
		return "/goods/img" + gs_thumb;
	}
}
