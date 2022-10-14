package kr.inyo.munglog.service;

import java.util.ArrayList;

import kr.inyo.munglog.dto.MyOrderDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OrderVO;

public interface MypageService {
	//내 주문 내역 리스트 가져오기
	ArrayList<OrderVO> getMyOrderList(Criteria cri);
	//내 주문 상세 내역 리스트 가져오기
	ArrayList<MyOrderDTO> getMyOrderDetailList(Criteria cri);

}
