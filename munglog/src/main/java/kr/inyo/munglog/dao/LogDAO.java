package kr.inyo.munglog.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.inyo.munglog.vo.DogVO;
import kr.inyo.munglog.vo.LogVO;

public interface LogDAO {

	/* 강아지 ----------------------------------------------------------------------------------- */
	//회원 번호 주고 강아지들 정보 가져오기
	ArrayList<DogVO> selectDogs(int dg_mb_num);
	//강아지 추가
	void insertDog(@Param("dog")DogVO dog, @Param("dg_mb_num")int mb_num);
	
	/* 일지 ----------------------------------------------------------------------------------- */
	//일지 추가
	void insertLog(@Param("lg_mb_num")int mb_num, @Param("lg_image")String lg_image);
	//회원정보와 이미지로 로그 가져오기
	LogVO selectLogByImg(@Param("lg_mb_num")int mb_num, @Param("lg_image")String lg_image);
	//회원 번호 주고 로그리스트 가져오기
	ArrayList<LogVO> selectLogList(int lg_mb_num);
	
	/* 피사체 ----------------------------------------------------------------------------------- */
	//사진 속 피사체 추가
	void insertSubject(@Param("sb_lg_num")int lg_num, @Param("sb_dg_num")Integer sb_dg_num);
}
