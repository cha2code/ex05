package org.galapagos.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class Criteria {

	private int pageNum; // 현재 페이지 번호
	private int amount; // 페이지당 출력할 데이터 개수
	private String type;
	private String keyword;

	public Criteria() {

		this(1, 10);
	}

	public Criteria(int pageNum) {

		this(pageNum, 10);
	}

	public Criteria(int pageNum, int amount) {

		this.pageNum = pageNum;
		this.amount = amount;

	}

	public int getOffset() {

		return (pageNum - 1) * amount;
	}

	public String[] getTypeArr() {
		return type == null ? new String[] {} : // 빈 배열 리턴
				type.split(""); // 한글자 단위로 분리된 배열 리턴
	}

	public String getLink(String base, int pageNum) {
		UriComponentsBuilder builder = 
				UriComponentsBuilder.fromPath(base)
				.queryParam("pageNum", pageNum)
				.queryParam("amount", amount)
				.queryParam("type", type)
				.queryParam("keyword", keyword);
		return builder.toUriString();
	}

	public String getLink() {
		return getLink("", pageNum);
	}

	public String getLink(int pageNum) {
		return getLink("", pageNum);
	}

	public String getLink(String base) {
		return getLink(base, pageNum);
	}

	public String getLinkWithBno(String base, Long bno) {
		return getLink(base, pageNum) + "&bno=" + bno;
	}
}

/*
 * 
 * Criteria
 * 
 * - JPQL을 생성하는 builder class - 프로그래밍 코드로 JPQL 사용이 가능 - parameter들을
 * controller에서 @RequestParam으로 일일이 전달하는 것이 효율적이지 못함 - 공통으로 사용할 수 있는 하나의 클래스로 위
 * 내용을 처리함 - 페이징 처리 시 사용
 * 
 */

/*
 * 
 * JPQL
 * 
 * - 테이블이 아닌 객체를 대상으로 검색하는 객체지향 쿼리 언어 - SQL이 추상화 되어 있기 때문에 특정 DB SQL에 의존하지 않음 -
 * 컴파일 시점에 오류 발견 가능 == 문자 기반 쿼리의 단점 - IDE 사용 시 코드 자동 완성을 지원 - 동적 쿼리를 작성하는 데
 * 효율적이지 못함 ex) 특정 조건이 참일 때 A SQL 쿼리, 거짓일 때 B SQL 쿼리 실행 등
 */

/*
 * 
 * .split()
 * 
 * - 문자열을 분할하는 메소드
 * 
 * - .split(separator, limit) : (분할 기준, 최대 분할 개수) ex) 쉼표 기준 분할 : ','
 * 
 * - limit는 선택 사항으로 값을 정하지 않으면 전체를 다 분할함
 * 
 */