package kr.inyo.munglog.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.inyo.munglog.service.AdminService;
import kr.inyo.munglog.service.MessageService;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	@Autowired
	MessageService messageService;
	
/* ajax 아님 ***************************************************************/
	/* 관리자홈화면 ---------------------------------------------------------------*/
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public ModelAndView adminGet(ModelAndView mv) {
		mv.setViewName("/admin/adminHome");
		return mv;
	}
	
/* ajax **************************************************************************************************************** */

}
