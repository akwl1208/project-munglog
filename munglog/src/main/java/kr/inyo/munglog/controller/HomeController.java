package kr.inyo.munglog.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		int res = memberService.signup(member);
		if(res == 1) //회원가입 성공 -> 로그인 화면으로
			messageService.message(response, "회원가입에 성공했습니다. 로그인해주세요.", "/munglog/");
		if(res == 0) //회원정보가 있음 -> 아이디 비번 찾기 화면으로
			messageService.message(response, "이미 가입된 회원입니다. 아이디/비번찾기해주세요.", "/munglog/account/signup");
		else //회원가입 실패
			messageService.message(response, "회원가입에 실패했습니다. 입력한 회원정보를 확인해주세요.", "/munglog/account/signup");
		return mv;
	}
	
	/* 로그인 ---------------------------------------------------------------*/
	@RequestMapping(value = "/account/login", method = RequestMethod.GET)
	public ModelAndView loginGet(ModelAndView mv, MemberVO member) {	
		mv.setViewName("/account/login");
		return mv;
	}
	
	@RequestMapping(value = "/account/login", method = RequestMethod.POST)
	public ModelAndView loginPost(ModelAndView mv, MemberVO member) {
		MemberVO user = memberService.getMember(member);
		mv.addObject("user", user);
		if(user == null)
			mv.setViewName("redirect:/account/login");
		if(user != null)
			mv.setViewName("redirect:/");
		return mv;
	}
	
	/* 로그아웃 ---------------------------------------------------------------*/
	@RequestMapping(value="/logout")
	public ModelAndView logout(ModelAndView mv, HttpSession session){
		session.removeAttribute("user");
    mv.setViewName("redirect:/");
    return mv;
	}
	
  /* 아이디/비번찾기 ---------------------------------------------------------------*/
	@RequestMapping(value= "/account/find", method=RequestMethod.GET)
	public ModelAndView findGet(ModelAndView mv, String type){
		mv.addObject("type", type);
		mv.setViewName("/account/find");
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
	
	/* 회원인지 아닌지 확인 ---------------------------------------------------------------*/
	@RequestMapping(value = "/check/member", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> checkMember(@RequestBody MemberVO member) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		boolean isMember = memberService.login(member);
		map.put("res", isMember);
		return map;
	}
	
	/* 세션 아이디로 이메일 가져오기 ---------------------------------------------------------------*/
	@RequestMapping(value = "/get/email", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getEmail(@RequestBody MemberVO member) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		String email = memberService.getEmail(member);
		map.put("email", email);
		return map;
	}
}
