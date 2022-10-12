package kr.inyo.munglog.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.inyo.munglog.dto.QnaDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.AttachmentVO;
import kr.inyo.munglog.vo.BoardVO;

public interface BoardDAO {
	/* 게시글 ===================================================== */
	//게시글 추가
	boolean insertBoard(BoardVO board);
	//게시글 가져오기
	BoardVO selectBoardByAll(BoardVO board);
	
	/* QNA ===================================================== */
	//QNA 등록
	boolean insertQna(@Param("qn_bd_num")int bd_num, @Param("qn_gs_num")Integer qn_gs_num, @Param("qn_state")String qn_state);
	//cri로 QNA 리스트 가져오기
	ArrayList<QnaDTO> selectQnaListByCri(Criteria cri);
	//게시글 총 개수 가져오기
	int selectQnaTotalCount(@Param("cri")Criteria cri, @Param("bd_type")String bd_type);
	//qna 가져오기
	QnaDTO selectQna(int qn_num);
	
	/* 첨부파일 ===================================================== */
	//첨부파일 추가
	void insertAttachment(AttachmentVO attachment);
	//첨부파일 리스트 가져오기
	ArrayList<AttachmentVO> selectAttachmentList(int bd_num);

}
