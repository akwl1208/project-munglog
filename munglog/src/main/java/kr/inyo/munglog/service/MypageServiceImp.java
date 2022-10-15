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
	}
	
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
		MyOrderDTO dbOrder = mypageDao.selectMyOrderDetail(review.getRv_od_num());
		if(dbOrder == null)
			return null;
		//내가 주문한 내역이 아닌 경우
		if(dbOrder.getOr_mb_num() != user.getMb_num())
			return null;
		return mypageDao.selectMyReview(dbOrder.getOd_num());
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
		//주문 내역 있는지 확인
		MyOrderDTO dbOrder = mypageDao.selectMyOrderDetail(review.getRv_od_num());
		if(dbOrder == null)
			return false;
		//다른 회원이 리뷰 등록하려고 하면
		if(dbOrder.getOr_mb_num() != user.getMb_num())
			return false;
		//파일이 있으면
		if(file != null) {
			if(file.getOriginalFilename() == null || file.getOriginalFilename().length() == 0)
				return false;
			//이미지 파일인지 확인
			if(!isImg(file))
				return false;
			//파일업로드
			try {
				String rv_image = UploadFileUtils.uploadFile(reviewUploadPath, file.getOriginalFilename(), file.getBytes());
				review.setRv_image(rv_image);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		//리뷰 등록하기
		if(!mypageDao.insertReview(review))
			return false;
		//포인트 지급
		memberDao.insertPoint(user.getMb_num(), "적립", "리뷰 작성", 10);
		return true;
	}//
}
