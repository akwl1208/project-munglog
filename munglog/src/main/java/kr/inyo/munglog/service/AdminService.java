package kr.inyo.munglog.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.CategoryVO;
import kr.inyo.munglog.vo.ChallengeVO;
import kr.inyo.munglog.vo.GoodsVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OptionListVO;

public interface AdminService {
	//챌린지 등록
	boolean registerChallenge(MultipartFile file, ChallengeVO challenge, MemberVO user);
	//챌린지 리스트 가져오기
	ArrayList<ChallengeVO> getChallengeList(Criteria cri);
	//등록된 챌린지 총 개수 가져오기
	int getChallengeTotalCount();
	//챌린지 수정
	boolean modifyChallenge(MultipartFile file, ChallengeVO challenge, MemberVO user, String oriYear, String oriMonth);
	//챌린지 삭제
	int deleteChallenge(ChallengeVO challenge, MemberVO user);
	//카테고리 리스트 가져오기
	ArrayList<CategoryVO> getCategoryList();
	//굿즈 등록
	boolean registerGoods(GoodsVO goods, OptionListVO optionList, MultipartFile file, MemberVO user);
	//굿즈 상세 설명 이미지 업로드
	String uploadGoodsImage(MultipartFile file);

}
