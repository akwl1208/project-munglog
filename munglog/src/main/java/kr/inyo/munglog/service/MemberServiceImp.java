package kr.inyo.munglog.service;

import java.util.ArrayList;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.inyo.munglog.dao.MemberDAO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.VerificationVO;

@Service
public class MemberServiceImp implements MemberService {

	@Autowired
	MemberDAO memberDao;
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
/* 함수********************************************************************************************************************* */
	//이메일 보내기-----------------------------------------------------------------------------------------------------------
	public boolean sendEmail(String title, String content, String receiver) {
		try {
		  MimeMessage message = mailSender.createMimeMessage();
		  MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
			messageHelper.setFrom("chldkwl");
			messageHelper.setTo(receiver);
			messageHelper.setSubject(title);
			messageHelper.setText(content, true);
		
	    mailSender.send(message);
		} catch(Exception e){
	    e.getStackTrace();
	    return false;
		}
		return true;
	}
	//영문대소문자, 숫자를 조합한 랜덤한 문자 만들기---------------------------------------------------------------------------------------
	private String createRandom() {
		String pattern = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String randomStr = "";
		for(int i = 0; i < 8; i++){
			int index = (int)(Math.random() * (pattern.length()));
			randomStr += pattern.charAt(index);
		}
		return randomStr;
	}
	
/* overide 메소드 *********************************************************************************************************** */
	/* isMember : 이메일을 주고 DB에 회원 정보가 있는지 확인 ------------------------------------------------------------------------*/
	@Override
	public boolean isMember(MemberVO member) {
		//member가 null이면  
		if(member == null)
			return false;
		//email이 null이거나 email 길이가 0이면 
		if(member.getMb_email() == null || member.getMb_email().length() == 0)
			return false;
		//이메일 정보로 회원 정보 가져옴 
		MemberVO dbMember = memberDao.selectMember(member.getMb_email());
		//DB에 있으면 false 
		if(dbMember != null)
			return false;
		//DB에 없으면 true 
		return true;
	}
	
	/* sendEmail : 회원에게 이메일을 보냄 ---------------------------------------------------------------------------------------*/
	@Override
	public boolean sendVeriCode(MemberVO member) {
		//member가 null이면
		if(member == null)
			return false;
		//email이 null이거나 email 길이가 0이면 
		if(member.getMb_email() == null || member.getMb_email().length() == 0)
			return false;
		//이미 가입된 회원이면(혹시 몰라서 추가) 
		if(!isMember(member))
			return false;
		//본인인증코드 생성
		String veriCode = createRandom();
		//본인인증코드 메일로 보내기
		//본인인증 재전송때문에 본인인증번호 저장한 값이 있는지 확인
		VerificationVO veri = memberDao.selectVerification(member.getMb_email());
		//코드가 저장되어 있으면 코드 수정
		if(veri != null) {
			//본인인증 재설정
			veri.setVr_code(veriCode);
			//실패횟수가 5번 초과이면 재전송하니까 실패횟수 0으로 초기화
			if(veri.getVr_failure_count() > 5)
				veri.setVr_failure_count(0);
			memberDao.updateVerifiCation(veri);
		}
		// 저장되어 있지 않으면 이메일과 인증코드 db에 추가
		else {
			//db에 저장 안됬으면 메일 안보냄
			if(!memberDao.insertVeriCode(member.getMb_email(),veriCode))
				return false;
		}
		//메일로 인증코드를 보내줌
		String title = "[멍멍일지]본인인증코드 전송";
		String content = "회원가입에서 본인인증코드 입력란에 다음 인증코드를 입력하여 회원가입을 완료하세요<br>"+ veriCode;
		if(!sendEmail(title, content, member.getMb_email()))
			return false;
		return true;
	}
	
	/* deleteVerification : 회원 메일을 주고 본인인증 삭제 -------------------------------------------------------------------------*/
	@Override
	public boolean deleteVerification(MemberVO member) {
		//member가 null이면
		if(member == null)
			return false;
		//email이 null이거나 email 길이가 0이면 
		if(member.getMb_email() == null || member.getMb_email().length() == 0)
			return false;
		return memberDao.deleteVerification(member.getMb_email());
	}
	
