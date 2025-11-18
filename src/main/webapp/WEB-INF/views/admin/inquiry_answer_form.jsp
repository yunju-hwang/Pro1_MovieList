<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/admin/admin_navbar.jsp" %>
<link rel="stylesheet" href="<c:url value='/resources/css/admin_base.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/admin_form.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/admin_table.css' />">
<div class="answer-container">
	<h3>${inquiry.id}번 문의 답변 작성</h3>
	<div class="original-inquiry">
		<h4>[${inquiry.status eq 'pending' ? '답변 대기' : '답변 완료'}] ${inquiry.title}</h4>
		<p>
			<strong>작성자:</strong> ${inquiry.userId} (${inquiry.userEmail})
		</p>
		<p>
			<strong>작성일:</strong> ${inquiry.createdAt}
		</p>
		<hr>
		<p>
			<strong>문의 내용:</strong>
		</p>
		<p>${inquiry.content}</p>

		<c:if test="${inquiry.status eq 'answered'}">
			<hr>
			<p>
				<strong>기존 답변 내용:</strong>
			</p>
			<p>${inquiry.answerContent}</p>
		</c:if>

	</div>

	<c:if test="${inquiry.status eq 'pending'}">
		<form action="<c:url value='/admin/inquiries/answer' />"
			method="post" class="answer-form">

			<input type="hidden" name="id" value="${inquiry.id}">

			<label for="answerContent">답변 내용</label>
			<textarea id="answerContent" name="answerContent"
				placeholder="답변 내용을 여기에 입력하세요." required></textarea>

			<div class="action-buttons">
				<button type="button" class="cancel-btn"
					onclick="window.history.back();">취소</button>

				<button type="submit" class="submit-btn"
					onclick="return confirm('답변을 등록하시겠습니까?');">답변 등록</button>
			</div>
		</form>
	</c:if>
	
	<c:if test="${inquiry.status eq 'answered'}">
		<div class="action-buttons">
			<button type="button" class="cancel-btn" onclick="window.history.back();">목록으로 돌아가기</button>
		</div>
	</c:if>

</div>

<%@ include file="end.jsp"%>