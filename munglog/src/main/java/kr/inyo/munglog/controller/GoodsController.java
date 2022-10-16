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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.siot.IamportRestClient.exception.IamportResponseException;

import kr.inyo.munglog.dto.BasketDTO;
import kr.inyo.munglog.dto.OrderDTO;
import kr.inyo.munglog.dto.OrderListDTO;
import kr.inyo.munglog.dto.PaymentDTO;
import kr.inyo.munglog.dto.QnaDTO;
import kr.inyo.munglog.dto.ReviewDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.pagination.PageMaker;
import kr.inyo.munglog.service.BoardService;
import kr.inyo.munglog.service.GoodsService;
import kr.inyo.munglog.service.MessageService;
import kr.inyo.munglog.vo.AddressVO;
import kr.inyo.munglog.vo.AttachmentVO;
import kr.inyo.munglog.vo.BasketVO;
import kr.inyo.munglog.vo.BoardVO;
import kr.inyo.munglog.vo.CategoryVO;
import kr.inyo.munglog.vo.CommentVO;
import kr.inyo.munglog.vo.GoodsVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OptionVO;

@Controller
public class GoodsController {
	
	@Autowired
	GoodsService goodsService;
	@Autowired
	MessageService messageService;
	@Autowired
	BoardService boardService;
	
/* ajax 아님 ************************************************************************************************************ */
	/* 굿즈 ----------------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/goods", method = RequestMethod.GET)
	public ModelAndView goodsGet(ModelAndView mv) {
		//카테고리 리스트 가져오기
		ArrayList<CategoryVO> categoryList = goodsService.getCategoryList();
		
		mv.addObject("categoryList", categoryList);
		mv.setViewName("/goods/goodsList");
		return mv;
	}//
	
	/* 굿즈 상세보기-------------------------------------------------------------------------------------------------------*/
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
	
	/* 장바구니 ----------------------------------------------------------------------------------------------------------*/
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
	
	/* 주문하기 -------------------------------------------------------------------------------------------------------------*/
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
	
