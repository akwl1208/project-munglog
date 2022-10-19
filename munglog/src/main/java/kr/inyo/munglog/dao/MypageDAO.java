package kr.inyo.munglog.dao;

import java.util.ArrayList;

import kr.inyo.munglog.dto.MyOrderDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.DogVO;
import kr.inyo.munglog.vo.OrderVO;
import kr.inyo.munglog.vo.PointVO;
import kr.inyo.munglog.vo.ReviewVO;

public interface MypageDAO {
	/* 주문 =========================================================================*/
	//cri로 내 주문 내역 리스트 가져오기
	ArrayList<OrderVO> selectMyOrderList(Criteria cri);
	//cri로 내 주문 상세 내역 리스트 가져오기
	ArrayList<MyOrderDTO> selectMyOrderDetailList(Criteria cri);
	//주문상세 번호로 내 주문 내역 가져오기
	MyOrderDTO selectMyOrderDetail(int od_num);
	
	/* 리뷰 =========================================================================*/
	//내 리뷰 가져오기
	ReviewVO selectMyReview(int rv_od_num);
	//리뷰 등록하기
	boolean insertReview(ReviewVO review);
	//리뷰 수정하기
	boolean updateReview(ReviewVO dbReview);
	
	/* 포인트 =========================================================================*/
	//cri로 내 포인트 리스트 가져오기
	ArrayList<PointVO> selectMyPointList(Criteria cri);
	//cri로 포인트 전체 개수 가져오기
	int selectPointtotalCount(Criteria cri);
	
	/* 강아지 =========================================================================*/
	//강아지 번호로 강아지 정보 삭제
	void deleteDog(int dg_num);
	//강아지 정보 수정
	void updateDog(DogVO dbDog);

}
