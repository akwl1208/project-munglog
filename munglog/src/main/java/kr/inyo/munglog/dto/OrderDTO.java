package kr.inyo.munglog.dto;

import java.text.DecimalFormat;

import lombok.Data;

@Data
public class OrderDTO {
	//받아야하는 변수
	private int otNum; //옵션번호
	private int orAmount; //구매수량
	//화면에 필요한 변수
	private String ot_name; //옵션명
	private int ot_price; //옵션 가격(판매가격)
	private int gs_num; //제품 번호(클릭하면 굿즈 상세보기로)
	private String gs_thumb; //썸네일
	private String gs_name; //상품명
	private int totalPrice;
	
	public String getGs_thumb_url() {
		return "/goods/img" + gs_thumb;
	}
	
	public String getOt_price_str() {
		DecimalFormat format = new DecimalFormat("#,###");
		String str = format.format(ot_price) + "원";
		return str;
	}
	
	public int getTotalPrice() {
		int totalPrice = ot_price*orAmount;
		return totalPrice;
	}
	
	public String getTotalPrice_str() {
		DecimalFormat format = new DecimalFormat("#,###");
		String str = format.format(ot_price*orAmount) + "원";
		return str;
	}
}
