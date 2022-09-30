package kr.inyo.munglog.service;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.dao.LogDAO;
import kr.inyo.munglog.dao.MemberDAO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.utils.MediaUtils;
import kr.inyo.munglog.utils.UploadFileUtils;
import kr.inyo.munglog.vo.ChallengeVO;
import kr.inyo.munglog.vo.DogListVO;
import kr.inyo.munglog.vo.DogVO;
import kr.inyo.munglog.vo.FriendVO;
import kr.inyo.munglog.vo.HeartVO;
import kr.inyo.munglog.vo.LogVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.ParticipateVO;
import kr.inyo.munglog.vo.SubjectVO;

@Service
public class LogServiceImp implements LogService {

	@Autowired
	LogDAO logDao;
	@Autowired
	MemberDAO memberDao;
	
	String logUploadPath = "D:\\git\\munglog\\log";
	//이번년도와 월 가져오기
	Date today = new Date();
	String thisYear = String.format("%tY", today);
	String thisMonth = String.format("%tm", today);

/* 함수********************************************************************************************************************* */
	// 이미지 파일인지 확인 ----------------------------------------------------------------------------
	public boolean isImg(MultipartFile file) {
		String originalName = file.getOriginalFilename();
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		if(MediaUtils.getMediaType(formatName) == null)
			return false;
		return true;
	}
	
