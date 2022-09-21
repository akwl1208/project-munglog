package kr.inyo.munglog.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.vo.DogListVO;
import kr.inyo.munglog.vo.DogVO;
import kr.inyo.munglog.vo.LogVO;
import kr.inyo.munglog.vo.MemberVO;

public interface LogService {
	//강아지 정보 가져오기
	ArrayList<DogVO> getDogs(MemberVO user);
	//강아지 정보 추가
	int insertDog(MemberVO user, DogListVO dlist);
	//일지에 사진 등록
	int uploadLog(ArrayList<Integer> dg_nums, MultipartFile file, MemberVO user);
	//회원의 로그들 가져오기
	ArrayList<LogVO> getLogList(LogVO log);

}
