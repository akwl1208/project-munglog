package kr.inyo.munglog.dao;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Param;

import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.ChallengeVO;
import kr.inyo.munglog.vo.DogVO;
import kr.inyo.munglog.vo.FriendVO;
import kr.inyo.munglog.vo.HeartVO;
import kr.inyo.munglog.vo.LogVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.ParticipateVO;
import kr.inyo.munglog.vo.SubjectVO;

public interface LogDAO {

	/* 강아지 ----------------------------------------------------------------------------------- */
	//회원 번호 주고 강아지들 정보 가져오기
	ArrayList<DogVO> selectDogList(int dg_mb_num);
	//강아지 정보로 강아지 가져오기
	DogVO selectDog(int dgNum);
	
	/* 일지 ----------------------------------------------------------------------------------- */
	//일지 추가
	void insertLog(@Param("lg_mb_num")int mb_num, @Param("lg_image")String lg_image);
	//회원정보와 이미지로 로그 가져오기
	LogVO selectLogByImg(@Param("lg_mb_num")int mb_num, @Param("lg_image")String lg_image);
	//criteria 주고 로그리스트 가져오기
	ArrayList<LogVO> selectLogList(Criteria cri);
	//회원의 일지 개수 가져오기
	int selectLogTotalCount(Criteria cri);
	//등록된 사진 년도들 가져오기
	ArrayList<String> selectRegYearList(int lg_mb_num);
	//일지 번호 주고 일지 가져오기
	LogVO selectLog(int lg_num);
	//일지 수정
	void updateLog(LogVO dbLog);
	//회원번호 주고 당일 일지리스트 가져오기
	ArrayList<LogVO> selectTodayLogListByMbNum(int mb_num);
	//일지 하트수 수정하기
	void updateLogHeart(int lg_num);
	//한달동안 일지가 등록된 날짜 개수 가져오기
	int selectCountLogForAMonth(@Param("lg_mb_num")int mb_num, @Param("today")String today);
	//지날 한달 동안 가장 좋아요를 많이 받은 10개의 일지 가져오기
	ArrayList<LogVO> selectBestLogList(Date today);
	
	/* 피사체 ----------------------------------------------------------------------------------- */
	//사진 속 피사체 추가
	void insertSubject(@Param("sb_lg_num")int lg_num, @Param("sb_dg_num")Integer sb_dg_num);
	//일지 속 피사체들 가져오기
	ArrayList<SubjectVO> selectSubjectList(int lg_num);
	//피사체 삭제
	void deleteSubject(int lg_num);
	
	/* 하트 ----------------------------------------------------------------------------------- */
	//하트 가져오기
	HeartVO selectHeart(HeartVO heart);
	//하트 추가하기
	void insertHeart(HeartVO heart);
	//하트 상태 수정하기
	void updateHeart(HeartVO dbHeart);
	//오늘 누른 하트수 가져오기
	int selectTodayHeart(int ht_mb_num);
	
	/* 친구 ----------------------------------------------------------------------------------- */
	//친구 정보 가져오기
	FriendVO selectFriend(FriendVO friend);
	//친구 추가하기
	void insertFriend(FriendVO friend);
	//친구 삭제하기
	void deleteFriend(FriendVO dbFriend);
	//친구 리스트 가져오기
	ArrayList<MemberVO> selectFriendList(FriendVO friend);
	
	/* 챌린지 ----------------------------------------------------------------------------------- */
	//년도와 달 주고 진행 중인 챌린지 가져오기
	ChallengeVO selectChallengeByDate(@Param("cl_year")String cl_year, @Param("cl_month")String cl_month);
	//진행한 챌린지 가져오기
	ArrayList<ChallengeVO> selectPastChallengeList(@Param("cl_year")String cl_year, @Param("cl_month")String cl_month);
	//챌린지 번호로 챌린지 가져오기
	ChallengeVO selectChallenge(int cl_num);
	
	/* 참여 ----------------------------------------------------------------------------------- */
	//챌린지 번호랑 회원 번호주고 챌린지 참여 정보 가져오기
	ParticipateVO selectParticipate(@Param("cl_num")int cl_num, @Param("mb_num")int mb_num);
	//챌린지 참여 추가하기
	void insertParticipate(@Param("cl_num")int cl_num, @Param("lg_num")int lg_num);
	//일지 번호 주고 챌린지 참여 정보 가져오기
	ParticipateVO selectParticipateByLgNum(int lg_num);
	
	
	
}
