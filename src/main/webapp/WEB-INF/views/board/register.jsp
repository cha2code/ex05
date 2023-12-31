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
			height : 300, // 에디터높이
			focus : true, // 에디터로딩후포커스를맞출지여부
			lang : "ko-KR",// 한글설정
		});
		
		const attaches = $('[name="files"]');
		const attachList = $('#attach-list');
		
		attaches.change(function(e) {
			let fileList = '';
			
			for(let file of this.files) {
				let fileStr = `
				<div>
					<i class="fa-solid fa-file"></i>
					\${file.name}(\${file.size.formatBytes()})
				</div>`;
				
				fileList += fileStr;
			}
			attachList.html(fileList);
		});
	});
	// 기본글꼴설정
	$('#content').summernote('fontName', 'Arial');
	
</script>

<br>

<%--개별페이지--%>
<h1 class="page-header">
	<i class="far fa-edit"></i> 게시글 작성
</h1>

<div class="panel panel-default">

	<div class="panel-body">
		<form:form modelAttribute="board" role="form"
		action="?_csrf=${_csrf.token}" enctype="multipart/form-data">

			<form:hidden path="writer" value="${username}"/>
			
			<div class="form-group">
				<form:label path="title">Title</form:label>
				<form:input path="title" cssClass="form-control"/>
				<form:errors path="title" cssClass="error"/>
			</div>
			
			<div class="form-group">
				<div id="file-list"></div>
				<label for="attaches">첨부파일</label>
				<div id="attach-list" class="my-1"></div>
				<input type="file" class="form-control" multiple name="files"/>
			</div>
			
			<div class="form-group">
				<form:label path="content">Content</form:label>
				<form:textarea path="content" cssClass="form-control"></form:textarea>
				<form:errors path="content" cssClass="error"/>
			</div>

			<button type="submit" class="btn btn-primary">
				<i class="fa-solid fa-check"></i> 확인
			</button>
			
			<button type="reset" class="btn btn-primary">
				<i class="fas fa-undo"></i> 취소
			</button>
			
			<!-- href:url이 아닌 javascript로 실행 -->
			<!-- 상황에 따라 적절하게 사용해야 함 (예외 상황도 있음) -->
			<a href="javascript:history.back()" class="btn btn-primary"> <i class="fas fa-list"></i> 목록</a>
		</form:form>
	</div>
</div>

<%@ include file="../layouts/footer.jsp"%>