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

import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.pagination.PageMaker;
import kr.inyo.munglog.service.AdminService;
import kr.inyo.munglog.service.MessageService;
import kr.inyo.munglog.vo.ChallengeVO;
import kr.inyo.munglog.vo.MemberVO;

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
	
	/* 챌린지 ---------------------------------------------------------------*/
	@RequestMapping(value = "/admin/challenge", method = RequestMethod.GET)
	public ModelAndView adminChallangeGet(ModelAndView mv, HttpSession session,
			HttpServletResponse response) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		//로그인 안했거나
		if(user == null)
			messageService.message(response, "접근할 수 없습니다.", "/munglog/account/login");
		//회원번호가 다르면 접근 할 수 없음
		if(!user.getMb_level().equals("A") && !user.getMb_level().equals("S"))
			messageService.message(response, "접근할 수 없습니다.", "/munglog/");
		mv.setViewName("/admin/challenge");
		return mv;
	}
	
	/* 굿즈 ---------------------------------------------------------------*/
	@RequestMapping(value = "/admin/goods", method = RequestMethod.GET)
	public ModelAndView adminGoodsGet(ModelAndView mv, HttpSession session,
			HttpServletResponse response) {
		mv.setViewName("/admin/goods");
		return mv;
	}
	
	/* 굿즈 등록 ---------------------------------------------------------------*/
	@RequestMapping(value = "/admin/registerGoods", method = RequestMethod.GET)
	public ModelAndView adminRegisterGoodsGet(ModelAndView mv, HttpSession session,
			HttpServletResponse response) {
		mv.setViewName("/admin/registerGoods");
		return mv;
	}
	
/* ajax **************************************************************************************************************** */
	/* 챌린지 등록 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/register/challenge", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> registerChallenge(@RequestParam("file") MultipartFile file, 
			@RequestParam("cl_year") String cl_year, @RequestParam("cl_month") String cl_month,
			@RequestParam("cl_theme") String cl_theme, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		ChallengeVO challenge = new ChallengeVO(cl_year, cl_month, cl_theme);
		boolean res = adminService.registerChallenge(file, challenge, user);
		
		map.put("res", res);
		return map;
	}
	
	/* 챌린지 리스트 가져오기 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/get/challengeList", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> getChallengeList(@RequestBody Criteria cri) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		ArrayList<ChallengeVO> challengeList = adminService.getChallengeList(cri);
		int totalCount = adminService.getChallengeTotalCount();
		PageMaker pm = new PageMaker(totalCount, 5, cri);
		
		map.put("pm",pm);
		map.put("challengeList", challengeList);
		return map;
	}
	
	/* 챌린지 수정 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/modify/challenge", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> modifyChallenge(@RequestParam(value="file",required=false) MultipartFile file, 
			@RequestParam("cl_num") int cl_num, @RequestParam("cl_year") String cl_year, @RequestParam("cl_month") String cl_month,
			@RequestParam("oriYear") String oriYear, @RequestParam("oriMonth") String oriMonth,
			@RequestParam("cl_theme") String cl_theme, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		ChallengeVO challenge = new ChallengeVO(cl_num, cl_year, cl_month, cl_theme);
		boolean res = adminService.modifyChallenge(file, challenge, user, oriYear, oriMonth);
		
		map.put("res", res);
		return map;
	}
	
	/* 챌린지 삭제 ------------------------------------------------------------------------------------------------------ */
	@RequestMapping(value = "/delete/challenge", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> deleteChallenge(@RequestBody ChallengeVO challenge, HttpSession session) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		System.out.println(challenge);
		MemberVO user = (MemberVO)session.getAttribute("user");
		int res = adminService.deleteChallenge(challenge, user);
		
		map.put("res", res);
		return map;
	}
}
