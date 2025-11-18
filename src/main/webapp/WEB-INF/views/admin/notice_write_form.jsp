<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/admin/admin_navbar.jsp"%>
<link rel="stylesheet" href="<c:url value='/resources/css/admin_base.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/admin_form.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/admin_table.css' />">

<div class="notice-form-container">
	<h3>공지사항 등록</h3>
	<form action="<c:url value='/admin/notices/write' />" method="post"
		class="notice-form">
		<label for="title">제목</label> 
		<input type="text" id="title"
			name="title" placeholder="공지사항 제목을 입력하세요." required> 
			<label for="content">내용</label>
		<textarea id="content" name="content" placeholder="공지사항 내용을 입력하세요."
			required></textarea>
		<div class="action-buttons">
			<button type="button" class="cancel-btn"
				onclick="location.href='<c:url value='/admin/notices' />';">취소</button>
			<button type="submit" class="submit-btn"
				onclick="return confirm('공지사항을 등록하시겠습니까?');">등록 완료</button>
		</div>
	</form>
</div>
<%@ include file="end.jsp"%>