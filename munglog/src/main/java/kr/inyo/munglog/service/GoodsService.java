package kr.inyo.munglog.service;

import java.util.ArrayList;

import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.GoodsVO;

public interface GoodsService {
	//굿즈리스트 가져오기
	ArrayList<GoodsVO> getGoodsList(Criteria cri);
	//굿즈 총 개수 가져오기
	int getGoodsTotalCount(Criteria cri);

}
