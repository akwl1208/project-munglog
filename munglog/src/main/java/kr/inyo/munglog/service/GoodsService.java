package kr.inyo.munglog.service;

import java.io.IOException;
import java.util.ArrayList;

import com.siot.IamportRestClient.exception.IamportResponseException;

import kr.inyo.munglog.dto.BasketDTO;
import kr.inyo.munglog.dto.OrderDTO;
import kr.inyo.munglog.dto.OrderListDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.AddressVO;
import kr.inyo.munglog.vo.BasketVO;
import kr.inyo.munglog.vo.CategoryVO;
import kr.inyo.munglog.vo.GoodsVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OptionVO;

public interface GoodsService {
	//굿즈리스트 가져오기
	ArrayList<GoodsVO> getGoodsList(Criteria cri);
	//굿즈 총 개수 가져오기
	int getGoodsTotalCount(Criteria cri);
	//카테고리 리스트 가져오기
	ArrayList<CategoryVO> getCategoryList();
	//굿즈 번호로 굿즈 가져오기
	GoodsVO getGoods(int gs_num);
	//옵션 리스트 가져오기
	ArrayList<OptionVO> getOtionList(int gs_num);
	//장바구니에 담기
	int putBasket(BasketVO basket, MemberVO user);
	//장바구니 리스트 가져오기
	ArrayList<BasketDTO> getBasketList(MemberVO user);
	//장바구니 삭제
	boolean deleteBasket(BasketVO basket, MemberVO user);
	//주문할 상품들 가져오기
	ArrayList<OrderDTO> getOrderList(int mb_num, OrderListDTO orderList, MemberVO user);
	//보관기간이 지난 장바구니 삭제
	void deleteExpiredBasket(MemberVO user);
	//기본배송지 정보 가져오기
	AddressVO getMainAddress(MemberVO user);
	//결제 검증하기
	boolean verifyPayment(String rsp) throws IamportResponseException, IOException;
}