package kr.inyo.munglog.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.inyo.munglog.dto.QnaDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.AttachmentVO;
import kr.inyo.munglog.vo.BoardVO;
import kr.inyo.munglog.vo.CommentVO;
import kr.inyo.munglog.vo.QnaVO;

public interface BoardDAO {
	/* 게시글 ===================================================== */
	//게시글 추가
	boolean insertBoard(BoardVO board);
	//모든 정보 주고 게시글 가져오기
	BoardVO selectBoardByAll(BoardVO board);
	//게시글 번호로 게시글 가져오기
	BoardVO selectBoard(int bd_num);
	//게시글 삭제
	boolean deleteBoard(int bd_num);
	//게시글 수정
	void updateBoard(BoardVO dbBoard);
	
	/* QNA ===================================================== */
	//QNA 등록
	boolean insertQna(@Param("qn_bd_num")int bd_num, @Param("qn_gs_num")Integer qn_gs_num, @Param("qn_state")String qn_state);
	//cri로 QNA 리스트 가져오기
	ArrayList<QnaDTO> selectQnaListByCri(Criteria cri);
	//게시글 총 개수 가져오기
	int selectQnaTotalCount(@Param("cri")Criteria cri, @Param("bd_type")String bd_type);
	//qna 번호로 qna 가져오기
	QnaDTO selectQna(int qn_num);
	//qna 수정
	void updateQna(QnaVO dbQna);
	//게시글 번호로 qna 가져오기
	QnaVO selectQnaByBdNum(int qn_bd_num);
	
	/* 첨부파일 ===================================================== */
	//첨부파일 추가
	void insertAttachment(AttachmentVO attachment);
	//첨부파일 리스트 가져오기
	ArrayList<AttachmentVO> selectAttachmentList(int bd_num);
	//첨부파일 삭제
	void deleteAttachment(int at_num);
	//첨부파일 가져오기
	AttachmentVO selectAttachment(int at_num);
	
	/* 댓글 ===================================================== */
	//게시글 댓글 추가
	boolean insertBoardComment(CommentVO comment);
	//게시글 댓글 가져오기
	CommentVO selectBoardComment(int bd_num);
	
}
