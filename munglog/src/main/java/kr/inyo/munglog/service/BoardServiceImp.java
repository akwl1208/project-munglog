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
import kr.inyo.munglog.vo.MemberVO;

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
	
	// 파일 없로드 ============================================================================================
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
		BoardVO dbBoard = boardDao.selectBoard(board);
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
}
