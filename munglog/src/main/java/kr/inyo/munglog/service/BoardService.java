package kr.inyo.munglog.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.dto.QnaDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.vo.AttachmentVO;
import kr.inyo.munglog.vo.BoardVO;
import kr.inyo.munglog.vo.CommentVO;
import kr.inyo.munglog.vo.MemberVO;

public interface BoardService {
	//QNA 등록
	boolean registerQna(MemberVO user, BoardVO board, Integer qn_gs_num, MultipartFile[] attachments);
	//QNA 내용 이미지 업로드
	String uploadQnaImage(MultipartFile file);
	//QNA 리스트 가져오기
	ArrayList<QnaDTO> getQnaList(Criteria cri);
	//게시글 총 개수 가져오기
	int getBoardTotalCount(Criteria cri, String bd_type);
	//qna 가져오기
	QnaDTO getQna(MemberVO user, int qn_num);
	//첨부파일 리스트 가져오기
	ArrayList<AttachmentVO> getAttachmentList(int bd_num);
	//게시글 삭제
	boolean deleteBoard(BoardVO board, MemberVO user);
	//qna 수정
	boolean modifyQna(MemberVO user, QnaDTO qna, MultipartFile[] files, int[] nums);
	//게시글 댓글 등록하기
	boolean registerBoardComment(CommentVO comment, MemberVO user);
	//게시글 번호로 게시글 댓글 가져오기
	CommentVO getBoardComment(int bd_num);
	//게시글 댓글 삭제
	boolean deleteBoardComment(CommentVO comment, MemberVO user);
	//게시글 댓글 수정
	boolean modifyBoardComment(CommentVO comment, MemberVO user);
}
