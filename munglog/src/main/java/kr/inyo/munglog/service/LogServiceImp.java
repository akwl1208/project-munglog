package kr.inyo.munglog.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.dao.LogDAO;
import kr.inyo.munglog.utils.MediaUtils;
import kr.inyo.munglog.utils.UploadFileUtils;
import kr.inyo.munglog.vo.DogListVO;
import kr.inyo.munglog.vo.DogVO;
import kr.inyo.munglog.vo.LogVO;
import kr.inyo.munglog.vo.MemberVO;

@Service
public class LogServiceImp implements LogService {

	@Autowired
	LogDAO logDao;
	
	String logUploadPath = "D:\\git\\munglog\\log";

/* 함수********************************************************************************************************************* */
	//-----------------------------------------------------------------------------

/* overide 메소드 *********************************************************************************************************** */
	/*  getDogs : 회원의 강아지 정보 가져옴 ------------------------------------------------------------------------------------------*/
	@Override
	public ArrayList<DogVO> getDogs(MemberVO user) {
		//값이 없으면
		if(user == null)
			return null;
		if(user.getMb_num() < 1)
			return null;
		//강아지 정보 가져오기
		ArrayList<DogVO> dbDogs = logDao.selectDogs(user.getMb_num());
		if(dbDogs.isEmpty())
			return null;
		return dbDogs;
	}
	
	/* insertDog : 회원의 강아지 정보 추가 ------------------------------------------------------------------------------------------*/
	@Override
	public int insertDog(MemberVO user, DogListVO dlist) {
		//값이 없으면
		if(user == null || dlist == null)
			return -1;
		//강아지 정보 가져오기
		ArrayList<DogVO> dbDogs = logDao.selectDogs(user.getMb_num());
		//이미 강아지가 3마리 추가됬으면
		if(dbDogs.size() == 3)
			return 0;
		//최대 3마리 추가인데 이미 2마리 추가되어있는데 2마리를 추가한다고 하면?
		if(dlist.getDlist().size() > (3 - dbDogs.size()))
			return 0;
		//3개 초과하면
		if(dlist.getDlist().size() > 3)
			return 0;
		//강아지 정보 추가
		for(int i=0; i<dlist.getDlist().size();i++) {
			//강아지 정보 객체에 저장
			DogVO dog = dlist.getDlist().get(i);
			//값이 없으면
			if(dog == null)
				continue;
			//이름 없으면 
			if(dog.getDg_name() == null || dog.getDg_name().length() == 0)
				continue;
			//강아지 정보 추가
			logDao.insertDog(dog, user.getMb_num());
		}
		return 1;
	}
	
	/* uploadLog : 일지 추가 ----------------------------------------------------------------------------------------------------*/
	@Override
	public int uploadLog(ArrayList<Integer> dg_nums, MultipartFile file, MemberVO user) {
		//값이 없으면
		if(file == null || user == null)
			return -1;
		//이미지 파일인지 확인
		String originalName = file.getOriginalFilename();
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		if(MediaUtils.getMediaType(formatName) == null)
			return 0;
		//파일업로드
		String lg_image = "";
		try {
			lg_image = UploadFileUtils.uploadFileDir(logUploadPath, String.valueOf(user.getMb_num()), file.getOriginalFilename(), file.getBytes());
		}catch (Exception e) {
			e.printStackTrace();
		}
		//일지 등록
		logDao.insertLog(user.getMb_num(), lg_image);
		//피사체가 있으면
		if(dg_nums != null) {
			//회원 정보로 로그 정보 가져옴
			LogVO dbLog = logDao.selectLogByImg(user.getMb_num(), lg_image);
			for(int i = 0; i < dg_nums.size(); i++) {
				//dg_num이 0과 같거나 작을순 없음
				if(dg_nums.get(i) <= 0)
					continue;
				//피사체 추가
				logDao.insertSubject(dbLog.getLg_num(), dg_nums.get(i));
			}
		}
		return 1;
	}

}
