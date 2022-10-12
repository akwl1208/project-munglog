package kr.inyo.munglog.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.Payment;

import kr.inyo.munglog.dao.GoodsDAO;
import kr.inyo.munglog.dao.MemberDAO;
import kr.inyo.munglog.dto.BasketDTO;
import kr.inyo.munglog.dto.OrderDTO;
import kr.inyo.munglog.dto.OrderListDTO;
import kr.inyo.munglog.dto.PaymentDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.AddressVO;
import kr.inyo.munglog.vo.BasketVO;
import kr.inyo.munglog.vo.CategoryVO;
import kr.inyo.munglog.vo.GoodsVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OptionVO;
import kr.inyo.munglog.vo.OrderVO;

@Service
public class GoodsServiceImp implements GoodsService {
	
	@Autowired
	GoodsDAO goodsDao;
	@Autowired
	MemberDAO memberDao;
	
	private IamportClient api;
	
  public GoodsServiceImp(){
    this.api = new IamportClient("", "");
  }
  
/* 메소드 *************************************************************************************************************** */
	// strExtraction : 문자 추출 =========================================================================================
	public String strExtraction(String rsp, String findStartStr, String findEndStr) {
		int startIndex = rsp.indexOf(findStartStr) + findStartStr.length();
		String str = "";
		if(findEndStr != "") {
			int endIndex = rsp.indexOf(findEndStr);
			str = rsp.substring(startIndex, endIndex);				
		} else
			str = rsp.substring(startIndex);
		return str;
	}
	
	//cancelPayment : 결제 취소하기 =========================================================================================
	public void cancelPayment(String imp_uid, BigDecimal amount) throws IamportResponseException, IOException {
		CancelData cancelData = new CancelData(imp_uid, true, amount);
		api.cancelPaymentByImpUid(cancelData);
	}
	
/* override ************************************************************************************************************ */
	// getGoodsList : 굿즈 리스트 가져오기 =============================================================================
	@Override
	public ArrayList<GoodsVO> getGoodsList(Criteria cri) {
		//값이 없으면
		if(cri == null)
			return null;
		//회원번호 주고 로그 가져오기
		return goodsDao.selectGoodsListByCri(cri);
	}
	
	//getGoodsTotalCount : 굿즈 총 개수 가져오기 =============================================================================
	@Override
	public int getGoodsTotalCount(Criteria cri) {
		//값이 없으면
		if(cri == null)
			return 0;
		return goodsDao.selectGoodsTotalCount(cri);
	}
	
	//getCategoryList : 카테고리 리스트 가져오기 =============================================================================
	@Override
	public ArrayList<CategoryVO> getCategoryList() {
		return goodsDao.selectCategoryList();
	}

	//getGoods : 굿즈 가져오기 ============================================================================================
	@Override
	public GoodsVO getGoods(int gs_num) {
		if(gs_num < 1)
			return null;
		return goodsDao.selectGoods(gs_num);
	}

	//getOtionList : 옵션 리스트 가져오기 ====================================================================================
	@Override
	public ArrayList<OptionVO> getOtionList(int gs_num) {
		if(gs_num < 1)
			return null;
		return goodsDao.selectOptionList(gs_num);
	}

	//putBasket : 장바구니에 담기 ====================================================================================
	@Override
	public int putBasket(BasketVO basket, MemberVO user) {
		//값이 없으면
		if(basket == null || user == null)
			return -1;
		if(user.getMb_num() < 1)
			return -1;
		//회원 번호가 다르면
		if(basket.getBs_mb_num() != user.getMb_num())
			return -1;
		//옵션이 없으면
		ArrayList<OptionVO> optionList = basket.getOptionList();
		if(optionList.isEmpty())
			return -1;
		//장바구니에 담기
		for(OptionVO option : optionList) {
			//값이 없으면 통과
			if(option.getOt_num() < 1 || option.getOt_amount() < 1)
				continue;
			//장바구니에 담긴 상품인지 확인
			BasketVO dbBasket = goodsDao.selectBasketByOtNum(option.getOt_num(), user.getMb_num());
			if(dbBasket != null)
				return 0;
			//30일 보관
			//만료일을 만료시간로 환산(30일)
			long expireTime = 60 * 60 * 24 * 30;
			//basket 설정
			Date expirDate = new Date(System.currentTimeMillis() + expireTime*1000);
			basket.setBs_expir_date(expirDate);
			basket.setBs_ot_num(option.getOt_num());
			basket.setBs_amount(option.getOt_amount());
			//db에 추가
			goodsDao.insertBasket(basket);			
		}
  	return 1;
	}//
	
	//getBasketList : 장바구니 리스트 가져오기 =============================================================================
	@Override
	public ArrayList<BasketDTO> getBasketList(MemberVO user) {
		//값이 없으면
		if(user == null || user.getMb_num() < 1)
			return null;
		return goodsDao.selectBasketList(user.getMb_num());
	}

