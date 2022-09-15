package kr.inyo.munglog.dao;

import org.apache.ibatis.annotations.Param;

import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.VerificationVO;

public interface MemberDAO {

	//주어진 이메일을 가진 회원정보 가져오기
	MemberVO selectMember(String mb_email);
	//본인인증번호 DB에 저장
	boolean insertVeriCode(@Param("vr_email")String vr_email, @Param("vr_code")String vr_code);
	//회원 이메일을 주고 본인인증 삭제
	boolean deleteVerification(String vr_email);
	//회원 이메일을 주고 본인인증 정보 가져오기
	VerificationVO selectVerification(String vr_email);
	//회원 이메일을 주고 본인인증 정보 수정
	void updateVerifiCation(VerificationVO veri);
	
}
