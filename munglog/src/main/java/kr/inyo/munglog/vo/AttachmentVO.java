package kr.inyo.munglog.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AttachmentVO {
	private int at_num;
	private int at_bd_num;
	private int at_dp_num;
	private String at_ori_name;
	private	String at_name;
	
	//생성자
	public AttachmentVO(int at_bd_num, String at_ori_name, String at_name) {
		this.at_bd_num = at_bd_num;
		this.at_ori_name = at_ori_name;
		this.at_name =at_name;
	}
}
