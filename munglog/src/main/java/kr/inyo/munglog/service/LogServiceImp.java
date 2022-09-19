package kr.inyo.munglog.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.inyo.munglog.dao.LogDAO;
import kr.inyo.munglog.vo.DogVO;
import kr.inyo.munglog.vo.MemberVO;

@Service
public class LogServiceImp implements LogService {

	@Autowired
	LogDAO logDao;

/* 함수********************************************************************************************************************* */
	//-----------------------------------------------------------------------------

/* overide 메소드 *********************************************************************************************************** */
	/*  getDogs : 회원의 강아지 정보 가져옴 ------------------------------*/
	@Override
	public ArrayList<DogVO> getDogs(MemberVO user) {
		//값이 없으면
		if(user == null)
			return null;
		if(user.getMb_num() < 1)
			return null;
		//강아지 정보 가져오기
		ArrayList<DogVO> dbDogs = logDao.selectDogs(user.getMb_num());
		if(dbDogs.isEmpty())
			return null;
		return dbDogs;
	}
	

		
	
}
