package kr.inyo.munglog.dao;

import kr.inyo.munglog.vo.MemberVO;

public interface MemberDAO {

	MemberVO selectMember(String mb_email);
}