	/* checkCode : 인증코드를 잘 작성했는지 확인 ----------------------------------------------------------------------------------*/
	@Override
	public boolean checkCode(VerificationVO veri) {
		//veri가 null이면
		if(veri == null)
			return false;
		//email이 null이거나 email 길이가 0이면 
		if(veri.getVr_email() == null || veri.getVr_email().length() == 0)
			return false;
		//DB에 저장된 본인인증 정보를 가져옴
		VerificationVO dbVeri = memberDao.selectVerification(veri.getVr_email());
		//DB에서 가져온 값이 null이면
		if(dbVeri == null)
			return false;	
		//DB에 저장된 실패횟수가 5번이 넘은 경우
		if(dbVeri.getVr_failure_count() > 5)
			return false;
		//DB에 저장된 인증코드와 입력한 인증코드와 같으면 
		if(!dbVeri.getVr_code().equals(veri.getVr_code())) {
			return false;
		}
		return true;
	}
	
	/* countFailure : 실패횟수 증가 -------------------------------------------------------------------------------------------*/
	@Override
	public void countFailure(VerificationVO veri) {
		//veri가 null이면
		if(veri == null)
			return;
		//email이 null이거나 email 길이가 0이면 
		if(veri.getVr_email() == null || veri.getVr_email().length() == 0)
			return;
		//DB에 저장된 본인인증 정보를 가져옴
		VerificationVO dbVeri = memberDao.selectVerification(veri.getVr_email());
		//DB에서 가져온 값이 null이면
		if(dbVeri == null)
			return;
		//실패횟수에서 1증가
		veri.setVr_code(dbVeri.getVr_code());
		veri.setVr_failure_count(dbVeri.getVr_failure_count()+1);
		//DB에 실패횟수 수정
		memberDao.updateVerifiCation(veri);
	}
	
	/* getFailureCount : 실패횟수 가져옴 --------------------------------------------------------------------------------------*/
	@Override
	public int getFailureCount(VerificationVO veri) {
		//veri가 null이면
		if(veri == null)
			return -1;
		//email이 null이거나 email 길이가 0이면 
		if(veri.getVr_email() == null || veri.getVr_email().length() == 0)
			return -1;
		//DB에 저장된 본인인증 정보를 가져옴
		VerificationVO dbVeri = memberDao.selectVerification(veri.getVr_email());
		//DB에서 가져온 값이 null이면
		if(dbVeri == null)
			return -1;	
		return dbVeri.getVr_failure_count();
	}
	
	/* signup : 회원정보를 DB에 추가 ------------------------------------------------------------------------------------------*/
	@Override
	public int signup(MemberVO member) {
		//member가 null이면
		if(member == null)
			return -1;	
		//필수항목중 하나라도 값이 없으면
		if(member.getMb_email() == null || member.getMb_email().length() == 0)
			return -1;
		if(member.getMb_pw() == null || member.getMb_pw().length() == 0)
			return -1;
		if(member.getMb_name() == null || member.getMb_name().length() == 0)
			return -1;
		if(member.getMb_phone() == null || member.getMb_phone().length() == 0)
			return -1;
		//이름과 핸드폰번호가 모두 동일한 회원이 있으면 안됨 -> 아이디 찾기
		MemberVO isMember = memberDao.selectSameMember(member.getMb_name(),member.getMb_phone());
		if(isMember != null)
			return 0;
		//이미 가입된 아이디면
		MemberVO dbMember = memberDao.selectMember(member.getMb_email());
		if(dbMember != null)
			return 0;
		//비밀번호 암호화
		String encPw =passwordEncoder.encode(member.getMb_pw()); 
		member.setMb_pw(encPw);
		//회원가입
		memberDao.insertMember(member);
		//닉네임 설정
		dbMember = memberDao.selectMember(member.getMb_email());
		String profile = "/profile.png";
		String nickname = "MUNG" + dbMember.getMb_num();
		String greeting = "만나서 반갑습니다. " + nickname + "님 일지입니다.";
		dbMember.setMb_profile(profile);
		dbMember.setMb_nickname(nickname);
		dbMember.setMb_greeting(greeting);
		memberDao.updateProfile(dbMember);
		//본인인증 정보 삭제
		memberDao.deleteVerification(dbMember.getMb_email());
		//포인트 지급
		memberDao.insertPoint(dbMember.getMb_num(),"적립","회원가입",300);
		return 1;
	}
	
	/* login : 이메일과 비밀번호가 일치하면 로그인 ----------------------------------------------------------------------------------*/
	@Override
	public boolean login(MemberVO member) {
		//값이 없으면
		if(member == null)
			return false;
		if(member.getMb_email() == null || member.getMb_email().length() == 0)
			return false;
		if(member.getMb_pw() == null || member.getMb_pw().length() == 0)
			return false;
		//회원정보 가져오기
		MemberVO dbMember = memberDao.selectMember(member.getMb_email());
		//회원정보가 없으면
		if(dbMember == null)
			return false;
		//활동정지된 회원이면
		if(dbMember.getMb_activity().equals("1"))
			return false;
		//비번이 일치하는지 확인
		if(!passwordEncoder.matches(member.getMb_pw(), dbMember.getMb_pw()))
			return false;
		return true;
	}
	
