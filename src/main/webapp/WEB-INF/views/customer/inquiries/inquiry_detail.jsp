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

<div class="detail-container">

    <!-- 헤더 영역 -->
    <div class="header">
        <img src="<c:url value='/resources/img/message.png'/>" class="title-icon">
        <h2 class="title-text">문의 상세</h2>
    </div>

    <!-- 문의 내용 박스 -->
    <div class="box question">
        <div class="box-header">📝 문의내용</div>
        <div class="box-body">
            <p><strong>제목</strong> : ${inq.title}</p>
            <p><strong>내용</strong> : ${inq.content}</p>
        </div>
        <p class="date">작성일 : ${createdDate}</p>
    </div>

    <!-- 구분선 -->
    <div class="divider"></div>

    <!-- 답변 영역 -->
    <c:choose>
        <c:when test="${not empty inq.answerContent}">
            <div class="box answer">
    <div class="box-header green">💬 답변완료</div>
    <div class="box-body">
        <p>${inq.answerContent}</p>
    </div>

    <!-- 답변일 -->
    <p class="date">답변일 : ${answeredDate}</p>

    <!-- 버튼 (항상 박스 우측 하단, 답변일 아래 겹치지 않게) -->
    <div class="back-btn-container">
        <button class="back-btn" onclick="history.back();">← 뒤로가기</button>
    </div>
</div>

        </c:when>

        <c:otherwise>
            <div class="empty-answer">
                <img src="<c:url value='/resources/img/wait.png'/>" class="wait-icon">
                <p>아직 답변이 등록되지 않았어요.<br>조금만 기다려주세요 😊</p>
                <div class="back-btn-container">
                <button class="back-btn" onclick="history.back();">← 뒤로가기</button>
            </div>
            </div>
        </c:otherwise>
    </c:choose>
    
    

</div>

</body>
</html>