package kr.inyo.munglog.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.dto.QnaDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.BoardVO;
import kr.inyo.munglog.vo.MemberVO;

public interface BoardService {
	//QNA 등록
	boolean registerQna(MemberVO user, BoardVO board, Integer qn_gs_num, MultipartFile[] files);
	//QNA 내용 이미지 업로드
	String uploadQnaImage(MultipartFile file);
	//QNA 리스트 가져오기
	ArrayList<QnaDTO> getQnaList(Criteria cri);
	//게시글 총 개수 가져오기
	int getBoardTotalCount(Criteria cri, String bd_type);

}
