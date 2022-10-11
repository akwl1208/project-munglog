package kr.inyo.munglog.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siot.IamportRestClient.exception.IamportResponseException;

import kr.inyo.munglog.dto.BasketDTO;
import kr.inyo.munglog.dto.OrderDTO;
import kr.inyo.munglog.dto.OrderListDTO;
import kr.inyo.munglog.dto.PaymentDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.pagination.PageMaker;
import kr.inyo.munglog.service.GoodsService;
import kr.inyo.munglog.service.MessageService;
import kr.inyo.munglog.vo.AddressVO;
import kr.inyo.munglog.vo.BasketVO;
import kr.inyo.munglog.vo.CategoryVO;
import kr.inyo.munglog.vo.GoodsVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OptionVO;

@Controller
public class GoodsController {
	
	@Autowired
	GoodsService goodsService;
	@Autowired
	MessageService messageService;
	
/* ajax 아님 ***************************************************************/
	/* 굿즈 ---------------------------------------------------------------*/
	@RequestMapping(value = "/goods", method = RequestMethod.GET)
	public ModelAndView goodsGet(ModelAndView mv) {
		//카테고리 리스트 가져오기
		ArrayList<CategoryVO> categoryList = goodsService.getCategoryList();
		
		mv.addObject("categoryList", categoryList);
		mv.setViewName("/goods/goodsList");
		return mv;
	}//
	
	/* 굿즈 상세보기--------------------------------------------------------------------------------*/
	@RequestMapping(value = "/goods/goodsDetail/{gs_num}", method = RequestMethod.GET)
	public ModelAndView goodsDetailGet(ModelAndView mv, @PathVariable("gs_num")int gs_num) {
		//굿즈 정보 가져오기
		GoodsVO goods = goodsService.getGoods(gs_num);
		ArrayList<OptionVO> optionList = goodsService.getOtionList(gs_num);
		
		mv.addObject("goods", goods);
		mv.addObject("optionList", optionList);
		mv.setViewName("/goods/goodsDetail");
		return mv;
	}//
	
	/* 장바구니 -------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/goods/basket", method = RequestMethod.GET)
	public ModelAndView goodsBasketGet(ModelAndView mv, HttpSession session,
			HttpServletResponse response) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//회원이 아니거나 
		if(user == null)
			messageService.message(response, "접근할 수 없습니다.", "/munglog/account/login");
		ArrayList<BasketDTO> basketList = goodsService.getBasketList(user);
		
		mv.addObject("basketList", basketList);
		mv.setViewName("/goods/basket");
		return mv;
	}//
	
	/* 주문하기 -------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/goods/order/{mb_num}", method = RequestMethod.GET)
	public ModelAndView goodsOrderGet(ModelAndView mv, @PathVariable("mb_num")int mb_num,
			OrderListDTO orderList, HttpSession session, HttpServletResponse response) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//회원이 아니거나 
		if(user == null)
			messageService.message(response, "접근할 수 없습니다.", "/munglog/account/login");
		//회원번호가 다르면 접근 할 수 없음
		if(user.getMb_num() != mb_num)
			messageService.message(response, "접근할 수 없습니다.", "/munglog/");
		//주문내역 가져오기
		ArrayList<OrderDTO> oList = goodsService.getOrderList(mb_num, orderList, user);
		//기본 배송지 가져오기
		AddressVO address = goodsService.getMainAddress(user);
		
		mv.addObject("address", address);
		mv.addObject("oList", oList);
		mv.setViewName("/goods/order");
		return mv;
	}//
	
/* ajax **************************************************************************************************************** */
	/* 굿즈 리스트 가져오기 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/get/goodsList", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getGoodsList(@RequestBody Criteria cri) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		//굿즈 리스트 가져오기
		ArrayList<GoodsVO> goodsList = goodsService.getGoodsList(cri);
		int totalCount = goodsService.getGoodsTotalCount(cri);
		PageMaker pm = new PageMaker(totalCount, 5, cri);
		
		map.put("pm", pm);
		map.put("goodsList", goodsList);
		return map;
	}//
	
	/* 장바구니에 담기 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/put/basket", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> putBasket(@RequestBody BasketVO basket, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		int res = goodsService.putBasket(basket, user);
		
		map.put("res", res);
		return map;
	}
	
	/* 장바구니 삭제 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/delete/basket", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> deleteBasket(@RequestBody BasketVO basket, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = goodsService.deleteBasket(basket, user);
		
		map.put("res", res);
		return map;
	}
	
	/* 결제 검증 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/verify/payment", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> verifyPayment(@RequestBody String rsp)
			throws IamportResponseException, IOException {
		HashMap<Object, Object> map = new HashMap<Object, Object>();		
		boolean res = goodsService.verifyPayment(rsp);
		
		map.put("res", res);
		return map;
	}//
	
	/* 결제 성공 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/complete/payment", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> completePayment(@RequestBody PaymentDTO payment, 
			HttpSession session) throws IamportResponseException, IOException{
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = goodsService.completePayment(payment, user);
		
		map.put("res", res);
		return map;
	}//

}
