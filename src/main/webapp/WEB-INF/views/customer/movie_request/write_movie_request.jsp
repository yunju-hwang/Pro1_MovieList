<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 등록 요청</title>
<link rel="stylesheet" href="<c:url value='/resources/css/write_inquiry.css?after'/>">
</head>

<body>

<h1 class="title">영화 등록 요청</h1>
<h4 class="title1">보고 싶으신 영화를 요청해주시면 검토 후 등록해 드립니다</h4>

<c:choose>
    <c:when test="${mode == 'update'}">
        <form method="post" action="${pageContext.request.contextPath}/customer/movie_request_update_pro">
        
    </c:when>
    <c:otherwise>
        <form method="post" action="${pageContext.request.contextPath}/customer/write_movie_request_pro">
    </c:otherwise>
</c:choose>


<!-- 수정 시 id hidden 전달 -->
<c:if test="${mode == 'update'}">
    <input type="hidden" name="id" value="${movieRequest.id}">
</c:if>


<!-- 영화 제목 -->
<p class="unity">영화 제목 *</p>
<div class="text-con">
    <input type="text"
           placeholder="영화 제목을 입력하세요"
           class="text"
           required
           name="title"
           value="${movieRequest.title}">
</div>

<!-- 요청 내용 -->
<p class="unity">요청 사유 *</p>
<div class="text-con">
    <textarea cols="40" rows="10"
              placeholder="요청 이유를 작성해 주세요"
              class="text"
              required
              name="content">${movieRequest.content}</textarea>
</div>

<p class="under">최소 10자 이상 작성해주세요</p>

<!-- 안내사항 -->
<div class="notification">
    <h1 class="not-title">안내사항</h1>
    <ul class="listcon">
        <li class="list">요청하신 영화는 검토 후 등록 여부를 알려드립니다</li>
        <li class="list">이미 등록된 영화는 중복 등록되지 않습니다</li>
        <li class="list">영화 등록 요청 결과는 마이페이지에서 확인 가능합니다</li>
    </ul>
</div>

<!-- 등록 기준 -->
<div class="notification">
    <h1 class="not-title">영화 등록 기준</h1>
    <ul class="listcon">
        <li class="list">정식 개봉한 극장 영화</li>
        <li class="list">OTT 오리지널 영화</li>
        <li class="list">비공식 루트 영화는 등록 불가</li>
        <li class="list">청소년 관람불가 영화는 등록 불가</li>
    </ul>
</div>

<!-- 버튼 -->
<div class="btn-form">
    <input type="button" value="취소하기" class="no-sub"
           onclick="location.href='/movielist/customer/movie_request';">
<c:choose>
    <c:when test="${mode == 'update'}">
        <input type="submit" value="수정하기" class="sub">
    </c:when>
    <c:otherwise>
        <input type="submit" value="요청하기" class="sub">
    </c:otherwise>
</c:choose>

</div>
</form>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
