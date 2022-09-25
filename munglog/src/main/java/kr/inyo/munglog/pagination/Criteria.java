package kr.inyo.munglog.pagination;

import lombok.Data;

@Data
public class Criteria {
	
	//현재 페이지
	private int page; 
	//한 페이지 당 컨텐츠 갯수
	private int perPageNum;
	//회원 번호
	private int mb_num; 
	//강아지 번호
	private int dg_num;
	//년도
	private String regYear; 
	
	
	//Criteria 디폴트 생성자 : 현재 페이지를 1페이지로, 한 페이지에 12개의 컨텐츠
	public Criteria() {
		this.page = 1;
		this.perPageNum = 12;
		this.mb_num = 0;
		this.dg_num = 0;
		this.regYear = "";
	}
	
	/* 쿼리문에서 limit에 사용되는 인덱스를 계산하는 getter */
	public int getPageStart() {
		return (this.page -1) * perPageNum;
	}
}