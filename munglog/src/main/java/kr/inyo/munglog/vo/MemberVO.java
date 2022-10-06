package kr.inyo.munglog.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private int mb_num;
	private String mb_email;
	private	String mb_pw;
	private String mb_name;
	private String mb_phone;
	private String mb_level = "M";
	private String mb_profile;
	private String mb_nickname;
	private String mb_greeting;
	private String mb_activity;
	private String mb_session_id;
	private Date mb_session_expir;
	private boolean saveId;
	
	public String getMb_profile_url() {
		return "/profile/img" + mb_profile;
	}
	
	//이메일 아이디
	public String getMb_email_id() {
		int index = mb_email.indexOf("@");
		return mb_email.substring(0,index);
	}
	
	//이메일 도메인
	public String getMb_email_domain() {
		int index = mb_email.indexOf("@");
		return mb_email.substring(index+1);
	}
}
