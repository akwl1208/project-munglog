package kr.inyo.munglog.service;

import org.springframework.web.multipart.MultipartFile;

import kr.inyo.munglog.vo.BoardVO;
import kr.inyo.munglog.vo.MemberVO;

public interface BoardService {
	//QNA 등록
	boolean registerQna(MemberVO user, BoardVO board, Integer qn_gs_num, MultipartFile[] files);
	//QNA 내용 이미지 업로드
	String uploadQnaImage(MultipartFile file);

}
