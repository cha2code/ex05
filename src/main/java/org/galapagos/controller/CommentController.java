package org.galapagos.controller;

import java.util.List;

import org.galapagos.domain.CommentVO;
import org.galapagos.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/board/{bno}/comment")
public class CommentController {
	
	@Autowired
	private CommentMapper mapper;
	
	@GetMapping("") // 변수명, pathVariable이 같으면 생략 가능
	public List<CommentVO> readComments(@PathVariable Long bno) {
		
		return mapper.readAll(bno);
	}
	
	@GetMapping("/{no}")
	public CommentVO readComment(@PathVariable Long bno, @PathVariable Long no) {
		
		return mapper.get(no);
	}
	
	@PostMapping("")
	public CommentVO create(@RequestBody CommentVO vo) {
		
		mapper.create(vo); // no 배정
		
		return mapper.get(vo.getNo()); // 모든 데이터가 들어있는 객체가 리턴됨
	}
	
	@PutMapping("/{no}")
	public CommentVO update(@PathVariable Long no, @RequestBody CommentVO vo) {
		
		System.out.println("==>" + vo);
		
		mapper.update(vo);
		
		return mapper.get(vo.getNo()); // DB에 수정된 내용을 다시 읽어서 리턴
	}
	
	@DeleteMapping("/{no}")
	public String delete(@PathVariable Long no) {
		
		System.out.println("delete ==> " + no);
		
		mapper.delete(no);
		
		return "OK";
	}

}
