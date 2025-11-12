<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="dashboard.jsp"%>
<div class="table-section">
	<table class="review-table">
		<thead>
			<tr>
				<th>번호</th>
				<th>영화 제목</th>
				<th>작성자</th>
				<th>리뷰 내용</th>
				<th>평점</th>
				<th>감정</th>
				<th>작성날짜</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="reviews" items="${adminReviewsList}">
				<tr>
					<td>${reviews.id}</td>
					<td>${reviews.movieTitle}</td>
					<td>${reviews.userId}</td>
					<td>${reviews.content}</td>
					<td><span class="star-rating"> <c:set var="rating"
								value="${reviews.rating}" /> <c:forEach begin="1"
								end="${rating}">⭐️</c:forEach>
					</span></td>
					<td><c:choose>
							<c:when test="${reviews.sentiment ge 4}">
								<span class="sentiment-badge positive">긍정</span> </c:when>
							<c:when test="${reviews.sentiment le 2}">
								<span class="sentiment-badge negative">부정</span> </c:when>
							<c:otherwise>
								<span class="sentiment-badge neutral">중립</span> </c:otherwise>
						</c:choose></td>
					<td><c:set var="createdAt"
							value="${fn:replace(reviews.createdAt, 'T', ' ')}" /> <c:out
							value="${fn:substring(createdAt, 0, 10)}" /> <br> <c:out
							value="${fn:substring(createdAt, 11, 16)}" /></td>
					<td>
						<form action="<c:url value='/admin/reviews/delete' />" method="post">
							<input type="hidden" name="id" value="${reviews.id}">
							<button type="submit" class="action-icon-btn"
								onclick="return confirm('${reviews.id}번 리뷰를 정말로 삭제하시겠습니까?');">
								<img
									src="${pageContext.request.contextPath}/resources/img/trash_red.png"
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
