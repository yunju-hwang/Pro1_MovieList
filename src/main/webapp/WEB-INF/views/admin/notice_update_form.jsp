<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/admin/admin_navbar.jsp" %>
<link rel="stylesheet" href="<c:url value='/resources/css/admin_base.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/admin_form.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/admin_table.css' />">

<div class="notice-form-container">
    <h3>공지사항 수정</h3>
    <form action="<c:url value='/admin/notices/update' />" method="post" class="notice-form">
        <input type="hidden" name="id" value="${notices.id}">
        <label for="title">제목</label>
        <input type="text" id="title" name="title" value="${notices.title}" required>
        <label for="content">내용</label>
        <textarea id="content" name="content" required>${notices.content}</textarea>
        <div class="action-buttons">
        	<button type="button" class="cancel-btn" onclick="window.history.back();">취소</button>
        	<button type="submit" class="submit-btn">수정 완료</button>
        </div>
    </form>
</div>

<%@ include file="end.jsp"%>