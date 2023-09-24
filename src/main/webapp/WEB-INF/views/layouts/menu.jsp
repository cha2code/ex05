<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<nav class="navbar navbar-expand-md bg-primary navbar-dark sticky-top">
	<a class="navbar-brand" href="/">
	<i class="fa-solid fa-tree"></i> Christmas</a>
	
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="collapsibleNavbar">
	
		<!-- 좌측 메뉴 구성 -->
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="/board/list">
				<i class="fa-regular fa-rectangle-list"></i> 게시판</a>
			</li>
			
			<li class="nav-item"><a class="nav-link" href="/travel/list">
				<i class="fa-solid fa-suitcase-rolling"></i> 여행</a>
			</li>
		</ul>
		
		<!-- 우측 메뉴 -->
		<!-- 로그인 상태 -->	
		<ul class="navbar-nav ml-auto">
			<sec:authorize access="isAuthenticated()">
				<!-- 출력하지 말고 username으로 저장 -->
				<!-- principal = customUser -->
				<sec:authentication property="principal.username" var="username"/>
				<li class="nav-item">
					<a class="nav-link" href="/security/profile">
						<img src="/security/avatar/sm/${username}" class="avatar-sm" />
						<!-- 로그인 하지 않았을 때를 대비해서 바로 호출하면 안됨 -->
						<sec:authentication property="principal.username"/>
					</a>
				</li>
			
				<li class="nav-item">
					<a class="nav-link logout-link" href="#">
						<i class="fa-solid fa-right-from-bracket"></i> 로그아웃
					</a>
				</li>
			</sec:authorize>
			
			<!-- 로그아웃 상태 -->
			<sec:authorize access="isAnonymous()">
			<li class="nav-item">
				<a class="nav-link" href="/security/login">
					<i class="fa-solid fa-right-to-bracket"></i> login
				</a>
			</li>
			
			<li class="nav-item">
				<a class="nav-link" href="/security/signup">
					<i class="fa-solid fa-user-plus"></i> 회원가입
				</a>
			</li>
			</sec:authorize>
		</ul>
	</div>
</nav>

<!-- 화면에 나오지 않는 숨겨진 폼 = logout -->
<form id="logoutForm" action="/security/logout" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>

<script>
	$(document).ready(function(){
		$('.logout-link').click(function(e) {
			e.preventDefault(); // a 태그의 click 형식 변경
			$('#logoutForm').submit();
		});
	});
</script>