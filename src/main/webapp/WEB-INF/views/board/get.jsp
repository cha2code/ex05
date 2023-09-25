<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../layouts/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="/resources/js/rest.js"></script>
<script src="/resources/js/comment.js"></script>

<script>

// 댓글 기본 URL 상수 (전역 상수)
const COMMENT_URL = '/api/board/${param.bno}/comment/';

// button event
$(document).ready(async function() {

	$('.remove').click(function(){
		if(!confirm('정말 삭제할까요?')) return;
		
		// form을 열어서 submit()호출
		document.forms.removeForm.submit();
	});	
	
	
	let bno = ${param.bno}; // 글 번호
	let writer = '${username}'; // 작성자 (로그인 유저)
	
	loadComments(bno, writer); // 댓글 목록 불러오기 (비동기 함수)
	
	// 댓글 추가 버튼
	$('.comment-add-btn').click(function(e) {
		createComment(bno, writer);
	});
	
	// 댓글 수정 버튼 on(이벤트명, 대상, 이벤트 핸들러) - 수정 화면 출력(위임)
	// comment-list : loadComments로 댓글을 불러옴
	$('.comment-list').on('click', '.comment-update-show-btn', showUpdateComment);
	
	// 수정 확인 버튼 클릭
	$('.comment-list').on('click', '.comment-update-btn', function(e){
		const el = $(this).closest('.comment');
		updateComment(el, writer);
	});
	
	// 수정 취소 버튼 클릭
	$('.comment-list').on('click', '.comment-update-cancel-btn', cancelCommentUpdate);

	// 삭제 버튼 클릭
	$('.comment-list').on('click', '.comment-delete-btn', deleteComment);
}); 

</script>

<br>

<h1 class="page-header">
	<i class="far fa-file-alt"></i> ${board.title}
</h1>
<div class="d-flex justify-content-between">
	<div>
		<i class="fas fa-user"></i> ${board.writer}
	</div>
	<div>
		<i class="fas fa-clock"></i>
		<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}" />
	</div>
</div>

<hr>

<div>${board.content}</div>

<!-- 새 댓글 작성 -->
<c:if test="${username  != board.writer}">
	<div class="bg-light p-2 rounded my-5">
		<div>${username == null ? '댓글을 작성하려면 먼저 로그인 하세요.' : '댓글 작성'}</div>
		
		<br>
		
		<div>
			<!-- textarea를 줄 바꿔서 코딩하면 화면에서 앞 뒤로 빈 칸이 삽입됨 !! 주의 !! -->
			<textarea class="form-control new-comment-content" rows="3" ${username == null ? 'disabled' : ''}></textarea>
			
			<br>
			
			<div class="text-right">
				<button class="btn btn-primary btn-sm my-2 comment-add-btn"
					${username == null? 'disabled' : ''}>
					<i class="fa-solid fa-check"></i> 확인
				</button>
			</div>	
		</div>
	</div>
</c:if>

<c:if test="${result=='success'}">
	<script>
		alert("수정이 완료되었습니다!");
	</script>
</c:if>

<div class="my-5">
	<i class="fa-regular fa-comment-dots"></i> 댓글 목록
	<hr>
	<div class="comment-list">
		<!-- 댓글 목록 출력 -->
		
	</div>
</div> 

<br>

<div class="mt-4">
	<a href="${cri.getLink('list')}" class="btn btn-primary list">
	<i class="fas fa-list"></i> 목록</a>
	
	<c:if test="${username == board.writer}">
		<a href="${cri.getLinkWithBno('modify', board.bno)}" class="btn btn-primary modify">
		<i class="far fa-edit"></i> 수정</a>
	
		<a href="#" class="btn btn-danger remove">
		<i class="far fa-trash-alt"></i> 삭제</a>
	</c:if>
</div>

<form action="remove" method="post" name="removeForm">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="bno" value="${board.bno }" />
	<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
	<input type="hidden" name="amount" value="${cri.amount}"/>
	<input type="hidden" name="type" value="${cri.type}" />
	<input type="hidden" name="keyword" value="${cri.keyword}" />
</form>

<!-- 

.attr() : attribute
.val() : value = input, textarea, select
.css() : style

 -->
<%@ include file="../layouts/footer.jsp"%>