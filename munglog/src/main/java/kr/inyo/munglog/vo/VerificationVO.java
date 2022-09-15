package kr.inyo.munglog.vo;

import lombok.Data;

@Data
public class VerificationVO {
	private String vr_email;
	private	String vr_veri_code;
	private int vr_failure_count;
}
