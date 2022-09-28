package kr.inyo.munglog.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.ChallengeVO;
import kr.inyo.munglog.vo.MemberVO;

public interface AdminService {
	//챌린지 등록
	boolean registerChallenge(MultipartFile file, ChallengeVO challenge, MemberVO user);
	//챌린지 리스트 가져오기
	ArrayList<ChallengeVO> getChallengeList(Criteria cri);
	//등록된 챌린지 총 개수 가져오기
	int getChallengeTotalCount();
	//챌린지 수정
	boolean modifyChallenge(MultipartFile file, ChallengeVO challenge, MemberVO user, String oriYear, String oriMonth);

	
}
