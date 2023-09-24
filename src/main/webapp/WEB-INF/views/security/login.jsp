<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../layouts/header.jsp" %>

<br>

<div style="width: 500px" class="mx-auto">

<h1><i class="fa-solid fa-right-to-bracket"></i> login</h1>

<hr>

<c:if test="${param.error == 'true'}">
	<div class="error">
		사용자 ID 또는 Password가 일치하지 않습니다.
	</div>
</c:if>

<c:if test="${param.error == 'login_required'}">
	<div class="error">
		로그인이 필요한 서비스입니다.
	</div>
</c:if>

<br>

	<!-- action = SecurityConfig에서 정해 놓은 url -->
	<form action="/security/login" method="post">

		<!-- csrf token -->
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	
		<div class="form-group">
			<label for="username"><i class="fa-solid fa-user"></i> User ID</label>
			<br> 
			<input type="text" name="username" style="width: 500px"/>
			<br><br>
		</div>
	
		<div class="form-group">
			<label for="password"><i class="fa-solid fa-lock"></i> Password</label>
			<br>
			<input type="password" name="password" style="width: 500px"/>
			<br><br>
		</div>
	
		<div class="form-group form-check">
			<label class="form-check-label">
				<input class="form-check-input" type="checkbox" name="remember-me" /> 로그인 유지
			</label>
		</div>
	
		<div class="btn">
			<button type="submit" class="btn btn-primary btn-block">
                <i class="fa-solid fa-right-to-bracket"></i> login
        	</button>
   	    </div>
	
	</form>
</div>

<%@ include file="../layouts/footer.jsp" %>