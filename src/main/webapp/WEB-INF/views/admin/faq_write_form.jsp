<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/admin/admin_navbar.jsp"%>
<link rel="stylesheet"
	href="<c:url value='/resources/css/admin_base.css' />">
<link rel="stylesheet"
	href="<c:url value='/resources/css/admin_form.css' />">
<link rel="stylesheet"
	href="<c:url value='/resources/css/admin_table.css' />">
<div class="faq-form-container">
	<h3>FAQ 등록</h3>
	<form action="<c:url value='/admin/faqs/write' />" method="post"
		class="faq-form">
		<label for="category">카테고리</label> <select id="category"
			name="category" required>
			<option value="">카테고리 선택</option>
			<option value="예매/결제">예매/결제</option>
			<option value="회원정보">회원정보</option>
			<option value="영화">영화</option>
			<option value="test">test</option>
		</select> <label for="question">질문</label> <input type="text" id="question"
			name="question" placeholder="FAQ 질문을 입력하세요." required> <label
			for="answer">답변 내용</label>
		<textarea id="answer" name="answer" placeholder="FAQ 답변 내용을 입력하세요."
			required></textarea>
		<div class="action-buttons">
			<button type="button" class="cancel-btn"
				onclick="location.href='<c:url value='/admin/faqs' />';">취소</button>
			<button type="submit" class="submit-btn"
				onclick="return confirm('FAQ를 등록하시겠습니까?');">등록 완료</button>
		</div>
	</form>
</div>
<%@ include file="end.jsp"%>