<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의</title>
<link rel="stylesheet" href="<c:url value='/resources/css/write_inquiry.css'/>">
</head>
<body>

<h1 class="title">1:1 문의</h1>
<h4 class="title1">궁금한 사항을 남겨주시면 빠르게 답변 드립니다</h4>

<c:choose>
    <c:when test="${not empty inquiriesVO}">
        <!-- 수정 모드 -->
        <form action="${pageContext.request.contextPath}/customer/inquiry_update" method="post">
            <input type="hidden" name="id" value="${inquiriesVO.id}">
    </c:when>
    <c:otherwise>
        <!-- 신규 작성 모드 -->
        <form action="${pageContext.request.contextPath}/customer/write_inquiry_pro" method="post">
    </c:otherwise>
</c:choose>

<div class="container">
    <p class="unity">문의 제목 *</p>
    <div class="text-con">
        <input type="text" name="title" class="text" placeholder="문의 제목을 입력하세요" required
               value="${inquiriesVO.title}">
    </div>

    <p class="unity">문의 내용 *</p>
    <div class="text-con">
        <textarea name="content" class="text" placeholder="문의 내용을 입력하세요" rows="10" required>${inquiriesVO.content}</textarea>
        
    </div>
    <p class="under">최소 10자 이상 작성해주세요</p> 
    <div class="notification"> 
    	<h1 class="not-title">안내사항</h1> 
    	<ul class="listcon"> 
    		<li class="list">영업일 기준 24시간 이내 답변 드립니다</li> 
    		<li class="list">주말/공휴일 문의는 다음 영업일에 순차적으로 답변드립니다</li> 
    		<li class="list">긴급한 사항은 고객센터(1588-0000)로 연락바랍니다</li> 
    	</ul> 
    </div>

    <div class="btn-form">
        <input type="button" value="취소하기" class="no-sub" 
               onclick="location.href='${pageContext.request.contextPath}/customer/inquiries';">
        <c:choose>
            <c:when test="${not empty inquiriesVO}">
                <input type="submit" value="수정하기" class="sub">
            </c:when>
            <c:otherwise>
                <input type="submit" value="문의하기" class="sub">
            </c:otherwise>
        </c:choose>
    </div>
</div>
</form>

</body>
</html>
