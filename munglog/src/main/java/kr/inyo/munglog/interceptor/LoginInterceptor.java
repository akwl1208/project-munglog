package kr.inyo.munglog.interceptor;

import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import kr.inyo.munglog.service.LogService;
import kr.inyo.munglog.service.MemberService;
import kr.inyo.munglog.vo.DogVO;
import kr.inyo.munglog.vo.MemberVO;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	MemberService memberService;
	@Autowired
	LogService logService;
	
	@Override
	public void postHandle(
    HttpServletRequest request, 
    HttpServletResponse response, 
    Object handler, 
    ModelAndView modelAndView)
    throws Exception {
    ModelMap modelMap = modelAndView.getModelMap();
    MemberVO user = (MemberVO)modelMap.get("user");

    if(user != null) {
	    HttpSession session = request.getSession();
	    session.setAttribute("user", user);
	    //강아지 정보 넘기기
	    ArrayList<DogVO> dogs = logService.getDogs(user);
	    session.setAttribute("dogs", dogs);
	    //아이디 저장 선택 -----------------------------------------------------------
	    if(user.isSaveId()) {
	    	//쿠키 생성
	    	Cookie cookie = new Cookie("saveId", session.getId());
	    	//만료일을 만료시간로 환산(7일)
	    	int expireTime = 60 * 60 * 24 * 7;
	    	//쿠키 설정
	    	cookie.setPath("/");
	    	cookie.setMaxAge(expireTime);
	    	response.addCookie(cookie);
	    	//user 설정
	    	Date expirDate = new Date(System.currentTimeMillis() + expireTime*1000);
	    	user.setMb_session_id(session.getId());
	    	user.setMb_session_expir(expirDate);
	    	//user에 세션 정보 저장
	    	memberService.updateSession(user);
	    }
	    //아이디 저장 선택 해제------------------------------------------------------------
	    else {
	    	//쿠키 가져오기
	  		Cookie cookie = WebUtils.getCookie(request, "saveId");
	  		//쿠키가 있으면
	  		if(cookie != null) {
	  			//쿠키 초기화
	  			cookie.setPath("/");
	  			cookie.setMaxAge(0);
	  			response.addCookie(cookie);
	  			//회원 세션 정보 초기화
	  			user.setMb_session_id(null);
	  			user.setMb_session_expir(null);
	  			memberService.updateSession(user);
	  		}
	    }
    }
	}
}