	/* 굿즈 QnA ------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/goods/qna", method = RequestMethod.GET)
	public ModelAndView goodsQnaGet(ModelAndView mv) {
		
		mv.setViewName("/goods/qna");
		return mv;
	}//
	
	/* 굿즈 QnA 등록 ---------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/goods/registerQna", method = RequestMethod.GET)
	public ModelAndView goodsRegisterQnaGet(ModelAndView mv) {
		ArrayList<GoodsVO> goodsList = goodsService.getGoodsList();
		
		mv.addObject("goodsList", goodsList);
		mv.setViewName("/goods/registerQna");
		return mv;
	}//
	
	@RequestMapping(value = "/goods/registerQna", method = RequestMethod.POST)
	public ModelAndView goodsRegisterQnaPost(ModelAndView mv, HttpSession session,
			BoardVO board, MultipartFile [] attachments, Integer qn_gs_num, HttpServletResponse response) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = boardService.registerQna(user, board, qn_gs_num, attachments);
		
		if(res)
			messageService.message(response, "Q&A를 등록했습니다.", "/munglog/goods/qna");
		else
			messageService.message(response, "Q&A 등록에 실패했습니다.", "/munglog/goods/registerQna");
		return mv;
	}//
	
	/* 굿즈 QnA 상세보기 --------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/goods/qnaDetail/{qn_num}", method = RequestMethod.GET)
	public ModelAndView goodsQnaDetailGet(ModelAndView mv, @PathVariable("qn_num")int qn_num,
			HttpSession session, HttpServletResponse response) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//로그인 안했으면
		if(user == null)
			messageService.message(response, "로그인해주세요.", "/munglog/account/login");
		//qna 가져오기
		QnaDTO qna = boardService.getQna(user, qn_num);
		//다른 회원이 접근한거면
		if(qna != null && (user.getMb_num() != qna.getBd_mb_num()) 
				&& !user.getMb_level().equals("A") && !user.getMb_level().equals("S"))
			messageService.message(response, "Q&A를 작성한 회원만 볼 수 있습니다.", "/munglog/goods/qna");
		ArrayList<AttachmentVO> attachmentList = null;
		CommentVO comment = null;
		if(qna != null) {
			//첨부파일 리스트 가져오기
			attachmentList = boardService.getAttachmentList(qna.getQn_bd_num());
			//답변 가져오기
			comment = boardService.getBoardComment(qna.getQn_bd_num());			
		}
		
		mv.addObject("comment", comment);
		mv.addObject("qna", qna);
		mv.addObject("attachmentList", attachmentList);
		mv.setViewName("/goods/qnaDetail");
		return mv;
	}//
	
	/* 굿즈 QnA 수정 -----------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/goods/modifyQna/{qn_num}", method = RequestMethod.GET)
	public ModelAndView goodsModifyQnaGet(ModelAndView mv, @PathVariable("qn_num")int qn_num,
			HttpSession session, HttpServletResponse response) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//로그인 안했으면
		if(user == null)
			messageService.message(response, "로그인해주세요.", "/munglog/account/login");
		//qna 가져오기
		QnaDTO qna = boardService.getQna(user, qn_num);
		//다른 회원이 접근한거면
		if(qna != null && (user.getMb_num() != qna.getBd_mb_num()))
			messageService.message(response, "Q&A를 작성한 회원만 수정할 수 있습니다.", "/munglog/goods/qna");
		//첨부파일 리스트 가져오기
		ArrayList<AttachmentVO> attachmentList = null;
		if(qna != null)
			attachmentList = boardService.getAttachmentList(qna.getQn_bd_num());
		ArrayList<GoodsVO> goodsList = goodsService.getGoodsList();
		
		mv.addObject("qna", qna);
		mv.addObject("attachmentList", attachmentList);
		mv.addObject("goodsList", goodsList);
		mv.setViewName("/goods/modifyQna");
		return mv;
	}//
	
	@RequestMapping(value = "/goods/modifyQna/{qn_num}", method = RequestMethod.POST)
	public ModelAndView goodsModifyQnaPost(ModelAndView mv, @PathVariable("qn_num")int qn_num, HttpSession session,
			QnaDTO qna, MultipartFile [] attachments, int[] nums, HttpServletResponse response) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		qna.setQn_num(qn_num);
		boolean res = boardService.modifyQna(user, qna, attachments, nums);
		
		if(res)
			messageService.message(response, "Q&A를 수정했습니다.", "/munglog/goods/qnaDetail/"+qn_num);
		else
			messageService.message(response, "Q&A 수정에 실패했습니다.", "/munglog/goods/modifyQna/"+qn_num);
		return mv;
	}//
	
	/* 굿즈 리뷰 ----------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/goods/review", method = RequestMethod.GET)
	public ModelAndView goodsReviewGet(ModelAndView mv) {
		ArrayList<GoodsVO> goodsList = goodsService.getGoodsList();
		
		mv.addObject("goodsList", goodsList);
		mv.setViewName("/goods/review");
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
	}//
	
	/* 장바구니 삭제 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/delete/basket", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> deleteBasket(@RequestBody BasketVO basket, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = goodsService.deleteBasket(basket, user);
		
		map.put("res", res);
		return map;
	}//
	
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
	
	/* 장바구니 수정 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/modify/basket", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> modifyBasket(@RequestBody BasketVO basket, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = goodsService.modifyBasket(basket, user);
		
		map.put("res", res);
		return map;
	}//
	
	/* 옵션리스트 가져오기 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/get/goodsOptions", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getGoodsOptions(@RequestBody GoodsVO goods) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		ArrayList<OptionVO> optionList = goodsService.getOtionList(goods.getGs_num());
		
		map.put("optionList", optionList);
		return map;
	}//
	
	/* 굿즈 qna 이미지 업로드 ------------------------------------------------------------------------------------------- */
	@RequestMapping(value="/upload/qnaImg", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> uploadQnaImg(@RequestParam("file") MultipartFile file){
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		String url = boardService.uploadQnaImage(file);
		
		map.put("url", url);
		return map;
	}//
	
	/* QNA 리스트 가져오기 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/get/qnaList", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getQnaList(@RequestBody Criteria cri) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		//qna 리스트 가져오기
		ArrayList<QnaDTO> qnaList = boardService.getQnaList(cri);
		int totalCount = boardService.getBoardTotalCount(cri, "QNA");
		PageMaker pm = new PageMaker(totalCount, 5, cri);
		
		map.put("pm", pm);
		map.put("qnaList", qnaList);
		return map;
	}//
	
	/* QNA 삭제 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/delete/qna", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> deleteQna(@RequestBody BoardVO board, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		board.setBd_type("QNA");
		boolean res = boardService.deleteBoard(board, user);
		
		map.put("res", res);
		return map;
	}//
	
	/* 리뷰 리스트 가져오기 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/get/reviewList", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getReviewList(@RequestBody Criteria cri) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		//qna 리스트 가져오기
		ArrayList<ReviewDTO> reviewList = goodsService.getReviewList(cri);
		int totalCount = goodsService.getReviewTotalCount(cri);
		PageMaker pm = new PageMaker(totalCount, 5, cri);
		
		map.put("pm", pm);
		map.put("reviewList", reviewList);
		return map;
	}//
}
