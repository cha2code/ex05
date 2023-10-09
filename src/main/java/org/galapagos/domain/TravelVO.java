package org.galapagos.domain;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import lombok.Data;

@Data
public class TravelVO {
	
	private Long no;
	private String region;
	private String title;
	private String description;
	private String address;
	private String phone;
	private String hearts;
	private Boolean myHeart;
	
	// 첫 페이지에 나올 랜덤한 사진 5장
	public String getImage() {
		int i = new Random().nextInt(5) + 1;
		
		return String.format("/resources/images/travel/%03d-%d.jpg", no, i);
	}
	
	// 상세페이지에 들어갈 사진
	public List<String> getImages(){
		
		List<String> list = new ArrayList<String>();
		
		for(int i = 1; i <= 5; i++) {
			list.add(String.format("/resources/images/travel/%03d-%d.jpg", no, i));
		}
		
		return list;
	}
	
	// 카드 하단 설명 부분 요약
	public String getSummary() {
		
		// summernote에서 수정 시 자동으로 p태그가 붙어 css가 적용 불가되므로 제거함
		return description.split("<br>")[0].replace("<p>","");
	}
}