	/* getMember : 회원정보 가져옴 --------------------------------------------------------------------------------------------*/
	@Override
	public MemberVO getMember(MemberVO member) {
		//값이 없으면
		if(member == null)
			return null;
		if(member.getMb_email() == null || member.getMb_email().length() == 0)
			return null;
		//회원정보 가져오기
		MemberVO dbMember = memberDao.selectMember(member.getMb_email());
		if(dbMember == null)
			return null;
		//아이디 저장 -> 회원가입
		dbMember.setSaveId(member.isSaveId());
		return dbMember;
	}
	
	/* updateSession : 회원의 세션 정보 수정 ------------------------------------------------------------------------------------*/
	@Override
	public void updateSession(MemberVO user) {
		//값이 없으면
		if(user == null)
			return;
		if(user.getMb_email() == null || user.getMb_email().length() == 0)
			return;
		//세션 정보 수정
		memberDao.updateSession(user);
	}
	
	/* getEmail : 세션아이디로 이메일 정보 가져오기 ---------------------------------------------------------------------------------*/
	@Override
	public String getEmail(MemberVO member) {
		//값이 없으면
		if(member == null)
			return "";
		if(member.getMb_session_id() == null || member.getMb_session_id().length() == 0)
			return "";
		//이메일 정보 가져오기
		String email = memberDao.selectMemberEmail(member.getMb_session_id());
		if(email == null)
			return "";
		return email;
	}
	
	/* findEmail : 이름과 전화번호로 이메일 정보 가져오기(아이디 찾기) ------------------------------------------------------------------*/
	@Override
	public String findEmail(MemberVO member) {
		//값이 없으면
		if(member == null)
			return null;
		if(member.getMb_name() == null || member.getMb_name().length() == 0)
			return null;
		if(member.getMb_phone() == null || member.getMb_phone().length() == 0)
			return null;
		//회원정보 가져오기
		MemberVO dbMember = memberDao.selectSameMember(member.getMb_name(),member.getMb_phone());
		if(dbMember == null)
			return null;
		return dbMember.getMb_email();
	}
	
	/* findPw : 비밀번호 재설정하기(비밀번호 찾기)  ---------------------------------------------------------------------------------*/
	@Override
	public int findPw(MemberVO member) {
		//값이 없으면
		if(member == null)
			return -1;
		if(member.getMb_email() == null || member.getMb_email().length() == 0)
			return -1;
		if(member.getMb_name() == null || member.getMb_name().length() == 0)
			return -1;
		if(member.getMb_phone() == null || member.getMb_phone().length() == 0)
			return -1;
		//이메일로 회원인지 판별
		MemberVO isMember = memberDao.selectMember(member.getMb_email());
		if(isMember == null)
			return -1;
		//이름과 핸드폰 번호로 회원인지 판별
		MemberVO dbMember = memberDao.selectSameMember(member.getMb_name(),member.getMb_phone());
		if(dbMember == null)
			return -1;
		//입력한 이메일과 이름과 핸드폰 번호로 가져온 이메일이 일치해야함
		if(!member.getMb_email().equals(dbMember.getMb_email()))
			return -1;
		//비밀번호 재설정
		//임시비밀번호 생성
		String mb_pw = createRandom();
		//임시비밀번호 암호화
		String encPw =passwordEncoder.encode(mb_pw); 
		dbMember.setMb_pw(encPw);
		//메일로 임시비밀번호를 보내줌
		String title = "[멍멍일지]임시비밀번호 전송";
		String content = "임시비밀번호가 발급되었습니다. 임시비밀번호로 로그인해주세요.<br>"+ mb_pw;
		//이메일 못보내지면 설정 못함
		if(!sendEmail(title, content, dbMember.getMb_email()))
			return 0;
		//회원 비밀번호 재설정
		memberDao.updateMember(dbMember);
		return 1;
	}
	
	/* getMemberList : 회원 정보들 가져오기  -----------------------------------------------------------------------------------*/
	@Override
	public ArrayList<MemberVO> getMemberList() {
		return memberDao.getMemberList();
	}
	
	/* getMemberByMbnum : 회원번호로 회원 정보 가져오기 ---------------------------------------------------------------------------*/
	@Override
	public MemberVO getMemberByMbnum(int mb_num) {
		if(mb_num < 1)
			return null;
		return memberDao.selectMemberByMbnum(mb_num);
	}
}
