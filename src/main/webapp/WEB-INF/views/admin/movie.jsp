<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="dashboard.jsp"%>
<div class="table-section">
	<table class="movie-table">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>장르</th>
				<th>평점</th>
				<th>상영시간</th>
				<th>긍정리뷰</th>
				<th>부정리뷰</th>
				<th>개봉일</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="movie" items="${adminmovieList}" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${movie.title}</td>
					<td>${movie.genres2}</td>
					<td>${movie.rating}</td>
					<td>${movie.runtime}분</td>
					<td>${movie.positiveReviewCount}개</td>
					<td>${movie.negativeReviewCount}개</td>
					<td>${movie.releaseDate}</td>
					<td>
						<form action="<c:url value='/admin/movie/delete' />" method="post">
							<input type="hidden" name="tmdbId" value="${movie.tmdbId}">
							<button type="submit" class="action-icon-btn"
								onclick="return confirm('${movie.title} 영화를 정말로 삭제하시겠습니까?');">
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

</div>
</div>
<%@ include file="end.jsp"%>
