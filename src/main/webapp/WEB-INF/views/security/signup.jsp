<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ include file="../layouts/header.jsp" %>

<br>

<div style="width: 500px" class="mx-auto">

<h1><i class="fa-solid fa-user-plus"></i> 회원가입</h1>

<hr>

<div>
	<!-- action은 현재 url로, method는 post로 전송 -->
	<!-- 파일 업로드를 위해 인코딩을 multipart로 변경했기 때문에 action에 넣음 -->
	<form:form modelAttribute="member" 
		action="/security/signup?_csrf=${_csrf.token}"
		enctype="multipart/form-data">

			<div class="form-group">
				<form:label path="username"><i class="fa-solid fa-user"></i> User ID </form:label>
				<form:input path="username" cssClass="form-control"/>
				<form:errors path="username" cssClass="error"/>
			</div>
	
			<div class="form-group">
				<form:label path="password"><i class="fa-solid fa-lock"></i> password </form:label>
				<form:password path="password" cssClass="form-control"/>
				<form:errors path="password" cssClass="error"/>
			</div>
		
			<div class="form-group">
				<form:label path="password2"><i class="fa-solid fa-lock"></i> Check the password </form:label>
				<form:password path="password2" cssClass="form-control"/>
				<form:errors path="password2" cssClass="error"/>
			</div>
		
			<div class="form-group">
				<form:label path="email"><i class="fa-solid fa-envelope-open-text"></i> E-mail </form:label>
				<form:input path="email" cssClass="form-control"/>
				<form:errors path="email" cssClass="error"/>
			</div>
			
			<!-- default = file 1개 선택 가능 -->
			<!-- DB와 직접적 연관이 없기 때문에 VO가 아닌 다른 곳에 처리 - securityController의 signUp -->
			<input type="file" name="avatar"/>
		
			<div class="btn">
				<button type="submit" class="btn btn-primary btn-block">
            	    <i class="fa-solid fa-right-to-bracket"></i> SignUp
        	    </button>
   	    	</div>

		</form:form>
	</div>
</div>

<%@ include file="../layouts/footer.jsp" %>