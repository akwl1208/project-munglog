package kr.inyo.munglog.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AddressVO {
	private int ad_num;
	private int ad_mb_num;
	private String ad_name;
	private	String ad_recipient;
	private String ad_phone;
	private String ad_post_code;
	private String ad_address;
	private String ad_detail;
	private String ad_main;
	private String ad_request;
	
	//생성자
	public AddressVO(int mbNum, String recipient, String phone, String postcode, String address, String detail, String request) {
		this.ad_mb_num = mbNum;
		this.ad_recipient = recipient;
		this.ad_phone = phone;
		this.ad_post_code = postcode;
		this.ad_address = address;
		this.ad_detail = detail;
		this.ad_request = request;
	}

	//010 추출
	public String getAd_phone_first() {
		int index = ad_phone.indexOf("-");
		return ad_phone.substring(0,index);
	}
	//가운데 번호 추출
	public String getAd_phone_middle() {
		int startIndex = ad_phone.indexOf("-");
		int endIndex = ad_phone.lastIndexOf("-");
		return ad_phone.substring(startIndex+1,endIndex);
	}
	//끝 번호 추출
	public String getAd_phone_last() {
		int index = ad_phone.lastIndexOf("-");
		return ad_phone.substring(index+1);
	}
}