	//deleteBasket : 장바구니 삭제 =============================================================================
	@Override
	public boolean deleteBasket(BasketVO basket, MemberVO user) {
		//값이 없으면
		if(basket == null || user == null)
			return false;
		if(basket.getBs_mb_num() < 1 || user.getMb_num() < 1)
			return false;
		//회원 번호가 다르면
		if(basket.getBs_mb_num() != user.getMb_num())
			return false;
		//장바구니에 담긴 상품인지 확인
		BasketVO dbBasket = goodsDao.selectBasket(basket);
		if(dbBasket == null)
			return false;
		return goodsDao.deleteBasket(dbBasket);
	}

	//getOrderList : 주문할 상품들 가져오기 =========================================================================
	@Override
	public ArrayList<OrderDTO> getOrderList(int mb_num, OrderListDTO orderList, MemberVO user) {
		//값 없으면
		if(user == null || user.getMb_num() < 1 || mb_num < 1)
			return null;
		if(orderList == null)
			return null;
		//해당 회원이 아니면
		if(user.getMb_num() != mb_num)
			return null;
		//값 가져오기
		ArrayList<OrderDTO> oList = new ArrayList<OrderDTO>();
		for(OrderDTO tmpOrder : orderList.getOrderList()) {
			//옵션번호가 0이면 넘기기
			if(tmpOrder.getOtNum() == 0 || tmpOrder.getOrAmount() == 0)
				continue;
			//정보 가져오기
			OrderDTO order = goodsDao.selectOrderByOtNum(tmpOrder.getOtNum());
			//리스트에 값 넣기
			order.setOtNum(tmpOrder.getOtNum());
			order.setOrAmount(tmpOrder.getOrAmount());
			oList.add(order);
		}
		return oList;
	}
	
	//deleteExpiredBasket : 보관기간 지난 장바구니 삭제 =================================================================
	@Override
	public void deleteExpiredBasket(MemberVO user) {
		//값이 없으면
		if(user == null || user.getMb_num() < 1)
			return;
		//장바구니에 담긴게 없으면
		ArrayList<BasketDTO> dbBasketList = goodsDao.selectBasketList(user.getMb_num());
		if(dbBasketList == null)
			return;
		//보관기간이 지난 장바구니 삭제
		goodsDao.deleteExpiredBasket(user.getMb_num());
	}

	//getMainAddress : 기본배송지 가져오기 ====================================================================================
	@Override
	public AddressVO getMainAddress(MemberVO user) {
		//값 없으면
		if(user == null || user.getMb_num() < 1)
			return null;
		return goodsDao.selectMainAddress(user.getMb_num());
	}

	//verifyPayment : 결제 검증하기 ====================================================================================	
	@Override
	public boolean verifyPayment(String rsp) throws IamportResponseException, IOException {
		//값이 없으면
		if(rsp == "" || api == null)
			return false;
		//값 추출하기
		String imp_uid = strExtraction(rsp, "imp_uid=","&");
		int paid_amount = Integer.parseInt(strExtraction(rsp, "&paid_amount=",""));
		Payment payment = api.paymentByImpUid(imp_uid).getResponse();
		int amount = payment.getAmount().intValue();
		//결제 금액이 같은지 확인(검증)
		//다르면 결제 취소
		if(paid_amount != amount) {
			cancelPayment(imp_uid, payment.getAmount());
			return false;
		}
		return true;
	}

