package kr.inyo.munglog.service;

import kr.inyo.munglog.vo.MemberVO;

public interface MemberService {
	//회원인지 아닌지
	boolean isMember(MemberVO member);
	//메일 전송
	boolean sendEmail(MemberVO member);
	//본인 인증 삭제
	boolean deleteVerification(MemberVO member);
}
