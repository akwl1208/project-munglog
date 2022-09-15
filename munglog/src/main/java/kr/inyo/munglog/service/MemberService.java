package kr.inyo.munglog.service;

import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.VerificationVO;

public interface MemberService {
	//회원인지 아닌지
	boolean isMember(MemberVO member);
	//메일 전송
	boolean sendEmail(MemberVO member);
	//본인 인증 삭제
	boolean deleteVerification(MemberVO member);
	//본인인증코드 확인
	boolean checkCode(VerificationVO veri);
	//본인인증 확인 횟수 증가
	void countFailure(VerificationVO veri);
	//실패횟수를 가져옴
	int getFailureCount(VerificationVO veri);
}