	//completePayment : 결제 완료하기 ====================================================================================	
	@Override
	public boolean completePayment(PaymentDTO payment, MemberVO user) throws IamportResponseException, IOException{
		//값이 없으면
		if(payment == null || user == null)
			return false;
		if(payment.getImp_uid() == null || payment.getMbNum() < 1 || user.getMb_num() < 1)
			return false;
		if(payment.getOrCode() == "" || payment.getEmail() == "") {
			cancelPayment(payment.getImp_uid(), new BigDecimal(payment.getPayAmount()));
			return false;
		}
		if(payment.getPointAmount() < 1000 || payment.getPayAmount() < 0) {
			cancelPayment(payment.getImp_uid(), new BigDecimal(payment.getPayAmount()));
			return false;
		}
		if(payment.getOrderList().isEmpty()) {
			cancelPayment(payment.getImp_uid(), new BigDecimal(payment.getPayAmount()));
			return false;
		}
		if(payment.getAdNum() < 0 || payment.getRecipient() == "" || payment.getPhone() == "" || 
				payment.getPostcode() == "" || payment.getAddress() == "") {
			cancelPayment(payment.getImp_uid(), new BigDecimal(payment.getPayAmount()));
			return false;
		}
		//다른 회원이면
		if(payment.getMbNum() != user.getMb_num()) {
			cancelPayment(payment.getImp_uid(), new BigDecimal(payment.getPayAmount()));
			return false;
		}
		//배송지 정보 ----------------------------------------------------------------------------------------------------
		AddressVO dbAddress;
		AddressVO address = new AddressVO(payment.getMbNum(), payment.getRecipient(), payment.getPhone(), 
				payment.getPostcode(), payment.getAddress(), payment.getDetail(), payment.getRequest());
		//배송지 번호가 0이면(배송지에 추가되지 않은)
		if(payment.getAdNum() == 0) {
			address.setAd_main("0");
			//배송지가 있는지 확인
			dbAddress = goodsDao.selectAddressByAll(address);
			if(dbAddress == null) {
				//배송지 추가	
				goodsDao.insertAddressAll(address);
				dbAddress = goodsDao.selectAddressByAll(address);
			}
		}
		//배송지 번호가 0이 아니면(배송지에 추가된)
		else {
			dbAddress = goodsDao.selectAddress(payment.getAdNum(), payment.getMbNum());
			//값이 없으면 배송지 추가
			if(dbAddress == null) {
				//배송지 추가	
				address.setAd_main("0");
				goodsDao.insertAddressAll(address);
				dbAddress = goodsDao.selectAddressByAll(address);
			}
			//값이 다르면 배송지 정보 수정
			if(!dbAddress.getAd_recipient().equals(address.getAd_recipient()))
				dbAddress.setAd_recipient(address.getAd_recipient());
			if(!dbAddress.getAd_phone().equals(address.getAd_phone()))
				dbAddress.setAd_phone(address.getAd_phone());
			if(!dbAddress.getAd_post_code().equals(address.getAd_post_code()))
				dbAddress.setAd_post_code(address.getAd_post_code());
			if(!dbAddress.getAd_address().equals(address.getAd_address()))
				dbAddress.setAd_address(address.getAd_address());
			if(!dbAddress.getAd_detail().equals(address.getAd_detail()))
				dbAddress.setAd_detail(address.getAd_detail());
			if(!dbAddress.getAd_request().equals(address.getAd_request()))
				dbAddress.setAd_request(address.getAd_request());
			goodsDao.updateAddress(dbAddress);
		}
		//배송지 없으면
		if(dbAddress.getAd_num() < 1) {
			cancelPayment(payment.getImp_uid(), new BigDecimal(payment.getPayAmount()));
			return false;
		}			
		//주문 추가 -------------------------------------------------------------------------------
		goodsDao.insertOrder(payment, dbAddress.getAd_num());
		//주문 가져오기
		OrderVO dbOrder = goodsDao.selectOrderByPayment(payment.getMbNum(), payment.getImp_uid());
		//주문 추가 못했으면
		if(dbOrder == null) {
			cancelPayment(payment.getImp_uid(), new BigDecimal(payment.getPayAmount()));
			return false;
		}
		//주문 상세 추가 -----------------------------------------------------------------------------
		boolean isInserted = true;
		for(OrderDTO order : payment.getOrderList()) {
			if(order == null) {
				isInserted = false;
				break;
			}
			if(order.getOtNum() < 1 || order.getOrAmount() < 1 || order.getTotalPrice() < 1) {
				isInserted = false;
				break;
			}
			if(!goodsDao.insertOrderDetail(dbOrder.getOr_code(), order, "배송준비중")) {
				isInserted = false;
				break;
			}else
				goodsDao.deleteBasketByOtNum(payment.getMbNum(), order.getOtNum());
		}
		//주문 상세 추가 못했으면
		if(!isInserted) {
			cancelPayment(payment.getImp_uid(), new BigDecimal(payment.getPayAmount()));
			return false;
		}
		//포인트 사용 ------------------------------------------------------------------------------
		if(payment.getPointAmount() > 0)
			memberDao.insertPoint(payment.getMbNum(), "사용", "굿즈 구매", payment.getPointAmount());
		return true;
	}//

	//modifyBasket : 장바구니 수정 ====================================================================================
	@Override
	public boolean modifyBasket(BasketVO basket, MemberVO user) {
		//값이 없으면
		if(basket == null || user == null || user.getMb_num() < 1)
			return false;
		if(basket.getBs_num() < 1 || basket.getBs_ot_num() < 1 || basket.getBs_amount() < 1)
			return false;
		//회원 번호가 다르면
		if(basket.getBs_mb_num() != user.getMb_num())
			return false;
		//장바구니에 담긴 상품인지 확인
		BasketVO dbBasket = goodsDao.selectBasket(basket);
		if(dbBasket == null)
			return false;
		//값 재설정
		dbBasket.setBs_ot_num(basket.getBs_ot_num());
		dbBasket.setBs_amount(basket.getBs_amount());
		return goodsDao.updateBasket(dbBasket);
	}//
	
	//getGoodsList : cri 없이 굿즈 리스트 가져오기 ==========================================================================
	@Override
	public ArrayList<GoodsVO> getGoodsList() {
		return goodsDao.selectGoodsList();
	}//
}
