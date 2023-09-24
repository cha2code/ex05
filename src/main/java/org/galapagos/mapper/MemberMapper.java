package org.galapagos.mapper;

import org.galapagos.domain.AuthVO;
import org.galapagos.domain.MemberVO;

// DB 작업이기 때문에 보통 DB 용어를 메소드명으로 사용
public interface MemberMapper {
	
	public MemberVO read(String username);

	public void insert(MemberVO member);
	
	public void insertAuth(AuthVO auth);
}
