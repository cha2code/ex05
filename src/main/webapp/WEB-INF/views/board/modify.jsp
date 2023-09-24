<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ include file="../layouts/header.jsp"%>

<!-- summernote -->
<link rel="stylesheet"
	href="/resources/css/summernote/summernote-lite.min.css">
<script src="/resources/js/summernote/summernote-lite.js"></script>
<script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<script>
$(document).ready(function() {
	$('#content').summernote({
		height: 300,                 // 에디터 높이
		focus : true, // 에디터 로딩후 포커스를 맞출지 여부
		lang: "ko-KR",					// 한글 설정
	});
	/*
	$('.get').click(function(){
		document.forms.getForm.submit();
	});	*/	
});

//기본 글꼴 설정
$('#summernote').summernote('fontName', 'Arial');

</script>

<h1 class="page-header"><i class="far fa-edit"></i> 게시글 수정</h1>

<div class="panel panel-default">
	<div class="panel-body">
		<form:form modelAttribute="board" role="form">
		
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			
			<form:hidden path="bno"/>
			<form:hidden path="writer" value="${username}"/>

			<div class="form-group">
				<label>Title</label> <input name="title" class="form-control"
					value="${board.title}" required>
			</div>
			
			<div class="form-group">
				<label>Content</label>
				<textarea name="content" class="form-control" id="content" rows="10">${board.content}</textarea>
			</div>

			<button type="submit" class="btn btn-primary">
				<i class="fas fa-check"></i>확인
			</button>
			
			<button type="reset" class="btn btn-primary">
				<i class="fas fa-undo"></i>취소
			</button>
			<a href="${cri.getLinkWithBno('get', board.bno)}" class="btn btn-primary get"> <i class="fas fa-list-alt"></i>돌아가기
			</a>
		</form:form>

	</div>
</div>

<%@ include file="../layouts/footer.jsp"%>