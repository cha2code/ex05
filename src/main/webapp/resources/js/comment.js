const commentUpdatable = `
<!-- backtick : 다중 문자열 리터럴 정의, 템플릿 문자열 -->

	<button class="btn btn-light btn-sm comment-update-show-btn">
	<i class="fa-solid fa-pen"></i> 수정
	</button>
					
	<button class="btn btn-light btn-sm comment-delete-btn">
	<i class="fa-solid fa-trash"></i> 삭제
	</button>
`;

function createCommentTemplate(comment, writer) {
	return `
	
	<div class="comment my-3" data-no="${comment.no}" data-writer="${comment.writer}">
		<div class="comment-title my-2 d-flex justify-content-between">
				
			<div>
				<strong class="writer">
					<img src="/security/avatar/sm/${comment.writer}" class="avatar-sm"> ${comment.writer}
				</strong>
					
				<span class="text-muted ml-3 comment-date">
					${moment(comment.regDate).format('YYYY-MM-DD hh:mm')} <!-- 날짜 -->
				</span>
			</div>
				
			<div class="btn-group">
				<!-- 로그인 유저 == 작성자이면 버튼을 출력, 아니면 빈 칸 출력 -->
				${writer && (writer == comment.writer) ? commentUpdatable : ''}
			</div>
			
		</div>
		
		<!-- el이 아니라 자바스크립트 코드 -->	
		<!-- comment-content 꼭 붙여서 사용. 안그러면 개행문자 출력 -->
		<div class="comment-body">
			<div class="comment-content">${comment.content}</div>
		</div>
			
		<div class="reply-list ml-5">
		
		</div>
			
	</div>
	`;
}

async function loadComments(bno, writer) {
<!-- (글 번호, 로그인 유저) -->

	let comments = [];

	// API로 불러오기
	comments = await rest_get(COMMENT_URL);
	
	for(let comment of comments) {
		const commentEl = createCommentTemplate(comment, writer);

		<!-- jQuary로 comment-list 선택 (get의 댓글 목록) -->
		<!-- prepend : 앞에 추가 / append : 뒤에 추가 -->
		$('.comment-list').append($(commentEl));
	}
}

async function createComment(bno, writer) {
	const content = $('.new-comment-content').val();
	
	if(!content) {
		alert('내용을 입력하세요');
		$('.new-comment-content').focus();
		
		return;
	}
	
	if(!confirm('댓글을 추가할까요?'))
		return;
	
	let comment = {bno, writer, content}
	console.log(comment);
	
	<!-- REST로 등록 -->
	comment = await rest_create(COMMENT_URL, comment);
	
	<!-- 등록 성공 후 DOM 처리 -->
	const commentEl = createCommentTemplate(comment, writer);
	$('.comment-list').prepend($(commentEl));
	
	<!-- 댓글 등록 후 textarea 칸을 비워줌 -->
	$('.new-comment-content').val('');
}

<!-- 댓글 수정 화면 -->
function createCommentEditTemplate(comment) {
	return `
	<div class="bg-light p-2 rounded comment-edit-block">
		<textarea class="form-control mb-1 comment-editor">${comment.content}</textarea>
		
		<div class="text-right">
			<button class="btn btn-light btn-sm py-1 comment-update-btn">
				<i class="fa-solid fa-check"></i> 확인
			</button>
			
			<button class="btn btn-light btn-sm py-1 comment-update-cancel-btn">
				<i class="fa-solid fa-xmark"></i> 취소
			</button>
		</div>
	</div>
	`;
}

<!-- 수정, 삭제 시 작성 칸 + 버튼 모두 hide 처리 후 작업 -->

<!-- 댓글 수정 화면 -->
function showUpdateComment(e) {

	<!-- closest(''):부모의 ''를 찾음 -->
	<!-- $(this)를 기준으로 comment 찾기 -->
	const commentEl = $(this).closest('.comment');
	
	<!-- .data:데이터를 저장하고 읽음 -->
	const no = commentEl.data("no");
	
	<!-- .find: 자식을 찾음 / html() 대신 text() 사용도 가능 -->
	const contentEl = commentEl.find('.comment-content');
	const comment = {no, content : contentEl.html()};
	
	contentEl.hide();
	commentEl.find('.btn-group').hide();
	
	const template = createCommentEditTemplate(comment);
	const el = $(template);
	
	commentEl.find('.comment-body').append(el);
	
	console.log(comment);
}

<!-- 댓글 수정하기 -->
async function updateComment(commentEl, writer) {
	if(!confirm('수정하시겠습니까?'))
		return;
	
	<!-- 수정 창(제거를 위해 필요) -->
	const editContentEl = commentEl.find('.comment-edit-block');
	
	<!-- 수정 내용 (comment-editor == textarea) -->
	const content = editContentEl.find('.comment-editor').val();
	
	<!-- 문자열이면 ""가 jsp에 같이 넘어가기 때문에 int로 변경 -->
	const no = parseInt(commentEl.data("no"));
	
	let comment = {no, writer, content};
	console.log('수정', comment);
	
	<!-- COMMENT UPDATE API 추가 -->
	comment = await rest_modify(COMMENT_URL + comment.no, comment);

	const contentEl = commentEl.find('.comment-content');
	
	<!-- remove:DOM에서 아예 제거(화면에서 삭제) -->
	editContentEl.remove();
	
	<!-- 변경된 내용으로 화면 내용 수정 -->
	<!-- 숨겨 놓은 버튼, 칸 다시 출력 -->
	contentEl.html(comment.content);
	contentEl.show();
	contentEl.find('.btn-group').show();
}

<!-- 댓글 수정 취소 -->
function cancelCommentUpdate(e) {
	const commentEl = $(this).closest('.comment');
	
	<!-- .css('display', 'block') == show() : 두가지 모두 자주 사용함 -->
	<!-- block 대신 none 사용 시 : hide()와 같음 -->
	commentEl.find('.comment-content').css('display', 'block');
	
	commentEl.find('.comment-edit-block').remove();
	commentEl.find('.btn-group').show();
}

<!-- 댓글 삭제 -->
async function deleteComment(e) {
	if(!confirm('댓글을 삭제할까요?'))
		return;
		
	const comment = $(this).closest('.comment')
	const no = comment.data("no");
	
	<!-- 리턴을 받지 않더라도 await는 붙여야 함 -->
	<!-- 삭제는 body가 없기 때문에 url과 댓글 번호만 넘김 -->
	await rest_delete(COMMENT_URL + no);
	
	<!-- DB에서 삭제되었을 때 comment를 지워버림 -->
	comment.remove();
}