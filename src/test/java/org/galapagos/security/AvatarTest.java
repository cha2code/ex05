package org.galapagos.security;

import java.io.File;
import java.io.IOException;

import org.galapagos.config.RootConfig;
import org.galapagos.config.SecurityConfig;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class, SecurityConfig.class})
@Log4j
public class AvatarTest {

	public static final String AVATAR_UPLOAD_DIR = "C:\\upload\\avatar";
	
	@Test
	public void testUpload() throws IOException {
		String username = "unknown";
		
		File src = new File("c:/temp/unknown.jpg");
		File dest = new File(AVATAR_UPLOAD_DIR, username + ".png"); // 아바타 사진 저장
		
		// file 조작이기 때문에 예외 처리 필수
		// 여기서는 임의로 저장한 이미지 파일(unknown.jpg)을 썸네일 사이즈로 변환해서 지정 위치에 저장
		Thumbnails.of(src)
		.size(50, 50)
		.toFile(dest);
	}
}
