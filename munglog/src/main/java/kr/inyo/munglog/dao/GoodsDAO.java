package kr.inyo.munglog.dao;

import java.util.ArrayList;

import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.GoodsVO;

public interface GoodsDAO {
	/* 굿즈 ======================================================================================= */
	//굿즈 리스트 가져오기
	ArrayList<GoodsVO> selectGoodsList(Criteria cri);
	//굿즈 총 개수 가져오기
	int selectGoodsTotalCount(Criteria cri);

}
