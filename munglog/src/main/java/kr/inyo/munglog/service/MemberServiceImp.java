package kr.inyo.munglog.service;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
	
/* 함수*********************************************************************************************** */
	//이메일 보내기
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
		}
		return false;
	}
	//영문대소문자, 숫자를 조합한 랜덤한 문자 만들기
	private String createRandom() {
		String pattern = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String randomStr = "";
		for(int i = 0; i < 8; i++){
			int index = (int)(Math.random() * (pattern.length()));
			randomStr += pattern.charAt(index);
		}
		return randomStr;
	}
	
/* overide 메소드 ************************************************************************************ */
	/* isMember : 이메일을 주고 DB에 회원 정보가 있는지 확인 ------------------------------*/
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
	/* sendEmail : 회원에게 이메일을 보냄 ------------------------------*/
	@Override
	public boolean sendEmail(MemberVO member) {
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
		try {
			//본인인증 재전송때문에 본인인증번호 저장한 값이 있는지 확인
			VerificationVO veri = memberDao.hasVerification(member.getMb_email());
			//코드가 저장되어 있으면 코드 수정
			if(veri != null)
				memberDao.updateVerifiCation(veri);
			// 저장되어 있지 않으면 이메일과 인증코드 db에 추가
			else {
				//db에 저장 안됬으면 메일 안보냄
				if(!memberDao.insertVeriCode(member.getMb_email(),veriCode))
					return false;
			}
			//메일로 링크를 보내줌
			String title = "[멍멍일지]본인인증코드 전송";
			String content = "회원가입에서 본인인증코드 입력란에 다음 인증코드를 입력하여 회원가입을 완료하세요<br>"+ veriCode;
			sendEmail(title, content, member.getMb_email());
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	/* deleteVerification : 회원 메일을 주고 본인인증 삭제 ------------------------------*/
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

}
