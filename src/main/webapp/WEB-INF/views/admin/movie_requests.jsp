<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="dashboard.jsp"%>
<div class="table-header">
    <div class="search-wrap">
        <form action="<c:url value='/admin/movie_requests' />" method="get" id="searchForm">
            <select name="searchType" id="searchType" class="form-select search-select">
                <option value="title" ${currentSearchType eq 'title' ? 'selected' : ''}>제목</option>
                <option value="content" ${currentSearchType eq 'content' ? 'selected' : ''}>내용</option>
                <option value="userId" ${currentSearchType eq 'userId' ? 'selected' : ''}>작성자</option>
             
                </select>
            
            <input type="text" name="keyword" id="keyword" class="form-control search-input" placeholder="검색어를 입력해 주세요" value="${currentKeyword}">
            
            <button type="submit" class="btn btn-primary search-btn">검색</button>
            
             <select name="sortCriteria" id="sortCriteria" class="form-select sort-select" onchange="submitSort()">
                <option value="default">-- 정렬 기준 --</option>
               <option value="id" ${currentSortCriteria eq 'id' ? 'selected' : ''}>번호순</option>
    <option value="createdAt" ${currentSortCriteria eq 'createdAt' ? 'selected' : ''}>작성일순</option>
    <option value="processedAt" ${currentSortCriteria eq 'processedAt' ? 'selected' : ''}>처리일순</option>
                </select>
            
        </form>
    </div>
</div>
<div class="table-header">
	<button type="button" id="ApproveBtn" class="action-btn approve-btn"
		disabled onclick="handleBatchAction('update')">처리 완료</button>
	<button type="button" id="DeleteBtn" class="action-btn delete-btn"
		disabled onclick="handleBatchAction('delete')">삭제</button>
</div>

<div class="table-section">
	<table class="request-table">
		<thead>
			<tr>
				<th><input type="checkbox" id="checkAll"></th>
				<th>번호</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>처리일</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="movie_requests" items="${adminRequestList}">
				<tr>
					<td><input type="checkbox" name="requestIds"
						value="${movie_requests.id}" class="row-checkbox"
						${movie_requests.status eq 'approved' ? 'disabled' : ''}></td>
					<td>${movie_requests.id}</td>
					<td><a href="javascript:void(0);"
						onclick="showRequestDetail(${movie_requests.id})">${movie_requests.title}</a></td>
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
							<c:otherwise>-</c:otherwise>
						</c:choose></td>
					<td><c:choose>
							<c:when test="${movie_requests.status eq 'pending'}">
								<span class="status-badge pending">검토 대기</span>
							</c:when>
							<c:when test="${movie_requests.status eq 'approved'}">
								<span class="status-badge approved">처리 완료</span>
							</c:when>
							<c:otherwise>
								<span class="status-badge error">상태 오류</span>
							</c:otherwise>
						</c:choose><br>
						<button class="action-btn view-content-btn"
							onclick="showRequestDetail(${movie_requests.id})">내용보기</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<div id="requestDetailModal" class="modal">
	<div class="modal-content">
		<span class="close-btn" onclick="closeModal()">&times;</span>
		<h2>요청 상세 정보</h2>
		<div id="modalBodyContent"></div>
		<div class="modal-actions">
			<button class="action-btn approve-btn" onclick="approveFromModal()">처리
				완료</button>
			<button class="action-btn delete-btn" onclick="deleteFromModal()">삭제</button>
		</div>
	</div>
</div>
<input type="hidden" id="contextPath" value="<c:url value='/' />">
<script src="<c:url value='/resources/js/movie_requests.js' />"></script>
<script src="<c:url value='/resources/js/admin_search.js' />"></script>
<%@ include file="end.jsp"%>
