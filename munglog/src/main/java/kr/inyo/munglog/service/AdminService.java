package kr.inyo.munglog.service;

import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.vo.ChallengeVO;
import kr.inyo.munglog.vo.MemberVO;

public interface AdminService {
	//챌린지 등록
	boolean registerChallenge(MultipartFile file, ChallengeVO challenge, MemberVO user);
	
}
