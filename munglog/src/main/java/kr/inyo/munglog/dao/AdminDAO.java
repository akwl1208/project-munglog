package kr.inyo.munglog.dao;

import kr.inyo.munglog.vo.ChallengeVO;

public interface AdminDAO {
	/* 챌린지 --------------------------------------------------------------------------------------*/
	//챌린지 등록
	void insertChallenge(ChallengeVO challenge);
	//년도와 월로 챌린지 가져오기
	ChallengeVO selectChallengeBydate(ChallengeVO challenge);

}
