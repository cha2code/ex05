package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.Criteria;
import org.galapagos.domain.TravelVO;

public interface TravelService {
	
	public int getTotal(Criteria cri);
	
	public List<TravelVO> getList(Criteria cri, Principal principal);
	
	public TravelVO get(Long no, Principal principal);
	
	public void register(TravelVO travel);
	
	public boolean modify(TravelVO travel);
	
	public boolean remove(Long no);
	
	// 랜덤으로 가져올 사진의 개수 = count
	public List<TravelVO> getRandom(int count);
	
}

/*

일반적으로 Service를 만들 때 read 기능을 먼저 제시함

*/