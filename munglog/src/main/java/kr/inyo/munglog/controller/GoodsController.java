package kr.inyo.munglog.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.inyo.munglog.dto.BasketDTO;
import kr.inyo.munglog.dto.OrderDTO;
import kr.inyo.munglog.dto.OrderListDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.pagination.PageMaker;
import kr.inyo.munglog.service.GoodsService;
import kr.inyo.munglog.service.MessageService;
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
	public ModelAndView goodsBasketGet(ModelAndView mv, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ArrayList<BasketDTO> basketList = goodsService.getBasketList(user);
		
		mv.addObject("basketList", basketList);
		mv.setViewName("/goods/basket");
		return mv;
	}//
	
	/* 주문하기 -------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/goods/order/{mb_num}", method = RequestMethod.GET)
	public ModelAndView goodsOrderGet(ModelAndView mv, @PathVariable("mb_num")int mb_num,
			OrderListDTO orderList, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ArrayList<OrderDTO> oList = goodsService.getOrderList(mb_num, orderList, user);
		
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
}
