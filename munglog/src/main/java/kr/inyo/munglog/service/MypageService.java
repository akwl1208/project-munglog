package kr.inyo.munglog.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.dto.MyOrderDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.DogListVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OrderVO;
import kr.inyo.munglog.vo.PointVO;
import kr.inyo.munglog.vo.ReviewVO;

public interface MypageService {
	//내 주문 내역 리스트 가져오기
	ArrayList<OrderVO> getMyOrderList(Criteria cri);
	//내 주문 상세 내역 리스트 가져오기
	ArrayList<MyOrderDTO> getMyOrderDetailList(Criteria cri);
	//내 리뷰 가져오기
	ReviewVO getMyReview(ReviewVO review, MemberVO user);
	//리뷰 등록하기
	boolean registerReview(MemberVO user, ReviewVO review, MultipartFile file);
	//리뷰 수정하기
	boolean modifyReview(MemberVO user, ReviewVO review, MultipartFile file, boolean delModiImage);
	//회원정보 수정
	boolean modifyAccount(MemberVO member, MemberVO user);
	//닉네임 중복 검사
	int checkNickname(MemberVO member, MemberVO user);
	//프로필 수정
	boolean modifyProfile(MultipartFile file, boolean delProfile, MemberVO member, MemberVO user);
	//내 포인트 내역 가져오기
	ArrayList<PointVO> getMyPointList(Criteria cri, MemberVO user);
	//내 포인트 전체 개수 가져오기
	int getPointTotalCount(Criteria cri);
	//강아지 정보 수정
	boolean modifyDog(MemberVO user, DogListVO dlist, int[] delNums);
}
