package kr.inyo.munglog.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.BasketVO;
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
	
	/* 장바구니 ======================================================================================= */
	//회원번호와 옵션번호로 장바구니 정보 가져오기
	BasketVO selectBasketByOtNum(@Param("bs_ot_num")int bs_ot_num, @Param("bs_mb_num")int mb_num);
	//장바구니 추가
	void insertBasket(BasketVO basket);
	

}
