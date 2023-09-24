package org.galapagos.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.galapagos.domain.MemberVO;
import org.galapagos.service.MemberService;
import org.galapagos.service.MemberServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Log4j
@RequestMapping("/security")
@Controller
public class SecurityController {
	
	@Autowired
	private MemberService service;
	
	@GetMapping("/login")
	public void login() {
		
		log.info("login page");
	}
	
	@GetMapping("/signup")
	public void signUp(@ModelAttribute("member") MemberVO member) {
		
	}
	
	@PostMapping("/signup")
	public String signUp(@Valid @ModelAttribute("member") MemberVO member,
			Errors errors, MultipartFile avatar) throws IOException {
		
		// 비밀번호, 비밀번호 확인 일치 여부
		if(!member.getPassword().equals(member.getPassword2())) {
			
			// 특정 필드에 대해 에러 추가
			// (변수명, 에러코드, 출력할 메세지)
			errors.rejectValue("password2", "비밀번호확인 에러", "비밀번호 확인이 일치하지 않습니다.");
		}
		
		// 아이디 중복 체크 (유효성 검사 통과 시)
		if(!errors.hasFieldErrors("username")) {
			if(service.get(member.getUsername()) != null) { // 중복일 경우
				
				errors.rejectValue("username", "아이디 중복 에러", "동일한 ID가 있습니다.");
			}
		}
		
		if(errors.hasFieldErrors()) {
			
			return "security/signup";
		}
		
		// DB 저장
		service.register(member, avatar);
		
		return "redirect:/";
		
	}
	
	
	@GetMapping("/avatar/{size}/{username}") // 바뀌어야 하는 경로는 {}에 넣음 = path variable = PathVariable
	@ResponseBody // 직접 응답
	public void avatar(@PathVariable("size") String size,
			@PathVariable("username") String username,
			HttpServletResponse response) throws IOException {
		
		// 아바타 이미지 경로
		File src = new File(MemberServiceImpl.AVATAR_UPLOAD_DIR, username + ".png");
		
		// 썸네일 이미지 업로드 하지 않았을 때
		if(!src.exists()) {
			
			src = new File(MemberServiceImpl.AVATAR_UPLOAD_DIR, "unknown.png");
		}
		
		response.setHeader("Content-Type", "image/png");
		
		if(size.equals("sm")) {
			
			Thumbnails.of(src)
			.size(25, 25)
			.toOutputStream(response.getOutputStream());
		}
		
		else if(size.equals("md")) {
			
			Thumbnails.of(src)
			.size(50, 50)
			.toOutputStream(response.getOutputStream());
		}
		
		else if(size.equals("lg")) {
			
			Thumbnails.of(src)
			.size(100, 100)
			.toOutputStream(response.getOutputStream());
		}
	}
	
	@GetMapping("/profile")
	public void profile() {
		
		
	}

}
