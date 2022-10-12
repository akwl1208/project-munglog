package kr.inyo.munglog.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class QnaDTO {
	//화면에 필요한 변수
	private int qn_num; 
	private int qn_bd_num;
	private int qn_gs_num;
	private String qn_state; //답변 상태
	private String gs_thumb; //굿즈 썸네일
	private String gs_name; //굿즈명
	private int bd_mb_num; //해당회원만 상세 보기로 
	private Date bd_reg_date; //등록일
	private String bd_title; //제목
	private String bd_content; //내용
	private String mb_nickname; //닉네임
	
	public String getGs_thumb_url() {
		return "/goods/img" + gs_thumb;
	}
	
	public String getBd_reg_date_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.format(bd_reg_date);
	}

}
