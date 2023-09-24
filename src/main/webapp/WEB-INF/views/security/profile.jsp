<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../layouts/header.jsp"%>

<div style="width: 500px" class="mx-auto">

<br>

	<sec:authentication property="principal.member" var="member" />

	<h1>
		<i class="fa-regular fa-address-card"></i> Profile
	</h1>

	<hr>

	<div class="d-flex my-3 align-items-center">
		<div>
			<img src="/security/avatar/lg/${member.username}" />
		</div>

		<br>

		<div class="ml-4">

			<div>
				<i class="fa-solid fa-user"></i> User ID<br> ${member.username}
			</div>
			
			<br>

			<div>
				<i class="fa-solid fa-envelope"></i> User E-mail<br>
				${member.email}
			</div>
			
			<br>

			<div>
				<i class="fa-regular fa-calendar-days"></i> Date of membership<br>
				<fmt:formatDate value="${member.regDate}" pattern="yyyy-MM-dd HH:mm" />
			</div>

		</div>
	</div>
</div>

<%@ include file="../layouts/footer.jsp"%>