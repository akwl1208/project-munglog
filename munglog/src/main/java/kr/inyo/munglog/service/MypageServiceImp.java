package kr.inyo.munglog.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.inyo.munglog.dao.MypageDAO;
import kr.inyo.munglog.dto.MyOrderDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.OrderVO;


@Service
public class MypageServiceImp implements MypageService {
	
	@Autowired
	MypageDAO mypageDao;

/* 함수***************************************************************************************************************** */

	
/* override ********************************************************************************************************** */
	// getMyOrderList : 내 주문 내역 리스트 가져오기 =======================================================
	@Override
	public ArrayList<OrderVO> getMyOrderList(Criteria cri) {
		if(cri == null || cri.getMb_num() < 1)
			return null;
		return mypageDao.selectMyOrderList(cri);
	}//

	//getMyOrderList : 내 주문 내역 리스트 가져오기 =======================================================
	@Override
	public ArrayList<MyOrderDTO> getMyOrderDetailList(Criteria cri) {
		if(cri == null || cri.getMb_num() < 1)
			return null;
		return mypageDao.selectMyOrderDetailList(cri);
	}//

}
