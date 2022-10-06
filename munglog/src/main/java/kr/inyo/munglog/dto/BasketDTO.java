package kr.inyo.munglog.dto;

import java.text.DecimalFormat;
import java.util.Date;

import lombok.Data;

@Data
public class BasketDTO {
	private int bs_num;
	private int bs_mb_num;
	private int bs_ot_num;
	private int bs_amount;
	private Date bs_expir_date;
	//장바구니 가져올 때 필요한 변수
	private String ot_name; //옵션명
	private int ot_amount;
	private int ot_price; //옵션 가격(판매가격)
	private int gs_num; //제품 번호(클릭하면 굿즈 상세보기로)
	private String gs_thumb; //썸네일
	private String gs_name; //상품명
	
	public String getGs_thumb_url() {
		return "/goods/img" + gs_thumb;
	}
	
	public String getOt_price_str() {
		DecimalFormat format = new DecimalFormat("#,###");
		String str = format.format(ot_price) + "원";
		return str;
	}
	
	public String getOt_price_total() {
		DecimalFormat format = new DecimalFormat("#,###");
		String str = format.format(ot_price*bs_amount) + "원";
		return str;
	}
}
