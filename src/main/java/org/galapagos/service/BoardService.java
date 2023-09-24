package org.galapagos.service;

import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;

public interface BoardService {
	
	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
	//public List<BoardVO> getList();
	
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
}

/* 

public int getTotal(Criteria cri);

- (Criteria cri)를 parameter로 전달 할 필요는 없으나
	목록과 전체 데이터 개수는 항상 같이 동작하는 경우가 많기 때문에 지정함

*/