package kr.inyo.munglog.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.inyo.munglog.service.MemberService;
import kr.inyo.munglog.service.MessageService;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.VerificationVO;

@Controller
public class HomeController {
	
	@Autowired
	MemberService memberService;
	@Autowired
	MessageService messageService;
	
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
	public ModelAndView signupPost(ModelAndView mv, MemberVO member,
			HttpServletResponse response) {
		System.out.println("-----------------------------------------------");
		System.out.println("post:" + member);
		System.out.println("-----------------------------------------------");
		int res = memberService.signup(member);
		if(res == 1) //회원가입 성공 -> 로그인 화면으로
			messageService.message(response, "회원가입에 성공했습니다. 로그인해주세요.", "/munglog/");
		if(res == 0) //회원정보가 있음 -> 아이디 비번 찾기 화면으로
			messageService.message(response, "이미 가입된 회원입니다. 아이디/비번찾기해주세요.", "/munglog/account/signup");
		else //회원가입 실패
			messageService.message(response, "회원가입에 실패했습니다. 입력한 회원정보를 확인해주세요.", "/munglog/account/signup");
		return mv;
	}
/* ajax ***************************************************************/
	/* 이메일 중복검사 ---------------------------------------------------------------*/
	@RequestMapping(value = "/check/email", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> checkEmail(@RequestBody MemberVO member) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		boolean res = memberService.isMember(member);
		map.put("res", res);
		return map;
	}
	
	/* 이메일 보내기 ---------------------------------------------------------------*/
	@RequestMapping(value = "/send/email", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> sendEmail(@RequestBody MemberVO member) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		boolean res = memberService.sendEmail(member);
		map.put("res", res);
		return map;
	}
	
	/* 본인인증 삭제하기 ---------------------------------------------------------------*/
	@RequestMapping(value = "/delete/verification", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> deleteVerification(@RequestBody MemberVO member) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		boolean res = memberService.deleteVerification(member);
		map.put("res", res);
		return map;
	}
	
	/* 본인인증 일치하는지 확인하기 ---------------------------------------------------------------*/
	@RequestMapping(value = "/check/code", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> checkCode(@RequestBody VerificationVO veri) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		boolean res = memberService.checkCode(veri);
		map.put("res", res);
		return map;
	}
	
	/* 본인인증번호 실패횟수 증가하고 실패횟수 반환 ---------------------------------------------------------------*/
	@RequestMapping(value = "/count/failure", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> countFailure(@RequestBody VerificationVO veri) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		//실패횟수 증가
		memberService.countFailure(veri);
		//실패횟수 반환
		int count = memberService.getFailureCount(veri);
		map.put("count", count);
		return map;
	}
}
