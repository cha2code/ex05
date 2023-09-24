package org.galapagos.service;

import java.io.IOException;

import org.galapagos.domain.MemberVO;
import org.springframework.web.multipart.MultipartFile;

public interface MemberService {
	
	// 한 개 추출
	public MemberVO get(String username);
	
	// 등록
	public void register(MemberVO member, MultipartFile avatar) throws IOException;

}
