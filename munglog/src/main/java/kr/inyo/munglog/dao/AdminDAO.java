package kr.inyo.munglog.dao;

import java.util.ArrayList;

import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.ChallengeVO;

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
}
