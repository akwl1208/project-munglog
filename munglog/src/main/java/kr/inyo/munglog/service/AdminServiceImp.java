package kr.inyo.munglog.service;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.dao.AdminDAO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.utils.MediaUtils;
import kr.inyo.munglog.utils.UploadFileUtils;
import kr.inyo.munglog.vo.CategoryVO;
import kr.inyo.munglog.vo.ChallengeVO;
import kr.inyo.munglog.vo.GoodsVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OptionListVO;
import kr.inyo.munglog.vo.OptionVO;

@Service
public class AdminServiceImp implements AdminService {
	
	@Autowired
	AdminDAO adminDao;
	
	String challengeUploadPath = "D:\\git\\munglog\\challenge";
	String goodsUploadPath = "D:\\git\\munglog\\goods";
	
	Date today = new Date();
	String thisYear = String.format("%tY", today);
	String thisMonth = String.format("%tm", today);
/* 함수***************************************************************************************************************** */
	//날짜 비교하기 -----------------------------------------------------------------------------------------------------------
	public boolean notPast(String cl_year, String cl_month) {
		if((Integer.parseInt(cl_year) < Integer.parseInt(thisYear)) || Integer.parseInt(cl_month) <= Integer.parseInt(thisMonth))
			return false;
		return true;
	}
	
	//1~12월 인지 -----------------------------------------------------------------------------------------------------------
	public boolean isMonth(String cl_month) {
		if(Integer.parseInt(cl_month) < 1 || Integer.parseInt(cl_month) > 12)
			return false;
		return true;
	}
	
	// 이미지 파일인지 확인 ----------------------------------------------------------------------------
	public boolean isImg(MultipartFile file) {
		String originalName = file.getOriginalFilename();
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		if(MediaUtils.getMediaType(formatName) == null)
			return false;
		return true;
	}
	
/* override ***************************************************************************************************************** */
	/* registerChallenge : 챌린지 등록 ----------------------------------------------------------------------------------------- */
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
		if(!isImg(file))
			return false;
		//1~12월인지
		if(!isMonth(challenge.getCl_month()))
			return false;
		//이번 년도 이번 달보다 작거나 같으면 등록할 수 없다.
		if(!notPast(challenge.getCl_year(), challenge.getCl_month()))
			return false;
		//이미 등록한 챌린지와 기간이 중복되게 등록할 수 없다.
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

	/* getChallengeList : 챌린지 리스트 가져오기 ----------------------------------------------------------------------------------- */
	@Override
	public ArrayList<ChallengeVO> getChallengeList(Criteria cri) {
		//크리가 안왔으면
		if(cri == null)
			cri = new Criteria();
		return adminDao.selectChallengeList(cri);
	}

	/* getChallengeTotalCount : 등록된 챌린지 총 개수 가져오기 --------------------------------------------------------------------- */
	@Override
	public int getChallengeTotalCount() {
		return adminDao.selectChallengeTotalCount();
	}

	/* modifyChallenge : 챌린지 수정 ----------------------------------------------------------------------------------------- */
	@Override
	public boolean modifyChallenge(MultipartFile file, ChallengeVO challenge, MemberVO user, String oriYear, String oriMonth) {
		//값이 없으면
		if(challenge == null || user == null)
			return false;
		if(challenge.getCl_num() < 1)
			return false;
		//관리자가 아니면
		if(!user.getMb_level().equals("A") && !user.getMb_level().equals("S"))
			return false;
		//1~12월인지
		if(!isMonth(challenge.getCl_month()))
			return false;
		//등록되지 않은 챌린지인 경우 현재보다 미래로 수정할 수 있다.
		ChallengeVO sameChallenge = adminDao.selectChallengeBydate(challenge);	
		if(sameChallenge == null && !notPast(challenge.getCl_year(), challenge.getCl_month()))
			return false;
		//진행중이지 않은 챌린지를 등록된 챌린지 기간으로 수정하는 경우
		if(sameChallenge != null && notPast(oriYear, oriMonth))
			return false;
		//챌린지 가져오기
		ChallengeVO dbChallenge = adminDao.selectChallenge(challenge.getCl_num());
		if(dbChallenge == null)
			return false;
		//사진을 수정하면
		if(file != null) {
			//이미지 파일인지 확인
			if(!isImg(file))
				return false;
			//기존 파일 삭제
			UploadFileUtils.deleteFile(challengeUploadPath, dbChallenge.getCl_thumb());
			//파일업로드
			try {
				String prefix = challenge.getCl_year() + challenge.getCl_month(); //202209
				String cl_thumb = UploadFileUtils.uploadFilePrefix(challengeUploadPath, prefix, file.getOriginalFilename(), file.getBytes());
				dbChallenge.setCl_thumb(cl_thumb);
			}catch (Exception e) {
				e.printStackTrace();
			}	
		}
		//챌린지 수정
		//이미 진행중이거나 잔행한 챌린지는 기간을 수정할 수 없다.
		if(notPast(oriYear, oriMonth)) {
			dbChallenge.setCl_year(challenge.getCl_year());
			dbChallenge.setCl_month(challenge.getCl_month());			
		}
		dbChallenge.setCl_theme(challenge.getCl_theme());
		adminDao.updateChallenge(dbChallenge);
		return true;
	}
	
