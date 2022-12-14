package kr.inyo.munglog.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.ChallengeVO;
import kr.inyo.munglog.vo.DogVO;
import kr.inyo.munglog.vo.FriendVO;
import kr.inyo.munglog.vo.HeartVO;
import kr.inyo.munglog.vo.LogVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.SubjectVO;

public interface LogService {
	//강아지 정보 가져오기
	ArrayList<DogVO> getDogs(MemberVO user);
	//일지에 사진 등록
	int uploadLog(ArrayList<Integer> dg_nums, MultipartFile file, MemberVO user);
	//회원의 로그들 가져오기
	ArrayList<LogVO> getLogList(Criteria cri);
	//회원의 일지의 사진 개수 가져오기
	int getLogTotalCount(Criteria cri);
	//사진이 등록된 년도들 가져오기
	ArrayList<String> getRegYearList(MemberVO user);
	//사진의 피사체들 가져오기
	ArrayList<SubjectVO> getSubjectList(LogVO log, MemberVO user);
	//일지 수정
	int modifyLog(ArrayList<Integer> m_dg_nums, ArrayList<Integer> d_dg_nums, MultipartFile file, LogVO log, MemberVO user);
	//슬라이드 인덱스 찾기
	int findIndex(ArrayList<LogVO> logList, int lg_num);
	//일지 삭제
	int deleteLog(LogVO log, MemberVO user);
	//일지 조회수 증가
	boolean countViews(LogVO log);
	//일지 하트 
	int getHeartState(HeartVO heart, MemberVO user);
	//하트 정보 가져오기
	HeartVO getHeart(HeartVO heart, MemberVO user);
	//일지 가져오기
	LogVO getLog(LogVO log);
	//친구 추가 삭제
	int makeFriend(FriendVO friend, MemberVO user);
	//친구 정보 가져오기
	FriendVO getFriend(FriendVO friend, MemberVO user);
	//친구들 리스트 가져오기(프로필)
	ArrayList<MemberVO> getFriendList(FriendVO friend);
	//챌린지 가져오기
	ChallengeVO getChallenge(String year, String month);
	//모든 챌린지 가져오기
	ArrayList<ChallengeVO> getPastChallengeList();
	//챌린지 참여하기
	int participageChallenge(MultipartFile file, int cl_num, MemberVO user);
	ArrayList<LogVO> getBestLogList();

}
