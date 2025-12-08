<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="dashboard.jsp"%>
<input type="hidden" id="contextPath" value="<c:url value='/' />">
<div class="table-header">
    <div class="search-wrap">
        <form action="<c:url value='/admin/reviews' />" method="get" id="searchForm">
            <select name="searchType" id="searchType" class="form-select search-select">
                <option value="title" ${currentSearchType eq 'title' ? 'selected' : ''}>제목</option>
                <option value="userId" ${currentSearchType eq 'userId' ? 'selected' : ''}>작성자</option>
                <option value="content" ${currentSearchType eq 'content' ? 'selected' : ''}>내용</option>
                </select>
            <input type="text" name="keyword" id="keyword" class="form-control search-input" placeholder="제목을 입력해 주세요" value="${currentKeyword}">
            <button type="submit" class="btn btn-primary search-btn">검색</button>
           
             <select name="sortCriteria" id="sortCriteria" class="form-select sort-select" onchange="submitSort()">
            <option value="default">-- 정렬 기준 --</option>
            <option value="createdAt" ${currentSortCriteria eq 'createdAt' ? 'selected' : ''}>작성일순</option>
    		<option value="rating" ${currentSortCriteria eq 'rating' ? 'selected' : ''}>평점순</option>
                </select>
            
        </form>
    </div>
</div>


<div class="table-section">
	<table class="review-table">
		<thead>
			<tr>
				<th>번호</th>
				<th>영화 제목</th>
				<th>작성자</th>
				<th>리뷰 내용</th>
				<th>평점</th>
				<th>작성날짜</th>
				<th>상세보기</th>
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
					<td><c:set var="createdAt"
							value="${fn:replace(reviews.createdAt, 'T', ' ')}" /> <c:out
							value="${fn:substring(createdAt, 0, 10)}" /> <br> <c:out
							value="${fn:substring(createdAt, 11, 16)}" /></td>
					<td>
						<button class="action-btn view-content-btn"
							onclick="openReviewDetail(${reviews.id})">상세보기</button>
					</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>
</div>
<div id="reviewDetailModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeReviewModal()">&times;</span> <h2>리뷰 상세 정보</h2>
        
        <div class="modal-body" id="modalBodyContent">
            </div>
        
        <div class="modal-actions"> 
            <button class="action-btn delete-btn" onclick="deleteFromReviewModal()" disabled>삭제하기</button>
        </div>
    </div>
</div>
<script src="<c:url value='/resources/js/admin_reviews.js' />"></script>
<script src="<c:url value='/resources/js/admin_search.js' />"></script>
<%@ include file="end.jsp"%>
