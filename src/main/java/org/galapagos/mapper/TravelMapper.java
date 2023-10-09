package org.galapagos.mapper;

import java.util.List;

import org.galapagos.domain.Criteria;
import org.galapagos.domain.HeartVO;
import org.galapagos.domain.TravelVO;

public interface TravelMapper {

	// 모델에 종속된 것이 아니라 어디든 가져다 사용이 가능
	public int getTotalCount(Criteria cri);
	
	// 페이지 목록 추출
	public List<TravelVO> getList(Criteria cri);
	
	// pk 추출 포함
	public void insert(TravelVO travel);
	
	public TravelVO read(Long no);
	
	public int delete(Long no);
	
	public int update(TravelVO travel);
	
	// 사진 랜덤으로 가져오기
	public List<TravelVO> getRandom(int count);
	
	// 좋아요 처리
	public List<Long> getHeartsList(String username);
	public int addHeart(HeartVO heart);
	public int deleteHeart(HeartVO heart);
}
