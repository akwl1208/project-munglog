package kr.inyo.munglog.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.dao.AdminDAO;
import kr.inyo.munglog.utils.MediaUtils;
import kr.inyo.munglog.utils.UploadFileUtils;
import kr.inyo.munglog.vo.ChallengeVO;
import kr.inyo.munglog.vo.MemberVO;

@Service
public class AdminServiceImp implements AdminService {
	
	@Autowired
	AdminDAO adminDao;
	
	String challengeUploadPath = "D:\\git\\munglog\\challenge";
	
	/* registerChallenge : 챌린지 등록 -------------------------------------------------------------- */
	@Override
	public boolean registerChallenge(MultipartFile file, ChallengeVO challenge, MemberVO user) {
		//값이 없으면
		if(file == null || challenge == null || user == null)
			return false;
		if(file.getOriginalFilename().length() == 0 || file.getOriginalFilename() == "")
			return false;
		//관리자가 아니면
		if(!user.getMb_level().equals("A") && !user.getMb_level().equals("S"))
			return false;
		//이미지 파일인지 확인
		String originalName = file.getOriginalFilename();
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		if(MediaUtils.getMediaType(formatName) == null)
			return false;
		//오늘과 년과 달이 큰 경우에만 등록할 수 있다.
		Date today = new Date();
		String thisYear = String.format("%tY", today);
		String thisMonth = String.format("%tm", today);
		if((Integer.parseInt(challenge.getCl_year()) < Integer.parseInt(thisYear)) ||
				(Integer.parseInt(challenge.getCl_month()) < Integer.parseInt(thisMonth)))
			return false;
		//이미 등록한 년과 월은 중복 등록할 수 없다.
		ChallengeVO dbChallenge = adminDao.selectChallengeBydate(challenge);
		if(dbChallenge != null)
			return false;
		//파일업로드
		try {
			String prefix = challenge.getCl_year() + challenge.getCl_month(); //202209
			String cl_thumb = UploadFileUtils.uploadFilePrefix(challengeUploadPath, prefix, file.getOriginalFilename(), file.getBytes());
			challenge.setCl_thumb(cl_thumb);
		}catch (Exception e) {
			e.printStackTrace();
		}
		//챌린지 등록
		adminDao.insertChallenge(challenge);
		return true;
	}
}
