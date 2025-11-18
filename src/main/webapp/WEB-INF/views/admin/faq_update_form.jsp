<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/admin/admin_navbar.jsp" %>
<link rel="stylesheet" href="<c:url value='/resources/css/admin_base.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/admin_form.css' />">
<link rel="stylesheet" href="<c:url value='/resources/css/admin_table.css' />">
<div class="faq-form-container">
    <h3>FAQ 수정</h3>
    <form action="<c:url value='/admin/faqs/update' />" method="post" class="faq-form">
        <input type="hidden" name="id" value="${faqs.id}"> <label for="category">카테고리</label>
        <select id="category" name="category" required>
            <option value="예매/결제" ${faqs.category eq '예매/결제' ? 'selected' : ''}>예매/결제</option>
            <option value="회원정보" ${faqs.category eq '회원정보' ? 'selected' : ''}>회원정보</option>
            </select>

        <label for="question">질문</label>
        <input type="text" id="question" name="question" value="${faqs.question}" required>

        <label for="answer">답변 내용</label>
        <textarea id="answer" name="answer" required>${faqs.answer}</textarea>

        <div class="action-buttons">
        	<button type="button" class="cancel-btn" onclick="window.history.back();">취소</button>
        	<button type="submit" class="submit-btn">수정 완료</button>
        </div>
    </form>
</div>

<%@ include file="end.jsp"%>