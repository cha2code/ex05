package org.galapagos.service;

import java.util.List;

import org.galapagos.domain.Criteria;
import org.galapagos.domain.TravelVO;

public interface TravelService {
	
	public int getTotal(Criteria cri);
	
	public List<TravelVO> getList(Criteria cri);
	
	public TravelVO get(Long no);
	
	public void register(TravelVO travel);
	
	public boolean modify(TravelVO travel);
	
	public boolean remove(Long no);
	
}

/*

일반적으로 Service를 만들 때 read 기능을 먼저 제시함

*/