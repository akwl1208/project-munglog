package kr.inyo.munglog.dao;

import org.apache.ibatis.annotations.Param;

import kr.inyo.munglog.vo.AttachmentVO;
import kr.inyo.munglog.vo.BoardVO;

public interface BoardDAO {
	/* 게시글 ===================================================== */
	//게시글 추가
	boolean insertBoard(BoardVO board);
	//게시글 가져오기
	BoardVO selectBoardByAll(BoardVO board);
	
	/* QNA ===================================================== */
	boolean insertQna(@Param("qn_bd_num")int bd_num, @Param("qn_gs_num")Integer qn_gs_num, @Param("qn_state")String qn_state);
	
	/* 첨부파일 ===================================================== */
	void insertAttachment(AttachmentVO attachment);

}
