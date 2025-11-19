<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="dashboard.jsp"%>
<div class="table-section">
	<table class="request-table">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>처리일</th>
				<th>상태</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>

			<c:forEach var="movie_requests" items="${adminRequestList}">
				<tr>
					<td>${movie_requests.id}</td>
					<td>${movie_requests.title}</td>
					<td>${movie_requests.content}</td>
					<td>${movie_requests.userId}</td>
					<td><c:set var="createdAt"
							value="${fn:replace(movie_requests.createdAt, 'T', ' ')}" /> <c:out
							value="${fn:substring(createdAt, 0, 10)}" /> <br> <c:out
							value="${fn:substring(createdAt, 11, 16)}" /></td>
					<td><c:choose>
							<c:when test="${movie_requests.status eq 'approved'}">
								<c:set var="processedAt"
									value="${fn:replace(movie_requests.processedAt, 'T', ' ')}" />
								<c:out value="${fn:substring(processedAt, 0, 10)}" />
								<br>
								<c:out value="${fn:substring(processedAt, 11, 16)}" />
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose></td>
					<td><c:choose>
							<c:when test="${movie_requests.status eq 'pending'}">
								<span class="status-badge pending">검토 대기</span>
							</c:when>
							<c:when test="${movie_requests.status eq 'approved'}">
								<span class="status-badge answered">처리 완료</span>
							</c:when>
							<c:otherwise>
								<span class="status-badge error">상태 오류</span>
							</c:otherwise>
						</c:choose></td>
					<td>
						<form action="<c:url value='/admin/movie_requests/update' />"
							method="post" style="display: inline-block;">
							<input type="hidden" name="id" value="${movie_requests.id}">
							<button type="submit" class="action-icon-btn check-btn"
								onclick="return confirm('${movie_requests.title} 요청을 정말로 처리 완료 하시겠습니까?');"
								<c:if test="${movie_requests.status eq '처리 완료'}">disabled</c:if>>
								<img
									src="${pageContext.request.contextPath}/resources/img/check_green.png"
									alt="확인 아이콘">
							</button>
						</form>
						<form action="<c:url value='/admin/movie_requests/delete' />"
							method="post" style="display: inline-block;">
							<input type="hidden" name="id" value="${movie_requests.id}">
							<button type="submit" class="action-icon-btn delete-btn"
								onclick="return confirm('${movie_requests.title} 요청을 정말로 삭제하시겠습니까?');">
								<img
									src="${pageContext.request.contextPath}/resources/img/close_red.png"
									alt="삭제 아이콘">
							</button>
						</form>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<%@ include file="end.jsp"%>
