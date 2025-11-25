<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 상세</title>
<link rel="stylesheet" href="<c:url value='/resources/css/inquiry_detail.css?after' />">
</head>
<body>
<div class="container">
    
<h2>문의 상세</h2>

<div class="question_box">
    <p><strong>제목</strong> : ${inq.title}</p>
    <p><strong>내용</strong> : ${inq.content}</p>
    <p class="created_date">작성일: ${createdDate}</p>
</div>

<div class="line"></div>

<c:choose>
    <c:when test="${not empty inq.answerContent}">
        <div class="answer_box">
            <p class="answer_title">답변</p>
            <p class="answer_content">${inq.answerContent}</p>
            <p class="answer_date">답변일: ${answeredDate}</p>
        </div>
    </c:when>
    <c:otherwise>
        <p class="no_answer">아직 답변이 없습니다.</p>
    </c:otherwise>
</c:choose>
</div>
</body>
</html>