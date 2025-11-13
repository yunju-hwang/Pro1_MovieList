<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <%@ include file="dashboard.jsp"%> --%>
<%@ include file="/WEB-INF/views/admin/admin_navbar.jsp" %>
<style>
body {
    margin: 0; /* 기본 여백 제거 */
    padding: 0; /* 기본 패딩 제거 */
    width: 100%; /* 너비를 100%로 확실히 지정 */
    /* 아래는 선택적이지만, 모든 요소를 제어하기 쉽게 함 */
    box-sizing: border-box; 
}

/* 답변 폼 전용 스타일 (필요하다면 CSS 파일에 통합) */
.answer-container {
	padding: 20px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	max-width: 800px;
	margin: 20px auto;
}

.original-inquiry {
	margin-bottom: 30px;
	padding: 15px;
	border: 1px solid #e0e0e0;
	border-radius: 4px;
	background-color: #f9f9f9;
}

.original-inquiry h4 {
	margin-top: 0;
	color: #333;
	border-bottom: 2px solid #ddd;
	padding-bottom: 10px;
}

.original-inquiry p {
	margin-bottom: 5px;
	line-height: 1.6;
}

.answer-form textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	resize: vertical;
	min-height: 200px;
	box-sizing: border-box;
}

.action-buttons {
	margin-top: 20px;
	text-align: right;
}

.action-buttons button {
	padding: 10px 15px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin-left: 10px;
	font-weight: bold;
}

.submit-btn {
	background-color: #007bff; /* 파란색 계열 */
	color: white;
}

.cancel-btn {
	background-color: #6c757d; /* 회색 계열 */
	color: white;
}
</style>

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