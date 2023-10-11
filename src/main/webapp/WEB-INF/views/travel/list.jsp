<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../layouts/header.jsp" %>

<script src="../resources/js/search.js"></script>

<c:if test="${not empty username}">
	<style>
		.fa-heart {
			cursor: pointer;
		}
	</style>

	<script src="../resources/js/rest.js"></script>
	<script>
		$(document).ready(function() {
		
			let username = '${username}';
			const BASE_URL = '/api/travel/heart';
		
			// 좋아요 추가
			$('span.heart').on('click', '.fa-heart.fa-regular', async function(e){
				
				let tno = parseInt($(this).data("tno"));
				let heart = {tno, username};
				console.log(heart);
				
				await rest_create(BASE_URL + "/add", heart);
				
				let heartCount = $(this).parent().find(".heart-count");
				console.log(heartCount);
				
				let count = parseInt(heartCount.text());
				heartCount.text(count+1);
				
				$(this)
					.removeClass('fa-regular')
					.addClass('fa-solid');
			});
			
			// 좋아요 제거
			$('span.heart').on('click', '.fa-heart.fa-solid', async function(e){
				
				let tno = parseInt($(this).data("tno"));
				
				await rest_delete(
						`\${BASE_URL}/delete?tno=\${tno}&username=\${username}`);
				
				let heartCount = $(this).parent().find(".heart-count");
				console.log(heartCount);
				
				let count = parseInt(heartCount.text());
				heartCount.text(count-1);
				
				$(this)
					.removeClass('fa-solid')
					.addClass('fa-regular');
			});
		});
	</script>
</c:if>

<!-- 가로줄 긋기 -->
<hr>

<%-- 개별 페이지 --%>
<h1>100대 관광지</h1>

<div class="d-flex justify-content-between align-items-center my-4">
	<div>총 ${pageMaker.total} 건 ( ${pageMaker.cri.pageNum} ..
		${pageMaker.totalPage })</div>

	<br>
	
<!-- 페이지 처리 -->
	<div>
		<form id="searchForm" method="get" class="d-flex">
			<input type="hidden" name="pageNum" value="1"> <select
				name="type" class="form-select rounded-0 ml-1">
				<option value="" ${pageMaker.cri.type == null ? 'selected' : ''}>-- 검색대상선택 --</option>
				<option value="R" ${pageMaker.cri.type eq 'R' ? 'selected' : ''}>권역</option>
				<option value="T" ${pageMaker.cri.type eq 'T' ? 'selected' : ''}>제목</option>
				<option value="D" ${pageMaker.cri.type eq 'D' ? 'selected' : ''}>내용</option>
				
				<option value="TD" ${pageMaker.cri.type eq 'TD' ? 'selected' : ''}>제목+내용</option>
				<option value="TR" ${pageMaker.cri.type eq 'TR' ? 'selected' : ''}>권역+제목</option>
				<option value="RTD" ${pageMaker.cri.type eq 'RTD' ? 'selected' : ''}>권역+제목+내용</option>
				<!--search.jsp형태로 만들어 common에 넣을 수 있음  -->
			</select>
			<div class="input-group">
				<input type="text" name="keyword" class="form-control rounded-0"
					value="${pageMaker.cri.keyword}" />
				<button type="submit" class="btn btn-success rounded-0">
					<i class="fa-solid fa-magnifying-glass"></i> 검색
				</button>
			</div>
		</form>

	</div>
</div>

<div class="row">
	<c:forEach var="travel" items="${list}">
		<div class="col-md-4 mb-3">
			<div class="card" style="width:100%">
				<a href="${cri.getLink('get')}&no=${travel.no}">
					<img class="card-img-top" src="${travel.image}" alt="${travel.title}">
				</a>
				
				<div class="card-body">
					<h4 class="card-title">
						<a href="${cri.getLink('get')}&no=${travel.no}">
							${travel.title}
						</a>
					</h4>
					
					<span class="heart">
						<i class="${travel.myHeart ? 'fa-solid' : 'fa-regular'} fa-heart text-danger"
						data-tno="${travel.no}"></i>
						
						<span class="heart-count">${travel.hearts}</span>
					</span>
					<p class="card-text">${travel.summary}</p>
				</div>
			</div>
		</div>
	</c:forEach>
</div>

<sec:authorize access="hasRole('ROLE_MANAGER')">
	<div class="text-right">
		<a href="register" class="btn btn-dark"> <i class="far fa-edit"></i> 추가</a>
	</div>
</sec:authorize>

<%@include file="../common/pagination.jsp"%>

<%@ include file="../layouts/footer.jsp" %>