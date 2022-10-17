package kr.inyo.munglog.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.inyo.munglog.dto.MyOrderDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.service.MemberService;
import kr.inyo.munglog.service.MessageService;
import kr.inyo.munglog.service.MypageService;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OrderVO;
import kr.inyo.munglog.vo.ReviewVO;

@Controller
public class MypageController {
	
	@Autowired
	MypageService mypageService;
	@Autowired
	MemberService memberService;
	@Autowired
	MessageService messageService;
	
/* ajax 아님 ****************************************************************************************************** */
	/* 마이페이지홈화면 ----------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public ModelAndView mypageGet(ModelAndView mv) {
		
		mv.setViewName("/mypage/mypageHome");
		return mv;
	}//
	
	/* 주문/배송 -----------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/mypage/order", method = RequestMethod.GET)
	public ModelAndView mypageOrderGet(ModelAndView mv) {
		
		mv.setViewName("/mypage/order");
		return mv;
	}//
	
	/* 회원정보 수정 ---------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/mypage/modifyAccount", method = RequestMethod.GET)
	public ModelAndView mypageModifyAccountGet(ModelAndView mv) {
		
		mv.setViewName("/mypage/modifyAccount");
		return mv;
	}//
	
	@RequestMapping(value = "/mypage/modifyAccount", method = RequestMethod.POST)
	public ModelAndView mypageModifyAccountPost(ModelAndView mv, MemberVO member,
			HttpSession session, HttpServletResponse response) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = memberService.modifyAccount(member, user);
		
		if(res)
			messageService.message(response, "회원정보가 수정되었습니다.", "/munglog/mypage");
		else
			messageService.message(response, "회원정보 수정에 실패했습니다.", "/munglog/mypage/modifyAccount");	
		return mv;
	}//
	
/* ajax **************************************************************************************************************** */
	/* 내 주문 내역 가져오기 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/get/myOrderList", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> myOrderList(@RequestBody Criteria cri, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		cri.setMb_num(user.getMb_num());
		ArrayList<OrderVO> orderList = mypageService.getMyOrderList(cri);
		ArrayList<MyOrderDTO> orderDetailList = mypageService.getMyOrderDetailList(cri);
		
		
		map.put("orderDetailList", orderDetailList);
		map.put("orderList", orderList);
		return map;
	}//
	
	/* 내 리뷰 가져오기 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/get/myReview", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> myReview(@RequestBody ReviewVO review, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		ReviewVO myReview = mypageService.getMyReview(review, user);
		
		map.put("review", myReview);
		return map;
	}//
	
	/* 리뷰 등록 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/register/review", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> registerReview(@RequestParam(value="file", required=false) MultipartFile file, 
			@RequestParam("rv_od_num") int rv_od_num, @RequestParam("rv_rating") String rv_rating,
			@RequestParam("rv_content") String rv_content, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		ReviewVO review = new ReviewVO(rv_od_num, rv_rating, rv_content, "");
		boolean res = mypageService.registerReview(user, review, file);
		
		map.put("res", res);
		return map;
	}//
	
	/* 리뷰 수정 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/modify/review", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> modifyReview(@RequestParam(value="file", required=false) MultipartFile file, 
			@RequestParam("rv_num") int rv_num, @RequestParam("rv_od_num") int rv_od_num, @RequestParam("rv_rating") String rv_rating,
			@RequestParam("rv_content") String rv_content, @RequestParam("delModiImage") boolean delModiImage, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		ReviewVO review = new ReviewVO(rv_num, rv_od_num, rv_rating, rv_content, "");
		boolean res = mypageService.modifyReview(user, review, file, delModiImage);
		
		map.put("res", res);
		return map;
	}//
}
