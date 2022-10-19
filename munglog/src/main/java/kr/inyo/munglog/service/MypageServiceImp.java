package kr.inyo.munglog.service;

import java.util.ArrayList;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.dao.LogDAO;
import kr.inyo.munglog.dao.MemberDAO;
import kr.inyo.munglog.dao.MypageDAO;
import kr.inyo.munglog.dto.MyOrderDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.utils.MediaUtils;
import kr.inyo.munglog.utils.UploadFileUtils;
import kr.inyo.munglog.vo.DogListVO;
import kr.inyo.munglog.vo.DogVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OrderVO;
import kr.inyo.munglog.vo.PointVO;
import kr.inyo.munglog.vo.ReviewVO;


@Service
public class MypageServiceImp implements MypageService {
	
	@Autowired
	MypageDAO mypageDao;
	@Autowired
	MemberDAO memberDao;
	@Autowired
	LogDAO logDao;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	String reviewUploadPath = "D:\\git\\munglog\\review";
	String profileUploadPath = "D:\\git\\munglog\\profile";

/* 함수***************************************************************************************************************** */
	// 이미지 파일인지 확인 ----------------------------------------------------------------------------
	public boolean isImg(MultipartFile file) {
		String originalName = file.getOriginalFilename();
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		if(MediaUtils.getMediaType(formatName) == null)
			return false;
		return true;
	}//
	
