package kr.inyo.munglog.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.inyo.munglog.dao.GoodsDAO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.CategoryVO;
import kr.inyo.munglog.vo.GoodsVO;
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

	//getOtionList : 옵션 리스트 가져오기 =============================================================================================
	@Override
	public ArrayList<OptionVO> getOtionList(int gs_num) {
		if(gs_num < 1)
			return null;
		return goodsDao.selectOptionList(gs_num);
	}

}
