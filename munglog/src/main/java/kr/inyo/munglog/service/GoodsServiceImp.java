package kr.inyo.munglog.service;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.inyo.munglog.dao.GoodsDAO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.BasketVO;
import kr.inyo.munglog.vo.CategoryVO;
import kr.inyo.munglog.vo.GoodsVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OptionVO;

@Service
public class GoodsServiceImp implements GoodsService {
	
	@Autowired
	GoodsDAO goodsDao;
	
/* override ************************************************************************************************************ */
	// getGoodsList : 굿즈 리스트 가져오기 =============================================================================
	@Override
	public ArrayList<GoodsVO> getGoodsList(Criteria cri) {
		//값이 없으면
		if(cri == null)
			return null;
		//회원번호 주고 로그 가져오기
		return goodsDao.selectGoodsList(cri);
	}
	
	//getGoodsTotalCount : 굿즈 총 개수 가져오기 =============================================================================
	@Override
	public int getGoodsTotalCount(Criteria cri) {
		//값이 없으면
		if(cri == null)
			return 0;
		return goodsDao.selectGoodsTotalCount(cri);
	}
	
	//getCategoryList : 카테고리 리스트 가져오기 =============================================================================
	@Override
	public ArrayList<CategoryVO> getCategoryList() {
		return goodsDao.selectCategoryList();
	}

	//getGoods : 굿즈 가져오기 ============================================================================================
	@Override
	public GoodsVO getGoods(int gs_num) {
		if(gs_num < 1)
			return null;
		return goodsDao.selectGoods(gs_num);
	}

	//getOtionList : 옵션 리스트 가져오기 ====================================================================================
	@Override
	public ArrayList<OptionVO> getOtionList(int gs_num) {
		if(gs_num < 1)
			return null;
		return goodsDao.selectOptionList(gs_num);
	}

	//putBasket : 장바구니에 담기 ====================================================================================
	@Override
	public int putBasket(BasketVO basket, MemberVO user) {
		//값이 없으면
		if(basket == null || user == null)
			return -1;
		if(user.getMb_num() < 1)
			return -1;
		//회원 번호가 다르면
		if(basket.getBs_mb_num() != user.getMb_num())
			return -1;
		//옵션이 없으면
		ArrayList<OptionVO> optionList = basket.getOptionList();
		if(optionList.isEmpty())
			return -1;
		//장바구니에 담기
		for(OptionVO option : optionList) {
			//값이 없으면 통과
			if(option.getOt_num() < 1 || option.getOt_amount() < 1)
				continue;
			//장바구니에 담긴 상품인지 확인
			BasketVO dbBasket = goodsDao.selectBasketByOtNum(option.getOt_num(), user.getMb_num());
			if(dbBasket != null)
				return 0;
			//30일 보관
			//만료일을 만료시간로 환산(30일)
			long expireTime = 60 * 60 * 24 * 30;
			//basket 설정
			Date expirDate = new Date(System.currentTimeMillis() + expireTime*1000);
			basket.setBs_expir_date(expirDate);
			basket.setBs_ot_num(option.getOt_num());
			basket.setBs_amount(option.getOt_amount());
			//db에 추가
			goodsDao.insertBasket(basket);			
		}
  	return 1;
	}//
}
