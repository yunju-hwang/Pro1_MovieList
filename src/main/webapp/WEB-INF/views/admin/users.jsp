<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="dashboard.jsp"%>
<div class="table-section">
	<table class="user-table">
		<thead>
			<tr>
				<th>번호</th>
				<th>사용자 ID</th>
				<th>가입일</th>
				<th>리뷰 건수</th>
				<th>예매 건수</th>
				<th>문의 건수</th>
				<th>영화 요청 건수</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="users" items="${adminuserList}" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${users.user_id}</td>
					<td>${users.createdAt}</td>
					<td>${users.reviewCount}</td>
					<td>${users.reservationCount}</td>
					<td>${users.inquiryCount}</td>
					<td>${users.movieRequestCount}</td>
					<td><form action="<c:url value='/admin/users/delete' />"
							method="post">
							<input type="hidden" name="user_id" value="${users.user_id}">
							<button type="submit" class="action-btn delete-user-btn"
								onclick="return confirm('${users.user_id} 사용자를 정말로 삭제하시겠습니까?');"> 탈퇴
							</button>
						</form></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<%@ include file="end.jsp"%>
