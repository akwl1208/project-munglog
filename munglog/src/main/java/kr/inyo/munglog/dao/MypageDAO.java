package kr.inyo.munglog.dao;

import java.util.ArrayList;

import kr.inyo.munglog.dto.MyOrderDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.OrderVO;

public interface MypageDAO {
	/* 주문 =========================================================================*/
	//cri로 내 주문 내역 리스트 가져오기
	ArrayList<OrderVO> selectMyOrderList(Criteria cri);
	//cri로 내 주문 상세 내역 리스트 가져오기
	ArrayList<MyOrderDTO> selectMyOrderDetailList(Criteria cri);

}
