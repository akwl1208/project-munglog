package kr.inyo.munglog.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.inyo.munglog.dao.MemberDAO;
import kr.inyo.munglog.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService {

	@Autowired
	MemberDAO memberDao;

/* ************************************************************************** */
	/* isMember : 이메일을 주고 DB에 회원 정보가 있는지 확인 ------------------------------*/
	@Override
	public boolean isMember(MemberVO member) {
		//member가 null이면 ---------------------------------------- 
		if(member == null)
			return false;
		//email이 null이거나 email 길이가 0이면 ----------------------------------
		if(member.getMb_email() == null || member.getMb_email().length() == 0)
			return false;
		//이메일 정보로 회원 정보 가져옴 --------------------------------
		MemberVO dbMember = memberDao.selectMember(member.getMb_email());
		//DB에 있으면 false ------------------------------------
		if(dbMember != null)
			return false;
		//DB에 없으면 true ---------------------------------------
		return true;
	}
}
