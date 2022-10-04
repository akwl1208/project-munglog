package kr.inyo.munglog.pagination;

import lombok.Data;

@Data
public class Criteria {
	
	//현재 페이지
	private int page; 
	//한 페이지 당 컨텐츠 갯수
	private int perPageNum;
	//회원 번호
	private int mb_num = 0; 
	//강아지 번호
	private int dg_num = 0;
	//년도
	private String regYear = ""; 
	//날짜순
	private String order = "desc";
	//인기순
	private int popularity = 0;
	//챌린지 번호
	private int cl_num = 0;
	//검색기능
	private String searchType = "";
	private String keyword = "";
	
	
	//Criteria 디폴트 생성자 : 현재 페이지를 1페이지로, 한 페이지에 12개의 컨텐츠
	public Criteria() {
		this.page = 1;
		this.perPageNum = 12;
		this.mb_num = 0;
		this.dg_num = 0;
		this.regYear = "";
		this.order = "desc";
		this.popularity = 0;
		this.cl_num = 0;
		this.searchType = "";
		this.keyword = "";
	}
	
	/* 쿼리문에서 limit에 사용되는 인덱스를 계산하는 getter */
	public int getPageStart() {
		return (this.page -1) * perPageNum;
	}
}