package kr.inyo.munglog.dao;

import java.util.ArrayList;

import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.CategoryVO;
import kr.inyo.munglog.vo.GoodsVO;
import kr.inyo.munglog.vo.OptionVO;

public interface GoodsDAO {
	/* 카테고리 ======================================================================================= */
	ArrayList<CategoryVO> selectCategoryList();
	
	/* 굿즈 ======================================================================================= */
	//굿즈 리스트 가져오기
	ArrayList<GoodsVO> selectGoodsList(Criteria cri);
	//굿즈 총 개수 가져오기
	int selectGoodsTotalCount(Criteria cri);
	//굿즈 번호로 굿즈 정보 가져오기
	GoodsVO selectGoods(int gs_num);

	/* 옵션 ======================================================================================= */
	//굿즈 번호로 옵션 리스트 가져오기
	ArrayList<OptionVO> selectOptionList(int gs_num);
	

}
