package org.galapagos.service;

import java.util.List;

import org.galapagos.domain.BoardAttachmentVO;
import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.springframework.web.multipart.MultipartFile;

public interface BoardService {
	
	public void register(BoardVO board, List<MultipartFile> files) throws Exception;
	
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board, List<MultipartFile> files) throws Exception;
	
	public boolean remove(Long bno);
	
	//public List<BoardVO> getList();
	
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public BoardAttachmentVO getAttachment(Long no); // download
	
	public boolean removeAttachment(Long no); // 수정 시 파일 삭제 기능
	
}

/* 

public int getTotal(Criteria cri);

- (Criteria cri)를 parameter로 전달 할 필요는 없으나
	목록과 전체 데이터 개수는 항상 같이 동작하는 경우가 많기 때문에 지정함

*/