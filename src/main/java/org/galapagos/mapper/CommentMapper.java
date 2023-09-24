package org.galapagos.mapper;

import java.util.List;

import org.galapagos.domain.CommentVO;

public interface CommentMapper {
	
	// 글 번호 함께 전달(FK)
	List<CommentVO> readAll(Long no); // 목록 보기 (글 번호와 관련 있는 comment 출력)
	CommentVO get(Long no); // 상세 보기
	
	void create(CommentVO vo); // 생성
	void update(CommentVO vo); // 수정
	void delete(Long no); // 삭제

}
