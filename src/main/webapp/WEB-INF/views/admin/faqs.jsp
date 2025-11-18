<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- 네비게이션 바는 dashboard.jsp처럼 상단에 포함 --%>
<%@ include file="/WEB-INF/views/admin/admin_navbar.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ 관리</title>
	<link rel="stylesheet" href="<c:url value='/resources/css/admin_base.css' />">
	<link rel="stylesheet" href="<c:url value='/resources/css/admin_form.css' />">
	<link rel="stylesheet" href="<c:url value='/resources/css/admin_table.css' />">
</head>
<body>
    <div class="dashboard-container">
        <div class="main-content">
            <h2 class="content-title">FAQ 관리</h2>

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
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="faqs" items="${adminFaqsList}">
                        <tr>
                            <td>${faqs.id }</td>
                            <td>${faqs.category }</td>
                            <td><a href="<c:url value='/admin/faqs/update?id=${faqs.id}' />">${faqs.question}</a></td>
                            <td>
                                <a href="<c:url value='/admin/faqs/update?id=${faqs.id}' />" class="action-btn edit-btn">수정</a>
                                
                                <form action="<c:url value='/admin/faqs/delete' />" method="post" style="display: inline-block;">
                                    <input type="hidden" name="id" value="${faqs.id}">
                                    <button type="submit" class="action-btn delete-btn" 
                                        onclick="return confirm('${faqs.id}번 FAQ를 정말로 삭제하시겠습니까?');">삭제</button>
                                </form>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="pagination-area">
            </div>

        </div>
    </div>
</body>
</html>