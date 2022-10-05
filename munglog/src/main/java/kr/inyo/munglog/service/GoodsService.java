package kr.inyo.munglog.service;

import java.util.ArrayList;

import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.BasketVO;
import kr.inyo.munglog.vo.CategoryVO;
import kr.inyo.munglog.vo.GoodsVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OptionVO;

public interface GoodsService {
	//굿즈리스트 가져오기
	ArrayList<GoodsVO> getGoodsList(Criteria cri);
	//굿즈 총 개수 가져오기
	int getGoodsTotalCount(Criteria cri);
	//카테고리 리스트 가져오기
	ArrayList<CategoryVO> getCategoryList();
	//굿즈 번호로 굿즈 가져오기
	GoodsVO getGoods(int gs_num);
	//옵션 리스트 가져오기
	ArrayList<OptionVO> getOtionList(int gs_num);
	//장바구니에 담기
	int putBasket(BasketVO basket, MemberVO user);
	//장바구니 리스트 가져오기
	ArrayList<BasketVO> getBasketList(MemberVO user);
	//장바구니 삭제
	boolean deleteBasket(BasketVO basket, MemberVO user);
}