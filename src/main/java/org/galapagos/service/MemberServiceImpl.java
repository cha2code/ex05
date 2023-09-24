package org.galapagos.service;

import java.io.File;
import java.io.IOException;

import org.galapagos.domain.AuthVO;
import org.galapagos.domain.MemberVO;
import org.galapagos.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Service
@Log4j
public class MemberServiceImpl implements MemberService {
	
	public static final String AVATAR_UPLOAD_DIR = "C:\\upload\\avatar";
	
	@Autowired
	private MemberMapper mapper;
	
	@Autowired
	private PasswordEncoder pwEncoder;

	@Override
	public MemberVO get(String username) {
		
		return mapper.read(username);
	}

	@Override
	public void register(MemberVO member, MultipartFile avatar) throws IOException {
		
		// 1. password 암호화 - 기존에 가지고 있던 비밀번호
		String encPassword = pwEncoder.encode(member.getPassword());
		member.setPassword(encPassword); // 암호화 한 비밀번호 다시 저장
		
		// 2. tbl_member 테이블에 저장
		mapper.insert(member);
		
		// 3. tbl_member_auth에 저장
		AuthVO auth = new AuthVO(member.getUsername(), "ROLE_USER");
		
		mapper.insertAuth(auth);
		
		// 4. avatar image 저장 - 
		if(!avatar.isEmpty()) {
			File dest = new File(AVATAR_UPLOAD_DIR, member.getUsername() + ".png");
		
			// file 조작이기 때문에 예외 처리 필수
			// 여기서는 임의로 저장한 이미지 파일(unknown.jpg)을 썸네일 사이즈로 변환해서 지정 위치에 저장
			// 에러를 던지면 interface, controller 모두 변경해야 함
			Thumbnails.of(avatar.getInputStream())
			.size(50, 50)
			.toFile(dest);
		}

	}
}


/*

** 트랜잭션 처리 - rollback
- insert가 두개 이상일 때
- 다른 처리가 있을 때

*/
