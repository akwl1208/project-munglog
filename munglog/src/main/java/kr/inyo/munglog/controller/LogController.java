package kr.inyo.munglog.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.inyo.munglog.service.MemberService;
import kr.inyo.munglog.service.MessageService;
import kr.inyo.munglog.vo.MemberVO;

@Controller
public class LogController {
	
	@Autowired
	MemberService memberService;
	@Autowired
	MessageService messageService;
	
/* ajax 아님 ***************************************************************/
	/* 강아지 정보 등록 ---------------------------------------------------------------*/
	@RequestMapping(value = "/log/register", method = RequestMethod.GET)
	public ModelAndView logRegisterGet(ModelAndView mv) {
		mv.setViewName("/log/register");
		return mv;
	}
/* ajax ***************************************************************/
	
}
