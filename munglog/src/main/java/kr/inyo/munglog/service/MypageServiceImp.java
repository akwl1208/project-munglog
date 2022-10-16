package kr.inyo.munglog.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.dao.MemberDAO;
import kr.inyo.munglog.dao.MypageDAO;
import kr.inyo.munglog.dto.MyOrderDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.utils.MediaUtils;
import kr.inyo.munglog.utils.UploadFileUtils;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OrderVO;
import kr.inyo.munglog.vo.ReviewVO;


@Service
public class MypageServiceImp implements MypageService {
	
	@Autowired
	MypageDAO mypageDao;
	@Autowired
	MemberDAO memberDao;
	
	String reviewUploadPath = "D:\\git\\munglog\\review";

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
		return mypageDao.uploadReview(dbReview);
	}
}
