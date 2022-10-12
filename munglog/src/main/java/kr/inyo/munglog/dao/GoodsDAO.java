package kr.inyo.munglog.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.inyo.munglog.dto.BasketDTO;
import kr.inyo.munglog.dto.OrderDTO;
import kr.inyo.munglog.dto.PaymentDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.AddressVO;
import kr.inyo.munglog.vo.BasketVO;
import kr.inyo.munglog.vo.CategoryVO;
import kr.inyo.munglog.vo.GoodsVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OptionVO;
import kr.inyo.munglog.vo.OrderVO;

public interface GoodsDAO {
	/* 카테고리 ======================================================================================= */
	ArrayList<CategoryVO> selectCategoryList();
	
	/* 굿즈 ======================================================================================= */
	//cri로 굿즈 리스트 가져오기
	ArrayList<GoodsVO> selectGoodsListByCri(Criteria cri);
	//굿즈 총 개수 가져오기
	int selectGoodsTotalCount(Criteria cri);
	//굿즈 번호로 굿즈 정보 가져오기
	GoodsVO selectGoods(int gs_num);
	//굿즈 리스트 가져오기
	ArrayList<GoodsVO> selectGoodsList();

	/* 옵션 ======================================================================================= */
	//굿즈 번호로 옵션 리스트 가져오기
	ArrayList<OptionVO> selectOptionList(int gs_num);
	
	/* 장바구니 ======================================================================================= */
	//회원번호와 옵션번호로 장바구니 정보 가져오기
	BasketVO selectBasketByOtNum(@Param("bs_ot_num")int bs_ot_num, @Param("bs_mb_num")int mb_num);
	//장바구니 추가
	void insertBasket(BasketVO basket);
	//회원 번호로 장바구니 리스트 가져오기
	ArrayList<BasketDTO> selectBasketList(int mb_num);
	//장바구니번호로 장바구니 가져오기
	BasketVO selectBasket(BasketVO basket);
	//장바구니 삭제
	boolean deleteBasket(BasketVO basket);
	//보관기간이 지난 장바구니 삭제
	void deleteExpiredBasket(int mb_num);
	//주문한 상품 장바구니 삭제
	void deleteBasketByOtNum(@Param("mb_num")int mbNum, @Param("ot_num")int otNum);
	//장바구니 수정
	boolean updateBasket(BasketVO dbBasket);
	
	/* 주문 ======================================================================================= */
	//옵션번호로 주문 내역 가져오기
	OrderDTO selectOrderByOtNum(int otNum);
	//주문 추가
	void insertOrder(@Param("payment")PaymentDTO payment, @Param("ad_num")int ad_num);
	//주문 가져오기
	OrderVO selectOrderByPayment(@Param("or_mb_num")int mbNum, @Param("or_payment")String imp_uid);
	//주문 상세 추가
	boolean insertOrderDetail(@Param("od_or_code")String or_code, @Param("order")OrderDTO order, @Param("od_state")String od_state);
	
	/* 배송지 ======================================================================================= */
	//배송지 추가(기본만)
	void insertAddress(@Param("member")MemberVO dbMember, @Param("ad_name")String ad_name, @Param("ad_main")String ad_main);
	//회원 번호로 배송지 가져오기
	AddressVO selectMainAddress(int mb_num);
	//배송지 추가(모든 정보)
	void insertAddressAll(AddressVO address);
	//모든 정보를 비교해서 배송지 가져오기
	AddressVO selectAddressByAll(AddressVO address);
	//배송지 번호로 배송지 가져오기
	AddressVO selectAddress(@Param("ad_num")int adNum, @Param("ad_mb_num")int mbNum);
	//배송지 수정
	void updateAddress(AddressVO dbAddress);

}
