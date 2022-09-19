package kr.inyo.munglog.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.inyo.munglog.service.LogService;
import kr.inyo.munglog.service.MessageService;
import kr.inyo.munglog.vo.DogListVO;
import kr.inyo.munglog.vo.MemberVO;

@Controller
public class LogController {
	
	@Autowired
	LogService logService;
	@Autowired
	MessageService messageService;
	
/* ajax 아님 ***************************************************************/
	/* 강아지 정보 등록 ---------------------------------------------------------------*/
	@RequestMapping(value = "/log/register", method = RequestMethod.GET)
	public ModelAndView logRegisterGet(ModelAndView mv) {
		mv.setViewName("/log/register");
		return mv;
	}
	
	@RequestMapping(value = "/log/register", method = RequestMethod.POST)
	public ModelAndView logRegisterPost(ModelAndView mv, DogListVO dlist,
			HttpSession session, HttpServletResponse response) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		int res = logService.insertDog(user, dlist);
		if(res == 1)
			messageService.message(response, "강아지 정보가 등록되었습니다.", "/munglog/");
		else if(res == 0)
			messageService.message(response, "강아지는 최대 3마리까지 등록할 수 있습니다.", "/munglog/");
		else if(res == -1)
			messageService.message(response, "강아지 정보 등록에 실패했습니다. 다시 시도해주세요.", "/munglog/log/register?mb_num="+user.getMb_num());
		return mv;
	}
/* ajax ***************************************************************/

}
