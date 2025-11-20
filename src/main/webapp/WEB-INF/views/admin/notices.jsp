<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/WEB-INF/views/admin/admin_navbar.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 관리</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/admin_base.css' />">
	<link rel="stylesheet" href="<c:url value='/resources/css/admin_form.css' />">
	<link rel="stylesheet" href="<c:url value='/resources/css/admin_table.css' />">

</head>
<body>
    <div class="dashboard-container">
        <div class="main-content">
            <h2 class="content-title">공지사항 관리</h2>
            <div class="table-header">
                <a href="<c:url value='/admin/notices/write' />" class="register-btn">공지사항 등록</a>
            </div>
            <div class="table-section">
                <table class="notice-table">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성일</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="notices" items="${adminNoticesList}">
                        <tr>
                            <td>${notices.id }</td>
                            <td><a href="<c:url value='/admin/notices/update?id=${notices.id}' />">${notices.title}</a></td>
                            <td><c:set var="createdAt" value="${fn:replace(notices.createdAt, 'T', ' ')}" />
						<c:out value="${fn:substring(createdAt, 0, 10)}" />
						<br>
						<c:out value="${fn:substring(createdAt, 11, 16)}" /></td>
                            <td>
                                <a href="<c:url value='/admin/notices/update?id=${notices.id}' />" class="action-btn edit-btn">수정</a>
                                <form action="<c:url value='/admin/notices/delete' />" method="post" style="display: inline-block;">
										<input type="hidden" name="id" value="${notices.id}">
										<button type="submit" class="action-btn delete-btn" 
                                        onclick="return confirm('${notices.id}번 공지사항을 정말로 삭제하시겠습니까?');">삭제</button>
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