package kr.inyo.munglog.service;

import java.util.ArrayList;

import kr.inyo.munglog.vo.DogListVO;
import kr.inyo.munglog.vo.DogVO;
import kr.inyo.munglog.vo.MemberVO;

public interface LogService {
	//강아지 정보 가져오기
	ArrayList<DogVO> getDogs(MemberVO user);
	//강아지 정보 추가
	int insertDog(MemberVO user, DogListVO dlist);


}
