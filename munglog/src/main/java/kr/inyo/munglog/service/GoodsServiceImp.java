package kr.inyo.munglog.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.inyo.munglog.dao.GoodsDAO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.GoodsVO;

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

}