	/* deleteChallenge : 챌린지 삭제 ----------------------------------------------------------------------------------------- */
	@Override
	public int deleteChallenge(ChallengeVO challenge, MemberVO user) {
		//값이 없으면
		if(challenge == null || user == null)
			return -1;
		if(challenge.getCl_num() < 1)
			return -1;
		//관리자가 아니면
		if(!user.getMb_level().equals("A") && !user.getMb_level().equals("S"))
			return -1;
		//챌린지 가져오기
		ChallengeVO dbChallenge = adminDao.selectChallenge(challenge.getCl_num());
		if(dbChallenge == null)
			return -1;
		//이미 진행중이거나 진행된 챌린지는 삭제할 수 없음
		if(!notPast(dbChallenge.getCl_year(), dbChallenge.getCl_month()))
			return 0;
		return adminDao.deleteChallenge(dbChallenge) ? 1 : -1;
	}

	/* getCategoryList : 카테고리 리스트 가져오기 ------------------------------------------------------------------------ */
	@Override
	public ArrayList<CategoryVO> getCategoryList() {
		return adminDao.selectCategoryList();
	}

	/* registerGoods : 굿즈 등록 ---------------------------------------------------------------------------------- */
	@Override
	public boolean registerGoods(GoodsVO goods, OptionListVO optionList, MultipartFile file, MemberVO user) {
		//값이 없으면
		if(user == null || user.getMb_num() < 1)
			return false;
		//관리자가 아니면
		if(!user.getMb_level().equals("A") && !user.getMb_level().equals("S"))
			return false;
		if(optionList == null || goods == null)
			return false;
		//이미 등록된 상품명이 있으면
	  GoodsVO dbGoods = adminDao.selectGoodsByName(goods);
	  if(dbGoods != null)
	  	return false;
		//썸네일 파일이 있으면
		if(file != null && file.getOriginalFilename() != "") {
			//이미지 파일인지 확인
			if(!isImg(file))
				return false;
			//파일업로드
			try {
				String prefix = goods.getGs_name();
				String gs_thumb = UploadFileUtils.uploadFilePrefix(goodsUploadPath+"\\thumb", prefix, file.getOriginalFilename(), file.getBytes());
				gs_thumb = "/thumb"+gs_thumb;
				goods.setGs_thumb(gs_thumb);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		//굿즈 등록
	  adminDao.insertGoods(goods);
	  //옵션 등록
	  //굿즈 번호 가져옴
	  dbGoods = adminDao.selectGoodsByName(goods);
	  if(dbGoods == null)
	  	return false;
		//옵션 추가
		for(int i=0; i<optionList.getOptionList().size();i++) {
			//옵션 객체에 저장
			OptionVO option = optionList.getOptionList().get(i);
			//값이 없으면
			if(option == null)
				continue;
			//이름 없으면 
			if(option.getOt_name() == null || option.getOt_name().length() == 0)
				continue;
			//옵션 추가
			option.setOt_gs_num(dbGoods.getGs_num());
			adminDao.insertOption(option);
		}
		return true;
	}

	/* uploadGoodsImage : 굿즈 이미지 업로드 ---------------------------------------------------------------------------------- */
	@Override
	public String uploadGoodsImage(MultipartFile file) {
		if(file == null || file.getOriginalFilename().length() == 0)
			return null;
		String url = "";
		String prefix ="";
		try {
			url = UploadFileUtils.uploadFilePrefix(goodsUploadPath+"\\detail", prefix, file.getOriginalFilename(), file.getBytes());
			url = "/detail"+url;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return url;
	}

	/* getGoodsList : 굿즈 리스트 가져오기 ---------------------------------------------------------------------------------- */
	@Override
	public ArrayList<CategoryVO> getGoodsList() {
		return adminDao.selectGoodsList();
	}

	/* getOptionList : 옵션 리스트 가져오기 ---------------------------------------------------------------------------------- */
	@Override
	public ArrayList<OptionVO> getOptionList(OptionVO option) {
		//값 없으면
		if(option == null || option.getOt_gs_num() < 1)
			return null;
		return adminDao.selectOptionList(option);
	}
}
