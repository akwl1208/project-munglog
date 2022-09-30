package kr.inyo.munglog.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class DogVO {
	private int dg_num;
	private int dg_mb_num;
	private String dg_name;
	private String dg_reg_num;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date dg_birth;
	
	public String getDg_birth_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.format(dg_birth);
	}
}
