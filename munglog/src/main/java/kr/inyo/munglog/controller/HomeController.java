package kr.inyo.munglog.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.inyo.munglog.service.MemberService;
import kr.inyo.munglog.vo.MemberVO;

@Controller
public class HomeController {
	
	@Autowired
	MemberService memberService;
/* ajax 아님 ***************************************************************/
	/* 홈화면 ---------------------------------------------------------------*/
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(ModelAndView mv) {
		mv.setViewName("/main/home");
		return mv;
	}
	
	/* 회원가입 ---------------------------------------------------------------*/
	@RequestMapping(value = "/account/signup", method = RequestMethod.GET)
	public ModelAndView signupGet(ModelAndView mv) {
		mv.setViewName("/account/signup");
		return mv;
	}
	
	@RequestMapping(value = "/account/signup", method = RequestMethod.POST)
	public ModelAndView signupPost(ModelAndView mv, MemberVO member) {
		System.out.println("post:" + member);
		mv.setViewName("/account/signup");
		return mv;
	}
/* ajax ***************************************************************/
	@RequestMapping(value = "/check/email", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> checkEmail(@RequestBody MemberVO member) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		boolean res = memberService.isMember(member);
		map.put("res", res);
		return map;
	}
}
