package org.galapagos.controller;

import javax.validation.Valid;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.PageDTO;
import org.galapagos.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
@AllArgsConstructor
public class BoardController {

	@Autowired
	private BoardService service;

	@GetMapping("/list")
	public void list(@ModelAttribute("cri") Criteria cri,
			Model model) {

		log.info("list : " + cri);
		
		// BoardService 인터페이스를 통해 getTotal() 호출
				int total = service.getTotal(cri);
		
		model.addAttribute("list", service.getList(cri));
		// model.addAttribute("pageMaker", new PageDTO(cri, 123)); // 임의로 123 요청

		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping("/register")
	public void register(@ModelAttribute("board") BoardVO board) {

		log.info("register");
	}

	@PostMapping("/register")
	public String Register(@Valid @ModelAttribute("board") BoardVO board,
			Errors errors,
			RedirectAttributes rttr) {

		log.info("register" + board);
		
		if(errors.hasErrors()) {
			return "board/register";
		}
		
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/board/list";
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno,
			@ModelAttribute("cri") Criteria cri,
			Model model) {

		log.info("/get or modify");
		model.addAttribute("board", service.get(bno));
	}

	@PostMapping("/modify")
	public String modify(@Valid @ModelAttribute("board") BoardVO board,
			Errors errors,
			@ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {

		log.info("modify : " + board);
		
		if(errors.hasErrors()) {
			return "board/modify";
		}

		if (service.modify(board)) {

			rttr.addFlashAttribute("result", "success");
			rttr.addAttribute("bno", board.getBno());
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());
		}

		return "redirect:" + cri.getLinkWithBno("/board/get", board.getBno());
	}

	@PostMapping("/remove")
	public String remove(
			@RequestParam("bno") Long bno,
			@ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {

		log.info("remove..........." + bno);
		

		if (service.remove(bno)) {

			rttr.addFlashAttribute("result", "success");
			//rttr.addAttribute("pageNum", cri.getPageNum());
			//rttr.addAttribute("amount", cri.getAmount());
			//rttr.addAttribute("type", cri.getType());
			//rttr.addAttribute("keyword", cri.getKeyword());
		}
		
		return "redirect:" +cri.getLink("/board/list");
	}

}

/*
 * 
 * @Controller
 * 
 * - 사용자의 요청을 처리한 후 정해진 view에 객체를 넘겨주는 역할 - 대규모 서비스일 수록 처리할 일이 많아지면서 중간 제어자 역할로
 * 생김
 * 
 */

/*
 * 
 * Model
 * 
 * - Controller에서 생성된 데이터를 담아 view로 전달할 때 사용하는 객체
 * 
 * - Servlet의 request.setAttribute()와 비슷한 역할
 * 
 * - addAttribute("key", "value") 메소드를 이용해 view에 전달할 데이터를 key, value 형식으로 전달이
 * 가능함
 * 
 */