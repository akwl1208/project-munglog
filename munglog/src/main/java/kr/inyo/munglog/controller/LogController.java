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
import kr.inyo.munglog.vo.FriendVO;
import kr.inyo.munglog.vo.HeartVO;
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
			messageService.message(response, "강아지 정보가 등록되었습니다.", "/munglog/log/mylog/"+user.getMb_num());
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
		//회원정보 가져옴
		MemberVO member = memberService.getMemberByMbnum(user.getMb_num());
		//강아지 정보 가져오기
		ArrayList<DogVO> dList = logService.getDogs(user);
		//사진이 등록된 년도 가져오기
		ArrayList<String> regYearList = logService.getRegYearList(user);
		
		mv.addObject("member", member);
		mv.addObject("regYearList", regYearList);
		mv.addObject("dList", dList);
		mv.setViewName("/log/mylog");
		return mv;
	}
	
	/* 나의 일지 상세보기 -------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/log/mylogDetail/{mb_num}", method = RequestMethod.GET)
	public ModelAndView logMylogDetailGet(ModelAndView mv, @PathVariable("mb_num")int mb_num,
			int lg_num, Criteria cri, HttpSession session, HttpServletResponse response) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//회원이 아니거나 
		if(user == null) {
			messageService.message(response, "접근할 수 없습니다.", "/munglog/account/login");
		}
		//회원번호가 다르면 접근 할 수 없음
		if(user.getMb_num() != mb_num) {
			messageService.message(response, "접근할 수 없습니다.", "/munglog/");
		}
		//일지 전체 개수 가져오기
		int totalCount = logService.getLogTotalCount(cri);
		//criteria 재설정
		cri.setPage(1);
		cri.setPerPageNum(totalCount);
		//회원정보 가져옴
		MemberVO member = memberService.getMemberByMbnum(user.getMb_num());
		//일지들 가져오기
		ArrayList<LogVO> logList = logService.getLogList(cri);
		//강아지 정보 가져오기
		ArrayList<DogVO> dogList = logService.getDogs(user);
		//인덱스 찾기
		int index = logService.findIndex(logList, lg_num);
		
		mv.addObject("member", member);
		mv.addObject("index", index);
		mv.addObject("dogList", dogList);
		mv.addObject("logList", logList);
		mv.setViewName("/log/mylogDetail");
		return mv;
	}
	
	/* 멍멍피드 --------------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/log/feed", method = RequestMethod.GET)
	public ModelAndView logFeedGet(ModelAndView mv) {
		ArrayList<MemberVO> memberList = memberService.getMemberList();
		
		mv.addObject("memberList", memberList);
		mv.setViewName("/log/feed");
		return mv;
	}
	
	/* 멍멍피드 상세보기 -------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/log/feedDetail", method = RequestMethod.GET)
	public ModelAndView logFeedDetailGet(ModelAndView mv, int lg_num, Criteria cri) {
		ArrayList<MemberVO> memberList = memberService.getMemberList();
		//일지 전체 개수 가져오기
		int totalCount = logService.getLogTotalCount(cri);
		//criteria 재설정
		cri.setPage(1);
		cri.setPerPageNum(totalCount);
		//일지들 가져오기
		ArrayList<LogVO> logList = logService.getLogList(cri);
		//인덱스 찾기
		int index = logService.findIndex(logList, lg_num);
		
		mv.addObject("memberList", memberList);
		mv.addObject("index", index);
		mv.addObject("logList", logList);
		mv.setViewName("/log/feedDetail");
		return mv;
	}
	
	/* 멍멍친구의 일지 ---------------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/log/friendlog/{mb_num}", method = RequestMethod.GET)
	public ModelAndView logFriendlogGet(ModelAndView mv, @PathVariable("mb_num")int mb_num,
			HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//본인 멍멍친구 일지에 들어가면 본인 일지로
		if(user != null && (user.getMb_num() == mb_num))
			mv.setViewName("redirect:/log/mylog/"+mb_num);
		MemberVO member = memberService.getMemberByMbnum(mb_num);
		//강아지 정보 가져오기
		ArrayList<DogVO> dList = logService.getDogs(member);
		//사진이 등록된 년도 가져오기
		ArrayList<String> regYearList = logService.getRegYearList(member);
		
		mv.addObject("member", member);
		mv.addObject("regYearList", regYearList);
		mv.addObject("dList", dList);
		mv.setViewName("/log/friendLog");
		return mv;
	}
	
	/* 멍멍친구 일지 상세보기 -------------------------------------------------------------------------------------------------------*/
	@RequestMapping(value = "/log/friendlogDetail/{mb_num}", method = RequestMethod.GET)
	public ModelAndView logfriendlogDetailGet(ModelAndView mv, @PathVariable("mb_num")int mb_num,
			int lg_num, Criteria cri, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//본인 멍멍친구 일지 상세보기에 들어가면 본인 일지 상세보기로로
		if(user != null && (user.getMb_num() == mb_num)) {
			String url = mb_num + "?lg_num="+lg_num+"&mb_num="+mb_num;
			mv.setViewName("redirect:/log/mylogDetail/"+url);
		}
		//일지 전체 개수 가져오기
		int totalCount = logService.getLogTotalCount(cri);
		//criteria 재설정
		cri.setPage(1);
		cri.setPerPageNum(totalCount);
		//회원정보 가져옴
		MemberVO member = memberService.getMemberByMbnum(mb_num);
		//일지들 가져오기
		ArrayList<LogVO> logList = logService.getLogList(cri);
		//인덱스 찾기
		int index = logService.findIndex(logList, lg_num);
		
		mv.addObject("member", member);
		mv.addObject("index", index);
		mv.addObject("logList", logList);
		mv.setViewName("/log/friendLogDetail");
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
	
	/* 일지 리스트 가져오기 --------------------------------------------------------------------------------------------------------- */
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
	public Map<Object, Object> getSubjectList(@RequestBody LogVO log, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");	
		ArrayList<SubjectVO> subjectList = logService.getSubjectList(log, user);

		map.put("subjectList", subjectList);
		return map;
	}
	
	/* 일지에 사진 수정 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/modify/log", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> modifyLog(@RequestParam(value="file",required=false) MultipartFile file,
			@RequestParam("m_dg_nums[]") ArrayList<Integer> m_dg_nums, @RequestParam("d_dg_nums[]") ArrayList<Integer> d_dg_nums, 
			LogVO log, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		int res = logService.modifyLog(m_dg_nums, d_dg_nums, file, log, user);
		map.put("res", res);
		return map;
	}
	
	/* 일지 삭제 ----------------------------------------------------------------------------------------------------- */
	@RequestMapping(value = "/delete/log", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> deleteLog(@RequestBody LogVO log, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");	
		boolean res = logService.deleteLog(log, user);

		map.put("res", res);
		return map;
	}
	
	/* 강아지 리스트 가져오기 --------------------------------------------------------------------------------------------------------- */
	@RequestMapping(value = "/get/dogList", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getDogList(@RequestBody MemberVO member) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		ArrayList<DogVO> dogList = logService.getDogs(member);
	
		map.put("dogList", dogList);
		return map;
	}
	
	/* 일지 조회수 가져오기 --------------------------------------------------------------------------------------------------------- */
	@RequestMapping(value = "/count/views", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> countViews(@RequestBody LogVO log) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		boolean res = logService.countViews(log);
	
		map.put("res", res);
		return map;
	}
	
	/* 프로필 가져오기 --------------------------------------------------------------------------------------------------------- */
	@RequestMapping(value = "/get/profile", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getProfile(@RequestBody LogVO log) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO profile = memberService.getMemberByMbnum(log.getLg_mb_num());
	
		map.put("profile", profile);
		return map;
	}
	
	/* 하트 클릭 --------------------------------------------------------------------------------------------------------- */
	@RequestMapping(value = "/click/heart", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> clickHeart(@RequestBody HeartVO heart, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");	
		int res = logService.getHeartState(heart, user);
		
		map.put("res", res);
		return map;
	}
	
	/* 하트 가져오기 --------------------------------------------------------------------------------------------------------- */
	@RequestMapping(value = "/get/heart", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getHeart(@RequestBody HeartVO heart, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");	
		HeartVO dbHeart= logService.getHeart(heart, user);
		
		map.put("heart", dbHeart);
		return map;
	}
	
	/* 하트 개수 가져오기 --------------------------------------------------------------------------------------------------------- */
	@RequestMapping(value = "/get/totalHeart", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getTotalHeart(@RequestBody LogVO log) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		LogVO dbLog= logService.getLog(log);
		
		map.put("log", dbLog);
		return map;
	}
	
	/* 친구 맺기/삭제 --------------------------------------------------------------------------------------------------------- */
	@RequestMapping(value = "/make/friend", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> makeFriend(@RequestBody FriendVO friend, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");	
		int res = logService.makeFriend(friend, user);
		
		map.put("res", res);
		return map;
	}
	
	/* 친구 정보 가져오기 --------------------------------------------------------------------------------------------------------- */
	@RequestMapping(value = "/get/friend", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getFriend(@RequestBody FriendVO friend, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");	
		FriendVO dbFriend = logService.getFriend(friend, user);
		
		map.put("friend", dbFriend);
		return map;
	}
	
	/* 친구 정보 가져오기 --------------------------------------------------------------------------------------------------------- */
	@RequestMapping(value = "/get/friendList", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getFriend(@RequestBody FriendVO friend) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		ArrayList<MemberVO> friendList = logService.getFriendList(friend);
		
		map.put("friendList", friendList);
		return map;
	}
}
