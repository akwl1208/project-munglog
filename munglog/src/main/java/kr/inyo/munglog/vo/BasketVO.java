package kr.inyo.munglog.vo;

import java.util.ArrayList;
import java.util.Date;

import lombok.Data;

@Data
public class BasketVO {
	private int bs_num;
	private int bs_mb_num;
	private int bs_ot_num;
	private int bs_amount;
	private Date bs_expir_date;
	//옵션 리스트 -> 장바구니 담을 때
	private ArrayList<OptionVO> optionList;
}
