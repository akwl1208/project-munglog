package kr.inyo.munglog.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.inyo.munglog.vo.DogVO;

public interface LogDAO {

	/* 강아지 ----------------------------------------------------------------------------------- */
	//회원 번호 주고 강아지들 정보 가져오기
	ArrayList<DogVO> selectDogs(int mb_num);
	
}
