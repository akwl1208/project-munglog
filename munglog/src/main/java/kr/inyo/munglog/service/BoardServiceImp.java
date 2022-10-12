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
	}
	
/* overide 메소드 *********************************************************************************************************** */
	//registerQna : qna 등록 ==========================================================================
	@Override
	public boolean registerQna(MemberVO user, BoardVO board, Integer qn_gs_num, MultipartFile[] files) {
		//값이 없으면
		if(user == null || board == null || user.getMb_num() < 1)
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
}
