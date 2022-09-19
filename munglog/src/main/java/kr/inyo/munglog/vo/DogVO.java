package kr.inyo.munglog.vo;

import java.util.Date;

import lombok.Data;

@Data
public class DogVO {
	private int dg_num;
	private int dg_mb_num;
	private int dg_name;
	private int dg_reg_num;
	private Date dg_birth;
}
