package kr.inyo.munglog.controller;

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

import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.pagination.PageMaker;
import kr.inyo.munglog.service.LogService;
import kr.inyo.munglog.service.MemberService;
import kr.inyo.munglog.service.MessageService;
import kr.inyo.munglog.vo.DogListVO;
import kr.inyo.munglog.vo.DogVO;
import kr.inyo.munglog.vo.LogVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.SubjectVO;

@Controller
public class LogController {
	
	@Autowired
	LogService logService;
	@Autowired
	MessageService messageService;
	@Autowired
	MemberService memberService;
	
/* ajax 아님 *************************************************************************************************************** */
	/* 강아지 정보 등록 --------------------------------------------------------------------------------------------------------*/
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
			messageService.message(response, "강아지 정보 등록에 실패했습니다. 다시 시도해주세요.","/munglog/log/register?mb_num="+user.getMb_num());
		return mv;
	}
	
	/* 나의 일지 ---------------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/log/mylog/{mb_num}", method = RequestMethod.GET)
	public ModelAndView logMylogGet(ModelAndView mv, @PathVariable("mb_num")int mb_num,
			HttpSession session, HttpServletResponse response) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//회원이 아니거나 
		if(user == null) {
			messageService.message(response, "접근할 수 없습니다.", "/munglog/account/login");
		}
		//회원번호가 다르면 접근 할 수 없음
		if(user.getMb_num() != mb_num) {
			messageService.message(response, "접근할 수 없습니다.", "/munglog/");
		}
		//강아지 정보 가져오기
		ArrayList<DogVO> dList = logService.getDogs(user);
		//사진이 등록된 년도 가져오기
		ArrayList<String> regYearList = logService.getRegYearList(user);
		
		mv.addObject("regYearList", regYearList);
		mv.addObject("dList", dList);
		mv.setViewName("/log/mylog");
		return mv;
	}
	
	/* 나의 일지 상세보기 -------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/log/mylogDetail/{mb_num}", method = RequestMethod.GET)
	public ModelAndView logMylogGet(ModelAndView mv, @PathVariable("mb_num")int mb_num,
			Criteria cri, HttpSession session, HttpServletResponse response) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//회원이 아니거나 
		if(user == null) {
			messageService.message(response, "접근할 수 없습니다.", "/munglog/account/login");
		}
		//회원번호가 다르면 접근 할 수 없음
		if(user.getMb_num() != mb_num) {
			messageService.message(response, "접근할 수 없습니다.", "/munglog/");
		}
		int totalCount = logService.getLogTotalCount(cri);
		cri.setPerPageNum(totalCount);
		PageMaker pm = new PageMaker(totalCount, 2, cri);
		//일지들 가져오기
		ArrayList<LogVO> logList = logService.getLogList(cri);
		//강아지 정보 가져오기
		ArrayList<DogVO> dogList = logService.getDogs(user);
		
		mv.addObject("dogList", dogList);
		mv.addObject("logList", logList);
		mv.addObject("pm", pm);
		mv.setViewName("/log/mylogDetail");
		return mv;
	}
	
/* ajax ****************************************************************************************************************** */
	/* 일지에 사진 업로드 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/upload/log", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> uploadLog(@RequestParam("file") MultipartFile file,
			@RequestParam("dg_nums[]") ArrayList<Integer> dg_nums, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		int res = logService.uploadLog(dg_nums, file, user);
		map.put("res", res);
		return map;
	}
	
	/* 일지 가져오기 --------------------------------------------------------------------------------------------------------- */
	@RequestMapping(value = "/get/logList", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getLogList(@RequestBody Criteria cri) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		ArrayList<LogVO> logList = logService.getLogList(cri);
		int totalCount = logService.getLogTotalCount(cri);
		PageMaker pm = new PageMaker(totalCount, 2, cri);
		
		map.put("pm",pm);
		map.put("lList", logList);
		return map;
	}
	
	/* 일지 피사체 가져오기 ----------------------------------------------------------------------------------------------------- */
	@RequestMapping(value = "/get/subjectList", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getSubjectList(@RequestBody LogVO log) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		ArrayList<SubjectVO> subjectList = logService.getSubjectList(log.getLg_num());

		map.put("subjectList", subjectList);
		return map;
	}
}
