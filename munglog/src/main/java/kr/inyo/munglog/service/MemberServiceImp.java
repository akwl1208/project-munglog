package kr.inyo.munglog.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.inyo.munglog.dao.MemberDAO;

@Service
public class MemberServiceImp implements MemberService {

	@Autowired
	MemberDAO memberDao;

	@Override
	public String getEmail() {
		return memberDao.selectEmail();
	}
}
