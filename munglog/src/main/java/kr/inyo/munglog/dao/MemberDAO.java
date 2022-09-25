package kr.inyo.munglog.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.VerificationVO;

public interface MemberDAO {

	/* 본인인증 ----------------------------------------------------------------------------------- */
	//본인인증번호 DB에 저장
	boolean insertVeriCode(@Param("vr_email")String vr_email, @Param("vr_code")String vr_code);
	//회원 이메일을 주고 본인인증 삭제
	boolean deleteVerification(String vr_email);
	//회원 이메일을 주고 본인인증 정보 가져오기
	VerificationVO selectVerification(String vr_email);
	//회원 이메일을 주고 본인인증 정보 수정
	void updateVerifiCation(VerificationVO veri);
	
	/* 회원 ----------------------------------------------------------------------------------- */
	//주어진 이메일을 가진 회원정보 가져오기
	MemberVO selectMember(String mb_email);
	//이름과 핸드폰 번호 주고 이름과 핸드폰 번호가 모두 동일한 사람이 있는지 찾기
	MemberVO selectSameMember(@Param("mb_name")String mb_name, @Param("mb_phone")String mb_phone);
	//회원정보 DB에저장
	void insertMember(MemberVO member);
	//이메일 정보주고 프로필 수정
	void updateProfile(MemberVO member);
	//세션 정보 수정
	void updateSession(MemberVO user);
	//세션 아이디 주고 이메일 정보 가져오기
	String selectMemberEmail(String mb_session_id);
	//회원정보 수정
	void updateMember(MemberVO member);
	//회원 정보 리스트 가져오기
	ArrayList<MemberVO> getMemberList();
	//회원 번호로 회원 정보 가져오기
	MemberVO selectMemberByMbnum(int mb_num);
	
	/* 포인트 ----------------------------------------------------------------------------------- */
	//포인트 적립
	void insertPoint(@Param("pi_mb_num")int mb_num, @Param("pi_process")String pi_process, 
			@Param("pi_history")String pi_history, @Param("pi_amount")int pi_amount);

	
	

	
}
