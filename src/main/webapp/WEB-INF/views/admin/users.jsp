<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="dashboard.jsp"%>
<div class="table-header">
    <div class="search-wrap">
        <form action="<c:url value='/admin/users' />" method="get" id="searchForm">
            <input type="hidden" name="searchType" value="user_id">
            <input type="text" name="keyword" id="keyword" class="form-control search-input" placeholder="아이디를 입력해 주세요" value="${currentKeyword}">
            <button type="submit" class="btn btn-primary search-btn">검색</button>
            
             <select name="sortCriteria" id="sortCriteria" class="form-select sort-select">
                <option value="default">-- 정렬 기준 --</option>
                <option value="createdAt" ${currentSortCriteria eq 'createdAt' ? 'selected' : ''}>가입일순</option>
   				<option value="reviewCount" ${currentSortCriteria eq 'reviewCount' ? 'selected' : ''}>리뷰순</option>
    			<option value="reservationCount" ${currentSortCriteria eq 'reservationCount' ? 'selected' : ''}>예매순</option>
    			<option value="inquiryCount" ${currentSortCriteria eq 'inquiryCount' ? 'selected' : ''}>문의순</option>
    			<option value="movieRequestCount" ${currentSortCriteria eq 'movieRequestCount' ? 'selected' : ''}>영화요청순</option>
                </select>
        </form>
    </div>
</div>


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
<script src="<c:url value='/resources/js/admin_search.js' />"></script>
<%@ include file="end.jsp"%>
