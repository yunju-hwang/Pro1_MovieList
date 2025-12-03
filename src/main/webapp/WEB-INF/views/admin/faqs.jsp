<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/admin/admin_navbar.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html lang="ko">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="<c:url value='/resources/css/admin_base.css' />">
<link rel="stylesheet"
	href="<c:url value='/resources/css/admin_form.css' />">
<link rel="stylesheet"
	href="<c:url value='/resources/css/admin_table.css' />">
<body>
	<div class="dashboard-container">
		<div class="main-content">
			<h2 class="content-title"><a href="<c:url value='/admin/faqs' />">FAQ 관리</a></h2>
<div class="table-header">
    <div class="search-wrap">
        <form action="<c:url value='/admin/faqs' />" method="get" id="searchForm">
            <select name="searchType" id="searchType" class="form-select search-select">
				<option value="category" ${currentSearchType eq 'category' ? 'selected' : ''}>카테고리</option>
                <option value="question" ${currentSearchType eq 'question' ? 'selected' : ''}>질문</option>
                <option value="createdAt" ${currentSearchType eq 'createdAt' ? 'selected' : ''}>작성일</option>
                </select>
            <input type="text" name="keyword" id="keyword" class="form-control search-input" placeholder="내용을 입력해 주세요" value="${currentKeyword}">
            <button type="submit" class="btn btn-primary search-btn">검색</button>
           
             <select name="sortCriteria" id="sortCriteria" class="form-select sort-select" onchange="submitSort()">
            <option value="default">-- 정렬 기준 --</option>
            <option value="category" ${currentSortCriteria eq 'category' ? 'selected' : ''}>카테고리</option>
    		<option value="createdAt" ${currentSortCriteria eq 'createdAt' ? 'selected' : ''}>작성일</option>
                </select>
            
        </form>
    </div>
</div>
			<div class="table-header">
				<a href="<c:url value='/admin/faqs/write' />" class="register-btn">FAQ 등록</a>
			</div>

			<div class="table-section">
				<table class="faq-table">
					<thead>
						<tr>
							<th>번호</th>
							<th>카테고리</th>
							<th>질문</th>
							<th>작성일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="faqs" items="${adminFaqsList}">
							<tr>
								<td>${faqs.id }</td>
								<td>${faqs.category }</td>
								<td><a
									href="<c:url value='/admin/faqs/update?id=${faqs.id}' />">${faqs.question}</a></td>
								<td><c:set var="createdAt"
										value="${fn:replace(faqs.createdAt, 'T', ' ')}" /> <c:out
										value="${fn:substring(createdAt, 0, 10)}" /> <br> <c:out
										value="${fn:substring(createdAt, 11, 16)}" /></td>
								<td><a
									href="<c:url value='/admin/faqs/update?id=${faqs.id}' />"
									class="action-btn edit-btn">수정</a>
									<form action="<c:url value='/admin/faqs/delete' />"
										method="post" style="display: inline-block;">
										<input type="hidden" name="id" value="${faqs.id}">
										<button type="submit" class="action-btn delete-btn"
											onclick="return confirm('${faqs.id}번 FAQ를 정말로 삭제하시겠습니까?');">삭제</button>
									</form></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<div class="pagination-area"></div>

		</div>
	</div>
	<script src="<c:url value='/resources/js/admin_search.js' />"></script>
	<%@ include file="end.jsp"%>