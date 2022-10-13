package kr.inyo.munglog.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.dao.BoardDAO;
import kr.inyo.munglog.dto.QnaDTO;
import kr.inyo.munglog.pagination.Criteria;
import kr.inyo.munglog.utils.MediaUtils;
import kr.inyo.munglog.utils.UploadFileUtils;
import kr.inyo.munglog.vo.AttachmentVO;
import kr.inyo.munglog.vo.BoardVO;
import kr.inyo.munglog.vo.CommentVO;
import kr.inyo.munglog.vo.MemberVO;
import kr.inyo.munglog.vo.QnaVO;

@Service
public class BoardServiceImp implements BoardService {

	@Autowired
	BoardDAO boardDao;
	
	String qnaUploadPath = "D:\\git\\munglog\\qna";
	String fileUploadPath = "D:\\git\\munglog\\file";
	
/* 함수********************************************************************************************************************* */
	// insertAttachment : 첨부파일 추가 ==================================================================
	private void insertAttachment(MultipartFile file, int bd_num) {
		String at_ori_name = file.getOriginalFilename();
		if(file == null || at_ori_name == null || at_ori_name.length() == 0)
			return;
		try {
			String at_name = UploadFileUtils.uploadFile(fileUploadPath, at_ori_name, file.getBytes());
			
			AttachmentVO attachment = new AttachmentVO(bd_num,at_ori_name, at_name);
			boardDao.insertAttachment(attachment);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}//
	
	// 이미지 파일인지 확인 =====================================================================================
	public boolean isImg(MultipartFile file) {
		String originalName = file.getOriginalFilename();
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		if(MediaUtils.getMediaType(formatName) == null)
			return false;
		return true;
	}//
	
	// 파일 업로드 ============================================================================================
	public String uploadFile(MultipartFile file, String uploadPath) {
		String url = "";
		try {
			url = UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
		}catch (Exception e) {
			e.printStackTrace();
		}
		return url;
	}//
	
	//파일 삭제 ============================================================================================
	private void deleteFile(AttachmentVO attachment, String uploadPath) {
		UploadFileUtils.deleteFile(uploadPath, attachment.getAt_name());
		boardDao.deleteAttachment(attachment.getAt_num());
	}//
	
/* overide 메소드 *********************************************************************************************************** */
	//registerQna : qna 등록 ==========================================================================
	@Override
	public boolean registerQna(MemberVO user, BoardVO board, Integer qn_gs_num, MultipartFile[] files) {
		//값이 없으면
		if(user == null || board == null || user.getMb_num() < 1 || !user.getMb_activity().equals("0"))
			return false;
		if(qn_gs_num < 1 || board.getBd_title() == "" || board.getBd_content() == "")
			return false;
		if(files.length > 3)
			return false;
		//board 설정 -----------------------------------------------------------------------
		board.setBd_type("QNA");
		board.setBd_mb_num(user.getMb_num());
		//Qna 등록 ---------------------------------------------------------------------------
		boardDao.insertBoard(board);
		BoardVO dbBoard = boardDao.selectBoardByAll(board);
		if(dbBoard == null)
			return false;
		boardDao.insertQna(dbBoard.getBd_num(), qn_gs_num, "답변 대기");
		//파일 등록 --------------------------------------------------------------------------
		for(MultipartFile file : files) {
			//값이 없으면
			if(file == null || file.getOriginalFilename().length() == 0)
				continue;
			insertAttachment(file, dbBoard.getBd_num());
		}
		return true;
	}//
	
	//uploadQnaImage : qna 내용 이미지 업로드 ==========================================================================
	@Override
	public String uploadQnaImage(MultipartFile file) {
		if(file == null || file.getOriginalFilename().length() == 0)
			return null;
		//이미지 파일인지 확인
		if(!isImg(file))
			return null;
		//이미지 파일 업로드
		return uploadFile(file, qnaUploadPath);
	}//
	
	//getQnaList : qna 리스트 가져오기 ==========================================================================
	@Override
	public ArrayList<QnaDTO> getQnaList(Criteria cri) {
		//값이 없으면
		if(cri == null)
			return null;
		//회원번호 주고 로그 가져오기
		return boardDao.selectQnaListByCri(cri);
	}//

	//getBoardTotalCount : 게시글 총 개수 가져오기 ==========================================================================
	@Override
	public int getBoardTotalCount(Criteria cri, String bd_type) {
		//값이 없으면
		if(cri == null)
			return 0;
		return boardDao.selectQnaTotalCount(cri, bd_type);
	}//

	//getQna : QNA 가져오기 ==========================================================================
	@Override
	public QnaDTO getQna(MemberVO user, int qn_num) {
		//값이 없으면
		if(user == null || user.getMb_num() < 1 || qn_num < 1)
			return null;
		return boardDao.selectQna(qn_num);
	}//

	//getAttachmentList : 첨부파일 리스트 가져오기 ==========================================================================
	@Override
	public ArrayList<AttachmentVO> getAttachmentList(int bd_num) {
		if(bd_num < 1)
			return null;
		return boardDao.selectAttachmentList(bd_num);
	}
	
	//deleteBoard : 게시글 삭제 ==========================================================================
	@Override
	public boolean deleteBoard(BoardVO board, MemberVO user) {
		//값이 없으면
		if(user == null || user.getMb_num() < 1)
			return false;
		if(board == null || board.getBd_num() < 1)
			return false;
		//게시글 있는지 확인
		BoardVO dbBoard = boardDao.selectBoard(board.getBd_num());
		if(dbBoard == null)
			return false;
		//관리자가 아닌 다른 회원이면
		if(!user.getMb_level().equals("A") && !user.getMb_level().equals("S")
				&& (dbBoard.getBd_mb_num() != user.getMb_num()))
			return false;
		//다른 게시글이면
		if(!dbBoard.getBd_type().equals(board.getBd_type()))
			return false;
		//업로드한 첨부파일 삭제--------------------------------------------------------
		ArrayList<AttachmentVO> dbAttachmentList = boardDao.selectAttachmentList(dbBoard.getBd_num());
		//첨부파일이 있으면
		if(!dbAttachmentList.isEmpty()) {
			for(AttachmentVO tmpAttachment : dbAttachmentList) {
				if(tmpAttachment == null)
					continue;
				if(tmpAttachment.getAt_num() < 1 || tmpAttachment.getAt_name() == "")
					continue;
				deleteFile(tmpAttachment, fileUploadPath);
			}
		}
		//게시글 삭제
		return boardDao.deleteBoard(dbBoard.getBd_num());
	}

	//modifyQna : QNA 수정 ==========================================================================
	@Override
	public boolean modifyQna(MemberVO user, QnaDTO qna, MultipartFile[] files, int[] nums) {
		//값이 없으면
		if(user == null || qna == null || user.getMb_num() < 1 || !user.getMb_activity().equals("0"))
			return false;
		if(qna.getQn_num() < 1 || qna.getQn_gs_num() < 1)
			return false;
		if(qna.getQn_bd_num() < 1 || qna.getBd_title() == "" || qna.getBd_content() == "")
			return false;
		if(files.length > 3 || (nums!=null && nums.length > 3))
			return false;
		//qna 가져오기
		QnaDTO dbQna = boardDao.selectQna(qna.getQn_num());
		if(dbQna == null || dbQna.getQn_bd_num() != qna.getQn_bd_num() || dbQna.getBd_mb_num() != user.getMb_num())
			return false;
		//답변완료한 QNA는 수정 못함
		if(dbQna.getQn_state().equals("답변 완료"))
			return false;
		//기존 첨부파일 삭제 ------------------------------------------------------------------------ 
		if(nums != null) {
			for(int at_num : nums) {
				if(at_num < 1)
					continue;
				AttachmentVO dbAttachment = boardDao.selectAttachment(at_num);
				if(dbAttachment == null || dbAttachment.getAt_name().length() == 0)
					continue;
				deleteFile(dbAttachment, fileUploadPath);
			}			
		}
		//새로운 첨부파일 추가 -----------------------------------------------------------------------
		if(files != null) {
			for(MultipartFile file : files) {
				//값이 없으면
				if(file == null || file.getOriginalFilename().length() == 0)
					continue;
				insertAttachment(file, dbQna.getQn_bd_num());
			}			
		}
		//qna 수정 -------------------------------------------------------------------------------
		//게시글
		BoardVO dbBoard = new BoardVO();
		dbBoard.setBd_num(dbQna.getQn_bd_num());
		dbBoard.setBd_title(qna.getBd_title());
		dbBoard.setBd_content(qna.getBd_content());
		boardDao.updateBoard(dbBoard);
		//qna
		QnaVO dbQnaVo = new QnaVO();
		dbQnaVo.setQn_num(dbQna.getQn_num());
		dbQnaVo.setQn_gs_num(qna.getQn_gs_num());
		dbQnaVo.setQn_state(dbQna.getQn_state());
		boardDao.updateQna(dbQnaVo);
		return true;
	}//
	
	//registerBoardComment : 게시글 댓글 등록하기 ==========================================================================
	@Override
	public boolean registerBoardComment(CommentVO comment, MemberVO user) {
		// 값이 없으면
		if(user == null || user.getMb_num() < 1)
			return false;
		if(comment == null || comment.getCm_content().trim().length() == 0)
			return false;
		if(comment.getCm_bd_num() < 1)
			return false;
		//없는 게시글에 댓글 등록하려고 하면
		BoardVO dbBoard = boardDao.selectBoard(comment.getCm_bd_num());
		if(dbBoard == null)
			return false;
		//QNA게시글에 관리자가 아닌데 댓글 달면
		if(dbBoard.getBd_type().equals("QNA") && !user.getMb_level().equals("A") && !user.getMb_level().equals("S"))
			return false;
		//댓글 등록
		comment.setCm_mb_num(user.getMb_num());
		boardDao.insertBoardComment(comment);
		//qna 게시글이면
		QnaVO dbQna = boardDao.selectQnaByBdNum(comment.getCm_bd_num());
		if(dbQna != null) {
			dbQna.setQn_state("답변 완료");
			boardDao.updateQna(dbQna);			
		}			
		return true;
	}
	
	//getBoardComment : 게시글 댓글 가져오기 ==========================================================================
	@Override
	public CommentVO getBoardComment(int bd_num) {
		//값이 없으면
		if(bd_num < 1)
			return null;
		return boardDao.selectBoardComment(bd_num);
	}
	
	//deleteBoardComment : 게시글 댓글 삭제 ==========================================================================
	@Override
	public boolean deleteBoardComment(CommentVO comment, MemberVO user) {
		//값이 없으면
		if(user == null || user.getMb_num() < 1)
			return false;
		if(comment == null || comment.getCm_num() < 1)
			return false;
		//댓글이 없으면
		CommentVO dbComment = boardDao.selectComment(comment.getCm_num());
		if(dbComment == null)
			return false;
		//게시글이 다른 경우
		if(comment.getCm_bd_num() != dbComment.getCm_bd_num())
			return false;
		//QNA 댓글인지 확인
		QnaVO dbQna = boardDao.selectQnaByBdNum(dbComment.getCm_bd_num());
		//QNA가 아닌데 댓글을 작성한 회원과 다른 경우
		if(dbQna == null && (dbComment.getCm_mb_num() != user.getMb_num()))
			return false;
		//QNA인데 관리자가 아닌 경우
		if(dbQna != null && !user.getMb_level().equals("A") && !user.getMb_level().equals("S"))
			return false;
		//댓글 삭제
		boardDao.deleteComment(comment.getCm_num());
		//QNA 답변 삭제한 경우 답변 대기로 수정
		if(dbQna != null) {
			dbQna.setQn_state("답변 대기");
			boardDao.updateQna(dbQna);
		}
		return true;
	}

	//modifyBoardComment : 게시글 댓글 수정 ==========================================================================
	@Override
	public boolean modifyBoardComment(CommentVO comment, MemberVO user) {
		//값이 없으면
		if(user == null || user.getMb_num() < 1)
			return false;
		if(comment == null || comment.getCm_num() < 1)
			return false;
		//댓글이 없으면
		CommentVO dbComment = boardDao.selectComment(comment.getCm_num());
		if(dbComment == null)
			return false;
		//게시글이 다른 경우
		if(comment.getCm_bd_num() != dbComment.getCm_bd_num())
			return false;
		//QNA 댓글인지 확인
		QnaVO dbQna = boardDao.selectQnaByBdNum(dbComment.getCm_bd_num());
		//QNA가 아닌데 댓글을 작성한 회원과 다른 경우
		if(dbQna == null && (dbComment.getCm_mb_num() != user.getMb_num()))
			return false;
		//QNA인데 관리자가 아닌 경우
		if(dbQna != null && !user.getMb_level().equals("A") && !user.getMb_level().equals("S"))
			return false;
		//댓글 수정
		dbComment.setCm_content(comment.getCm_content());
		return boardDao.updateComment(dbComment);
	}
}
