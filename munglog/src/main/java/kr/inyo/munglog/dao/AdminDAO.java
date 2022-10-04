package kr.inyo.munglog.dao;

import java.util.ArrayList;

import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.CategoryVO;
import kr.inyo.munglog.vo.ChallengeVO;
import kr.inyo.munglog.vo.GoodsVO;
import kr.inyo.munglog.vo.OptionVO;

public interface AdminDAO {
	/* 챌린지 --------------------------------------------------------------------------------------*/
	//챌린지 등록
	void insertChallenge(ChallengeVO challenge);
	//년도와 월로 챌린지 가져오기
	ChallengeVO selectChallengeBydate(ChallengeVO challenge);
	//챌린지 리스트 가져오기
	ArrayList<ChallengeVO> selectChallengeList(Criteria cri);
	//등록된 챌린지 총 개수 가져오기
	int selectChallengeTotalCount();
	//챌린지 번호로 챌린지 가져오기
	ChallengeVO selectChallenge(int cl_num);
	//챌린지 수정하기
	void updateChallenge(ChallengeVO Challenge);
	//챌린지 삭제하기
	boolean deleteChallenge(ChallengeVO Challenge);
	
	/* 카테고리 --------------------------------------------------------------------------------------*/
	//카테고리 가져오기
	ArrayList<CategoryVO> selectCategoryList();
	
	/* 굿즈 --------------------------------------------------------------------------------------*/
	//카테고리와 상품명으로 굿즈 정보 가져오기
	GoodsVO selectGoodsByName(GoodsVO goods);
	//굿즈 등록
	void insertGoods(GoodsVO goods);
	//굿즈 리스트 가져오기
	ArrayList<CategoryVO> selectGoodsList();
	
	/* 옵션 --------------------------------------------------------------------------------------*/
	//옵션 등록
	void insertOption(OptionVO option);
	//옵션 리스트 가져오기
	ArrayList<OptionVO> selectOptionList(OptionVO option);
}