	// 이미지 파일업로드 ----------------------------------------------------------------------------
	public String uploadImg(MultipartFile file) {
		String rv_image = "";
		//파일업로드
		try {
			rv_image = UploadFileUtils.uploadFile(reviewUploadPath, file.getOriginalFilename(), file.getBytes());
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rv_image;
	}//
	
	// 내 주문인지 체크 ----------------------------------------------------------------------------
	public boolean isMyOrder(int od_num, MemberVO user) {
		//주문 내역 있는지 확인
		MyOrderDTO dbOrder = mypageDao.selectMyOrderDetail(od_num);
		if(dbOrder == null)
			return false;
		//다른 회원 번호가 다르면
		if(dbOrder.getOr_mb_num() != user.getMb_num())
			return false;
		return true;
	}//
	
/* override ********************************************************************************************************** */
	// getMyOrderList : 내 주문 내역 리스트 가져오기 ================================================================
	@Override
	public ArrayList<OrderVO> getMyOrderList(Criteria cri) {
		if(cri == null || cri.getMb_num() < 1)
			return null;
		return mypageDao.selectMyOrderList(cri);
	}//

	//getMyOrderList : 내 주문 내역 리스트 가져오기 =====================================================================
	@Override
	public ArrayList<MyOrderDTO> getMyOrderDetailList(Criteria cri) {
		if(cri == null || cri.getMb_num() < 1)
			return null;
		return mypageDao.selectMyOrderDetailList(cri);
	}//

	//getMyReview : 내 리뷰 가져오기 ===================================================================================
	@Override
	public ReviewVO getMyReview(ReviewVO review, MemberVO user) {
		//값이 없으면
		if(user == null || user.getMb_num() < 1)
			return null;
		if(review == null || review.getRv_od_num() < 1)
			return null;
		//주문 내역 있는지 확인
		if(!isMyOrder(review.getRv_od_num(), user))
			return null;
		return mypageDao.selectMyReview(review.getRv_od_num());
	}//

	//registerReview : 리뷰 등록 =====================================================================================
	@Override
	public boolean registerReview(MemberVO user, ReviewVO review, MultipartFile file) {
		// 값이 없으면
		if(user == null || user.getMb_num() < 1)
			return false;
		if(review == null || review.getRv_od_num() < 1 || review.getRv_rating() == "" || review.getRv_content() == "")
			return false;
		//별점이 1~5가 아닌경우
		if(!review.getRv_rating().equals("1") && !review.getRv_rating().equals("2") && !review.getRv_rating().equals("3") &&
				!review.getRv_rating().equals("4") && !review.getRv_rating().equals("5"))
			return false;
		//주문 내역이 있는지 확인
		if(!isMyOrder(review.getRv_od_num(), user))
			return false;
		//파일이 있으면
		if(file != null) {
			if(file.getOriginalFilename() == null || file.getOriginalFilename().length() == 0)
				return false;
			//이미지 파일인지 확인
			if(!isImg(file))
				return false;
			//이미지 파일 업로드
			String rv_image = uploadImg(file);
			review.setRv_image(rv_image);
		}
		//리뷰 등록하기
		if(!mypageDao.insertReview(review))
			return false;
		//포인트 지급
		memberDao.insertPoint(user.getMb_num(), "적립", "리뷰 작성", 10);
		return true;
	}//
	
	//modifyReview : 리뷰 수정 =====================================================================================
	@Override
	public boolean modifyReview(MemberVO user, ReviewVO review, MultipartFile file, boolean delModiImage) {
		// 값이 없으면
		if(user == null || user.getMb_num() < 1)
			return false;
		if(review == null || review.getRv_num() < 1 || review.getRv_od_num() < 1 ||
				review.getRv_rating() == "" || review.getRv_content() == "")
			return false;
		//별점이 1~5가 아닌경우
		if(!review.getRv_rating().equals("1") && !review.getRv_rating().equals("2") && !review.getRv_rating().equals("3") &&
				!review.getRv_rating().equals("4") && !review.getRv_rating().equals("5"))
			return false;
		//주문 내역 있는지 확인
		if(!isMyOrder(review.getRv_od_num(), user))
			return false;
		//리뷰가 있는지 확인
		ReviewVO dbReview = mypageDao.selectMyReview(review.getRv_od_num());
		if(dbReview == null)
			return false;
		if(dbReview.getRv_num() != review.getRv_num())
			return false;
		//파일이 있으면
		if(file != null) {
			if(file.getOriginalFilename() == null || file.getOriginalFilename().length() == 0)
				return false;
			//이미지 파일인지 확인
			if(!isImg(file))
				return false;
			//기존 파일 삭제
			UploadFileUtils.deleteFile(reviewUploadPath, dbReview.getRv_image());
			//이미지 파일 업로드
			String rv_image = uploadImg(file);
			dbReview.setRv_image(rv_image);
		}
		//기존 사진 삭제면
		if(file == null && delModiImage) {
			//기존 파일 삭제
			UploadFileUtils.deleteFile(reviewUploadPath, dbReview.getRv_image());
			dbReview.setRv_image("");
		}
		//리뷰 수정하기
		dbReview.setRv_rating(review.getRv_rating());
		dbReview.setRv_content(review.getRv_content());
		return mypageDao.updateReview(dbReview);
	}//
	
	/* modifyAccount : 회원정보 수정 -----------------------------------------------------------------------*/
	@Override
	public boolean modifyAccount(MemberVO member, MemberVO user) {
		// 값이 없으면
		if(user == null || user.getMb_num() < 1)
			return false;
		if(member == null || member.getMb_num() < 1 || member.getMb_email() == null || member.getMb_name() == null 
				|| member.getMb_phone() == null)
			return false;
		//활동 정지당한 회원이 아니면
		if(!user.getMb_activity().equals("0"))
			return false;
		//다른 회원이면
		if(member.getMb_num() != user.getMb_num())
			return false;
		//이메일로 회원정보 가져오기
		MemberVO dbMember = memberDao.selectMemberByMbnum(user.getMb_num());
		if(dbMember == null)
			return false;
		//이름과 핸드폰번호가 모두 동일한 회원이 있으면 안됨 -> 아이디 찾기
		MemberVO isMember = memberDao.selectSameMember(member.getMb_name(),member.getMb_phone());
		if(isMember != null &&
				(!isMember.getMb_name().equals(dbMember.getMb_name()) || !isMember.getMb_phone().equals(dbMember.getMb_phone())))
			return false;
		//비밀번호 수정이면 비밀번호 암호화
		if(member.getMb_pw() != "" || member.getMb_pw().length() != 0) {
			String encPw = passwordEncoder.encode(member.getMb_pw()); 
			dbMember.setMb_pw(encPw);
		}
		dbMember.setMb_name(member.getMb_name());
		dbMember.setMb_phone(member.getMb_phone());
		return memberDao.updateMember(dbMember);
	}
	
	/* checkNickname : 닉네임 중복 검사 -----------------------------------------------------------------------*/
	@Override
	public int checkNickname(MemberVO member, MemberVO user) {
		//값이 없음
		if(user == null || user.getMb_num() < 1 || user.getMb_nickname() == "")
			return -1;
		if(member == null || member.getMb_nickname() == "")
			return -1;
		//정규 표현식에 맞는지 확인
		String nicknameRegex = "^(?=.*[A-Za-z0-9가-힣])[\\w가-힣-]{2,10}$";
		String strictRegex = "^[M|m][U|u][N|n][G|g]\\d+$";
		if(!Pattern.matches(nicknameRegex, member.getMb_nickname()))
			return 0;
		if(!member.getMb_nickname().equals(user.getMb_nickname()) && Pattern.matches(strictRegex, member.getMb_nickname()))
			return 1;
		//닉네임이 있는지 확인
		MemberVO dbMember = memberDao.selectMemberByNickname(member.getMb_nickname());
		if(!member.getMb_nickname().equals(user.getMb_nickname()) && dbMember != null)
			return 2;
		return 3;
	}//
	
	/* modifyProfile : 프로필 수정 -----------------------------------------------------------------------*/
	@Override
	public boolean modifyProfile(MultipartFile file, boolean delProfile, MemberVO member, MemberVO user) {
		// 값 없으면
		if(user == null || user.getMb_num() < 1)
			return false;
		if(member == null || member.getMb_num() < 1 || member.getMb_nickname() == "")
			return false;
		if(member.getMb_num() != user.getMb_num())
			return false;
		//회원 정보 가져오기
		MemberVO dbMember = memberDao.selectMemberByMbnum(member.getMb_num());
		if(dbMember == null)
			return false;
		//프로필 사진 수정
		//프로필 삭제면
		if(!delProfile && file.getOriginalFilename() == "") {
			//기존 프로필 사진 삭제(기본 프로필이 아니면)
			if(!dbMember.getMb_profile().equals("/profile.png"))
				UploadFileUtils.deleteFile(profileUploadPath, dbMember.getMb_profile());
			dbMember.setMb_profile("/profile.png");
		}
		//파일이 있으면
		if(file.getOriginalFilename() != "") {
			//이미지 파일인지 확인
			if(!isImg(file))
				return false;
			// 파일 업로드
			try {
				String mb_profile = UploadFileUtils.uploadFilePrefix(profileUploadPath, String.valueOf(dbMember.getMb_num()),
						file.getOriginalFilename(), file.getBytes());
				dbMember.setMb_profile(mb_profile);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		//프로필 수정
		dbMember.setMb_nickname(member.getMb_nickname());
		dbMember.setMb_greeting(member.getMb_greeting());
		return memberDao.updateProfile(dbMember);
	}//
	
	//getMyPointList : 내 포인트 내역 라스트 가져오기 =========================================================================
	@Override
	public ArrayList<PointVO> getMyPointList(Criteria cri, MemberVO user) {
		// 값이 없으면
		if(user == null || user.getMb_num() < 1)
			return null;
		if(cri == null || cri.getMb_num() < 1)
			return null;
		//다른 회원이면
		if(cri.getMb_num() != user.getMb_num())
			return null;
		return mypageDao.selectMyPointList(cri);
	}

	//getPointTotalCount : 내 포인트 전체 개수 가져오기 =========================================================================
	@Override
	public int getPointTotalCount(Criteria cri) {
		if(cri == null || cri.getMb_num() < 1)
			return 0;
		return mypageDao.selectPointtotalCount(cri);
	}

	//modifyDog : 강아지 정보 수정 =========================================================================
	@Override
	public boolean modifyDog(MemberVO user, DogListVO dlist, int[] delNums) {
		//값이 없으면
		if(user == null || user.getMb_num() < 1)
			return false;
		if(dlist == null || dlist.getDlist().size() > 3)
			return false;
		//강아지 정보 삭제 ---------------------------------------------------------------------------
		if(delNums != null) {	
			for(int dgNum : delNums){
				//값이 없으면
				if(dgNum < 1)
					continue;
				//강아지 정보 확인 
				DogVO dbDog = logDao.selectDog(dgNum);
				if(dbDog == null)
					continue;
				if(dbDog.getDg_mb_num() != user.getMb_num())
					continue;
				//강아지 정보 삭제
				mypageDao.deleteDog(dbDog.getDg_num());
			}
		}
		//강아지 정보 수정 --------------------------------------------------------------------------------
		for(DogVO dog : dlist.getDlist()) {
			//값이 없으면
			if(dog == null)
				continue;
			//이름 없으면 
			if(dog.getDg_name().equals("") || dog.getDg_name() == null)
				continue;
			//새로 추가면 -------------------------------------------------------------------------------------
			if(dog.getDg_num() == 0) {
				//강아지 정보 가져오기
				ArrayList<DogVO> dbDogList = logDao.selectDogList(user.getMb_num());
				//이미 강아지가 3마리 추가됬으면
				if(dbDogList.size() >= 3)
					continue;	
				//강아지 정보 추가
				dog.setDg_mb_num(user.getMb_num());
				mypageDao.insertDog(dog);
			}
			//기존 강아지 수정 -------------------------------------------------------------------------------------
			else if(dog.getDg_num() != 0) {
				//강아지 정보 확인 
				DogVO dbDog = logDao.selectDog(dog.getDg_num());
				if(dbDog == null)
					continue;
				if(dbDog.getDg_mb_num() != user.getMb_num())
					continue;
				//값 재설정
				dbDog.setDg_name(dog.getDg_name());
				//등록번호와 생일은 수정 못함
				if(dbDog.getDg_reg_num().equals(""))
					dbDog.setDg_reg_num(dog.getDg_reg_num());
				if(dbDog.getDg_birth() == null)
					dbDog.setDg_birth(dog.getDg_birth());
				mypageDao.updateDog(dbDog);
			}
		}
		return true;
	}//
	
	/* insertDog : 회원의 강아지 정보 추가 ========================================================================== */
	@Override
	public boolean insertDog(MemberVO user, DogListVO dlist) {
		//값이 없으면
		if(user == null || user.getMb_num() < 1)
			return false;
		if(dlist == null || dlist.getDlist().isEmpty() || dlist.getDlist().size() > 3)
			return false;
		//강아지 정보 가져오기
		ArrayList<DogVO> dbDogList = logDao.selectDogList(user.getMb_num());
		//이미 강아지가 있으면
		if(!dbDogList.isEmpty())
			return false;
		//강아지 정보 추가
		for(DogVO dog : dlist.getDlist()) {
			//값이 없으면
			if(dog == null)
				continue;
			//이름 없으면 
			if(dog.getDg_name() == null)
				continue;
			//강아지 정보 추가
			dog.setDg_mb_num(user.getMb_num());
			mypageDao.insertDog(dog);
		}
		return true;
	}
}
