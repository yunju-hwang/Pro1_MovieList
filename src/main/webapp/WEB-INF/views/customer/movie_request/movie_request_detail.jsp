<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 요청 상세</title>
<link rel="stylesheet" href="<c:url value='/resources/css/movie_request_detail.css?after' />">
</head>
<body>

<div class="detail-container">

    <!-- 헤더 영역 -->
    <div class="header">
        <img src="<c:url value='/resources/img/film_red.png'/>" class="title-icon">
        <h2 class="title-text">영화 요청 상세</h2>
    </div>

    <!-- 요청 내용 박스 -->
    <div class="box question">
    <div class="box-header">🎬 요청내용</div>
    <div class="box-body">
        <p><strong>제목</strong> : ${movieRequest.title}</p>
        <p><strong>내용</strong> : ${movieRequest.content}</p>
    </div>
    <p class="date">작성일 : ${createdAt}</p>
</div>

<div class="divider"></div>

<c:choose>
    <c:when test="${not empty movieRequest.status && movieRequest.status == 'approved'}">
        <div class="box answer">
            <div class="box-header green">💬 심사완료</div>
            <p><strong>심의 결과</strong> :	 통과</p>
            <p><strong>영화가 등록되었습니다</strong></p>
<!--             <p><strong>MovieList</strong> 홈페이지에서 확인해보세요</p> -->
            <div class="box-body">
            
            <p class="date">완료일 : ${processedAt}</p>
        </div>
    </c:when>
    <c:otherwise>
        <div class="empty-answer">
            <img src="<c:url value='/resources/img/wait.png'/>" class="wait-icon">
            <p>아직 심사가 완료되지 않았어요.<br>조금만 기다려주세요 😊</p>
        </div>
    </c:otherwise>
</c:choose>

</div>

</body>
</html>
