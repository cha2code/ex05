package org.galapagos.domain;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class BoardVO {

	private Long bno;
	
	@NotBlank(message = "제목을 입력하세요.")
	private String title;
	
	@NotBlank(message = "내용을 입력하세요.")
	private String content;
	
	@NotBlank(message = "작성자를 입력하세요.")
	private String writer;
	
	List<BoardAttachmentVO> attaches;
	
	private Date regDate;
	private Date updateDate;
}
