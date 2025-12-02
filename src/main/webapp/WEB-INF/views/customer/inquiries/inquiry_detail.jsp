<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/inquiry_detail.css?after' />">
<link rel="stylesheet" href="<c:url value='/resources/css/inquiry_detail.css' />">
</head>
<body>
	<div class="container">
		<div class="inquiry_head">
<div class="container">

                <span class="sp_ans">답변</span>
	</div>
	<div class="inquiry_body">
	<p>문의해주신 답변의 내용은 이렇습니다</p>
	<p>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</p>




	</div>
<h2>문의 상세</h2>

<p>제목: ${inq.title}</p>
<p>내용: ${inq.content}</p>
<p>작성일: ${inq.createdAt}</p>

<h3>답변</h3>

<c:choose>
    <c:when test="${not empty inq.answerContent}">
        <p>${inq.answerContent}</p>
        <p>답변일: ${inq.answeredAt}</p>
    </c:when>
    <c:otherwise>
        <p>아직 답변이 등록되지 않았습니다.</p>
    </c:otherwise>
</c:choose>



	    
	    </div>
	    
	    
	
	
	
	
	
</body>
</html>