	// 파일 없로드 ----------------------------------------------------------------------------
	public String uploadFile(MultipartFile file, int mb_num) {
		String lg_image = "";
		try {
			lg_image = UploadFileUtils.uploadFileDir(logUploadPath, String.valueOf(mb_num), file.getOriginalFilename(), file.getBytes());
		}catch (Exception e) {
			e.printStackTrace();
		}
		return lg_image;
	}
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
		if(user == null || dlist == null || user.getMb_num() < 1)
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
		if(file == null || user == null || user.getMb_num() < 1)
			return -1;
		//포인트 적립을 위해 오늘 적립한 로그 가져옴
		ArrayList<LogVO> dbLogList = logDao.selectTodayLogListByMbNum(user.getMb_num());
		//이미지 파일인지 확인
		if(!isImg(file))
			return 0;
		//파일업로드
		String lg_image = uploadFile(file, user.getMb_num());
		if(lg_image == "")
			return -1;
		//일지 등록
		logDao.insertLog(user.getMb_num(), lg_image);
		//회원 정보로 로그 정보 가져옴
		LogVO dbLog = logDao.selectLogByImg(user.getMb_num(), lg_image);
		if(dbLog == null)
			return -1;
		//피사체가 있으면
		if(dg_nums != null) {
			for(int i = 0; i < dg_nums.size(); i++) {
				//dg_num이 1보다 작으면
				if(dg_nums.get(i) < 1)
					continue;
				//피사체 추가
				logDao.insertSubject(dbLog.getLg_num(), dg_nums.get(i));
			}
		}
		//매일 처음 등록한 사진에 포인트적립
		if(dbLogList.isEmpty()) {
			//포인트 지급
			memberDao.insertPoint(user.getMb_num(),"적립","일지 사진 등록",100);
		}
		return 1;
	}

	/* getLogList : 일지들 가져오기 ----------------------------------------------------------------------------------------------*/
	@Override
	public ArrayList<LogVO> getLogList(Criteria cri) {
		//값이 없으면
		if(cri == null)
			return null;
		//회원번호 주고 로그 가져오기
		return logDao.selectLogList(cri);
	}

	/* getLogTotalCount : 회원의 일지 개수 가져오기 ---------------------------------------------------------------------------------*/
	@Override
	public int getLogTotalCount(Criteria cri) {
		//값이 없으면
		if(cri == null)
			return 0;
		return logDao.selectLogTotalCount(cri);
	}
	
	/* getRegYearList : 일지가 등록된 년도들 가져오기 --------------------------------------------------------------------------------*/
	@Override
	public ArrayList<String> getRegYearList(MemberVO user) {
		if(user == null || user.getMb_num() < 1)
			return null;
		return logDao.selectRegYearList(user.getMb_num());
	}
	
	/* getSubjectList: 일지의 피사체들 가져오기 --------------------------------------------------------------------------------*/
	@Override
	public ArrayList<SubjectVO> getSubjectList(LogVO log, MemberVO user) {
		//값이 없으면
		if(user == null || user.getMb_num() < 1)
			return null;
		if(log == null || log.getLg_num() < 1)
			return null;
		//로그 정보 가져오기
		LogVO dbLog = logDao.selectLog(log.getLg_num());
		if(dbLog == null)
			return null;
		//회원이 등록한 일지가 아니면
		if(dbLog.getLg_mb_num() != user.getMb_num())
			return null;
		//피사체들 가져오기
		return logDao.selectSubjectList(log.getLg_num());	
	}
	
	/* modifyLog: 일지 수정하기 ----------------------------------------------------------------------------------------------*/
	@Override
	public int modifyLog(ArrayList<Integer> m_dg_nums, ArrayList<Integer> d_dg_nums, MultipartFile file, LogVO log, MemberVO user) {
		//값이 없으면
		if(user == null || user.getMb_num() < 1)
			return -1;
		if(log == null || log.getLg_num() < 1)
			return -1;
		//일지 가져오기
		LogVO dbLog = logDao.selectLog(log.getLg_num());
		if(dbLog == null)
			return -1;
		//회원이 등록한 일지가 아니면
		if(dbLog.getLg_mb_num() != user.getMb_num())
			return -1;
		//피사체도 수정안하고 파일도 수정 안한 경우
		if(m_dg_nums.equals(d_dg_nums) && file == null)
			return 2;
		//지난 챌린지에 참여한 일지를 수정하려고 하면
		ParticipateVO participate = logDao.selectParticipateByLgNum(dbLog.getLg_num());
		ChallengeVO challenge = logDao.selectChallengeByDate(thisYear, thisMonth);
		if(participate != null && participate.getPt_cl_num() != challenge.getCl_num())
			return 3;
		//피사체 수정	-----------------------------------------------------
		if(!m_dg_nums.equals(d_dg_nums)) {
			//기존 피사체 삭제
			for(int i = 0; i < d_dg_nums.size(); i++) {
				//dg_num이 1보다 작으면
				if(d_dg_nums.get(i) < 1)
					continue;
				//피사체 삭제
				logDao.deleteSubject(dbLog.getLg_num());
			}
			//새로운 피사체 추가
			for(int i = 0; i < m_dg_nums.size(); i++) {
				//dg_num이 1보다 작으면
				if(m_dg_nums.get(i) < 1)
					continue;
				//피사체 추가
				logDao.insertSubject(dbLog.getLg_num(), m_dg_nums.get(i));
			}
		}
		//사진 수정 ---------------------------------------------------------
		if(file != null) {
			//이미지 파일인지 확인
			if(!isImg(file))
				return 0;
			//기존 파일 삭제
			UploadFileUtils.deleteFile(logUploadPath, dbLog.getLg_image());
			//새로운 파일업로드
			String lg_image = uploadFile(file, user.getMb_num());
			if(lg_image == "")
				return -1;
			//이미지 수정
			dbLog.setLg_image(lg_image);
			logDao.updateLog(dbLog);
		}
		return 1;
	}
	
	/* findIndex: 일지번호로 슬라이드 인덱스 찾기 -----------------------------------------------------------------------------------*/
	@Override
	public int findIndex(ArrayList<LogVO> logList, int lg_num) {
		//값 없으면
		if(logList.isEmpty() || lg_num < 1)
			return 0;
		LogVO tmpLog = new LogVO();
		for(LogVO log : logList) {
			if(log.getLg_num() == lg_num) {
				tmpLog = log;
				break;				
			}
		}
		return logList.indexOf(tmpLog);
	}

	/* deleteLog: 일지 삭제 --------------------------------------------------------------------------------------------------*/
	@Override
	public int deleteLog(LogVO log, MemberVO user) {
		//값이 없으면
		if(user == null || user.getMb_num() < 1)
			return -1;
		if(log == null || log.getLg_num() < 1)
			return -1;
		//로그 정보 가져오기
		LogVO dbLog = logDao.selectLog(log.getLg_num());
		if(dbLog == null)
			return -1;
		//일지를 올린 회원이 삭제한 경우가 아님
		if(dbLog.getLg_mb_num() != user.getMb_num())
			return -1;
		//챌린지에 참여한 일지는 삭제 못함
		ParticipateVO dbParticipate = logDao.selectParticipateByLgNum(log.getLg_num());
		if(dbParticipate != null)
			return 0;
		//일지 삭제하기
		dbLog.setLg_del("1");
		logDao.updateLog(dbLog);
		//기존 파일 삭제
		UploadFileUtils.deleteFile(logUploadPath, dbLog.getLg_image());
		//피사체 삭제하기
		logDao.deleteSubject(dbLog.getLg_num());
		return 1;
	}

	/* countViews: 조회수 증가 --------------------------------------------------------------------------------------------------*/
	@Override
	public boolean countViews(LogVO log) {
		//값이 없는 경우
		if(log == null || log.getLg_num() < 1)
			return false;
		//일지 가져오기
		LogVO dbLog = logDao.selectLog(log.getLg_num());
		if(dbLog == null)
			return false;
		//삭제되거나 신고당한 일지
		if(dbLog.getLg_del().equals("1") || dbLog.getLg_report().equals("1"))
			return false;
		//조회수 1 증가
		dbLog.setLg_views(dbLog.getLg_views() + 1);
		logDao.updateLog(dbLog);
		return true;
	}

	/* getHeartState: 하트 상태 반환 ------------------------------------------------------------------------------------------*/
	@Override
	public int getHeartState(HeartVO heart, MemberVO user) {
		//값이 없으면
		if(heart == null || user == null)
			return -1;
		//값으로 온 mb_num이랑 user가 다르면
		if(user.getMb_num() != heart.getHt_mb_num())
			heart.setHt_mb_num(user.getMb_num());
		//하트 상태 가져오기
		HeartVO dbHeart = logDao.selectHeart(heart);
		try {
			//클릭한 적 없으면 db에 추가
			if(dbHeart == null) {
				logDao.insertHeart(heart);
				//포인트 적립
				//오늘 누른 하트 수 가져오기
				int todayHeart = logDao.selectTodayHeart(user.getMb_num());
				//포인트 지급은 하루에 최대 10번만 가능
				if(todayHeart < 10)
					memberDao.insertPoint(user.getMb_num(),"적립","일지 하트누르기",10);					
				return 1;
			}
			//클릭한 적 있으면
			int res = -1;
			//하트를 누른거면 취소함
			if(dbHeart.getHt_state().equals("1")) {
				dbHeart.setHt_state("0");
				res = 0;
			}
			//하트를 취소했다가 다시 하트를 누른거면
			else if(dbHeart.getHt_state().equals("0")) {
				dbHeart.setHt_state("1");
				res = 1;
			}
			logDao.updateHeart(dbHeart);
			return res;
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			logDao.updateLogHeart(heart.getHt_lg_num());
		}
		return -1;
	}

	/* getHeart: 하트 가져오기 ------------------------------------------------------------------------------------------*/
	@Override
	public HeartVO getHeart(HeartVO heart, MemberVO user) {
		//값이 없으면
		if(user == null || heart == null)
			return null;
		//보낸 값과 회원이 다르면
		if(user.getMb_num() != heart.getHt_mb_num())
			heart.setHt_mb_num(user.getMb_num());;
		
		return logDao.selectHeart(heart);
	}

	/* getLog: 일지 가져오기 ------------------------------------------------------------------------------------------*/
	@Override
	public LogVO getLog(LogVO log) {
		//값이 없으면 
		if(log == null || log.getLg_num() < 1)
			return null;
		return logDao.selectLog(log.getLg_num());
	}

	/*makeFriend : 친구 추가 삭제 ------------------------------------------------------------------------------------------*/
	@Override
	public int makeFriend(FriendVO friend, MemberVO user) {
		//값이 없으면
		if(friend == null || user == null)
			return -1;
		if(friend.getFr_mb_num() < 1 || friend.getFr_friend() < 1 || user.getMb_num() < 1)
			return -1;
		//보낸 값과 회원이 다르면
		if(friend.getFr_mb_num() != user.getMb_num())
			friend.setFr_mb_num(user.getMb_num());
		//친구 정보 가져오기
		FriendVO dbFriend = logDao.selectFriend(friend);
		int res;
		//친구 정보가 없으면 친구 추가
		if(dbFriend == null) {
			logDao.insertFriend(friend);
			res = 1;
		}
		//친구 정보가 있으면 친구 삭제
		else {
			logDao.deleteFriend(dbFriend);
			res = 0;
		}
		return res;
	}

	/*getFriend : 친구 정보 가져오기 ------------------------------------------------------------------------------------------*/
	@Override
	public FriendVO getFriend(FriendVO friend, MemberVO user) {
		//값이 없으면
		if(friend == null || user == null)
			return null;
		if(friend.getFr_friend() < 1 || user.getMb_num() < 1)
			return null;
		//보낸 값과 회원이 다르면
		if(friend.getFr_mb_num() != user.getMb_num())
			friend.setFr_mb_num(user.getMb_num());
		//친구 정보 가져오기
		return logDao.selectFriend(friend);
	}

	/*getFriendList : 친구 리스트 가져오기 ------------------------------------------------------------------------------------------*/
	@Override
	public ArrayList<MemberVO> getFriendList(FriendVO friend) {
		//값이 없으면
		if(friend == null || friend.getFr_friend() < 1)
			return null;
		//친구 리스트 가져오기
		return logDao.selectFriendList(friend);
	}

	/*getChallenge : 챌린지 가져오기 ---------------------------------------------------------------------------------*/
	@Override
	public ChallengeVO getChallenge(String year, String month) {
		if(year == "" || month == "") {
			year = thisYear;
			month = thisMonth;
		}
		//챌린지 가져오기
		return logDao.selectChallengeByDate(year, month);
	}

	/*getPastChallengeList : 진행한 챌린지 가져오기 -------------------------------------------------------------------------------*/
	@Override
	public ArrayList<ChallengeVO> getPastChallengeList() {
		return logDao.selectPastChallengeList(thisYear, thisMonth);
	}

	/*participageChallenge : 챌린지 참여하기 -----------------------------------------------------------------------------------*/
	@Override
	public int participageChallenge(MultipartFile file, int cl_num, MemberVO user) {
		//값이 없으면
		if(user == null)
			return -2;
		if(file == null || file.getOriginalFilename().length() == 0 || user.getMb_num() < 1 || cl_num < 1)
			return -1;
		//등록된 챌린지인지 확인		
		ChallengeVO dbChallenge = logDao.selectChallenge(cl_num);
		if(dbChallenge == null)
			return -1;
		//진행 중인 챌린지가 아닌 경우
		if(!dbChallenge.getCl_year().equals(thisYear) || !dbChallenge.getCl_month().equals(thisMonth))
			return -1;
		//이미 참여한 챌린지인지 확인
		ParticipateVO dbParticipate = logDao.selectParticipate(cl_num, user.getMb_num());
		if(dbParticipate != null)
			return 0;
		//이미지 파일인지 확인
		if(!isImg(file))
			return 1;
		//파일업로드
		String lg_image = uploadFile(file, user.getMb_num());
		if(lg_image == "")
			return -1;
		//일지 등록
		logDao.insertLog(user.getMb_num(), lg_image);
		//회원 정보로 일지 정보 가져옴
		LogVO dbLog = logDao.selectLogByImg(user.getMb_num(), lg_image);
		if(dbLog == null)
			return -1;
		//챌린지 참여
		logDao.insertParticipate(cl_num, dbLog.getLg_num());
		//포인트 지급
		String pointHistory = dbChallenge.getCl_year() + "년" + dbChallenge.getCl_month() + "월 챌린지 참여";
		memberDao.insertPoint(user.getMb_num(),"적립",pointHistory,300);
		return 2;
	}

}
