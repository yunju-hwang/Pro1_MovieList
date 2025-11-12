<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="dashboard.jsp"%>

<div class="table-section">
	<table class="inquiry-table">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>이메일</th>
				<th>작성일</th>      <th>답변일</th>      <th>상태</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="inquiry" items="${adminInquiriesList}">
				<tr>
					<td>${inquiry.id}</td>
					<td>${inquiry.title}</td>
					<td>${inquiry.userId}</td>
					<td>${inquiry.userEmail}</td>
					<td>
						<c:set var="createdAt" value="${fn:replace(inquiry.createdAt, 'T', ' ')}" />
						<c:out value="${fn:substring(createdAt, 0, 10)}" />
						<br>
						<c:out value="${fn:substring(createdAt, 11, 16)}" />
					</td>
					 <td>
						<c:choose>
							<c:when test="${inquiry.status eq 'answered'}">
								<c:set var="answeredAt" value="${fn:replace(inquiry.answeredAt, 'T', ' ')}" />
								<c:out value="${fn:substring(answeredAt, 0, 10)}" />
								<br>
								<c:out value="${fn:substring(answeredAt, 11, 16)}" />
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</td>
					
					<td>
						<c:choose>
							<c:when test="${inquiry.status eq 'pending'}">
								<span class="status-badge pending">답변 대기</span>
							</c:when>
							<c:when test="${inquiry.status eq 'answered'}">
								<span class="status-badge answered">답변 완료</span>
							</c:when>
							<c:otherwise>
								<span class="status-badge error">상태 오류</span>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:if test="${inquiry.status eq 'pending'}">
							<a href="<c:url value='/admin/inquiries/answerForm?id=${inquiry.id}' />" class="action-btn pending">답변하기</a>
						</c:if><c:if test="${inquiry.status eq 'answered'}">
							<a href="<c:url value='/admin/inquiries/answerForm?id=${inquiry.id}' />" class="action-btn answered-link">내용 보기</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="reply-section" id="replyForm" style="display: none;">
	<h3>답변 작성</h3>
	<textarea placeholder="답변 내용을 입력하세요" rows="8"></textarea>
	<div class="reply-actions">
		<button class="reply-submit-btn">답변 등록</button>
		<button class="reply-cancel-btn">취소</button>
	</div>
</div>

<%@ include file="end.jsp"%>
