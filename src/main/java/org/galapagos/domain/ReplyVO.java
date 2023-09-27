package org.galapagos.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {

	private Long no;
	private Long cno; // comment의 no
	
	private String Writer;
	private String content;
	private Date regDate;
	private Date updateDate;
}
