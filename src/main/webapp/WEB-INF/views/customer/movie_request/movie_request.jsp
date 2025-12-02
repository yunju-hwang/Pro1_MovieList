<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 요청 내역</title>
<link rel="stylesheet" href="<c:url value='/resources/css/movie_request.css'/>">
</head>
<body>

<h1 class="request">
    <img src="<c:url value='/resources/img/film_red.png' />" class="title_icon">
    영화 요청 내역
</h1>

<h4 class="many">총 ${count}건의 요청 내역</h4>

<div class="container">

    <c:choose>
        <c:when test="${count == 0}">
            <p class="no-data">
                <img src="https://cdn-icons-png.flaticon.com/512/4076/4076549.png" class="no_icon">
                요청 내역이 없습니다
            </p>
        </c:when>
        <c:otherwise>
            <!-- 헤더 -->
            <div class="request_head grid-row">
                <span class="sp_num">글번호</span>
                <span class="sp_title">제목</span>
                <span class="sp_content">내용</span>
                <span class="sp_date">요청일</span>
                <span class="sp_status">처리 상태</span>
            </div>

            <!-- 리스트 -->
            <div class="request_list">
                <c:forEach var="movieRequest" items="${movie_request_list}" varStatus="status">
                    <div class="request_item grid-row">
                        <span class="item_num">${status.index + 1}</span>
                        <span class="item_title">${movieRequest.title}</span>
                        <span class="item_content">
                            <c:choose>
                                <c:when test="${fn:length(movieRequest.content) > 15}">
                                    ${fn:substring(movieRequest.content, 0, 15)}...
                                </c:when>
                                <c:otherwise>
                                    ${movieRequest.content}
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <span class="item_date">${movieRequest.createdAt.toString().substring(0,10)}</span>

                        <c:if test="${movieRequest.status eq 'pending'}">
                            <span class="item_status_pen">
                                <img src="https://cdn-icons-png.flaticon.com/512/595/595067.png" class="status_icon">
                                대기
                            </span>
                        </c:if>
                        <c:if test="${movieRequest.status ne 'pending'}">
                            <span class="item_status_com">
                                <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" class="status_icon">
                                완료
                            </span>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<!-- 영화 요청 버튼 -->
<div class="req-con" onclick="location.href='/movielist/customer/write_movie_request'">
    <img src="https://cdn-icons-png.flaticon.com/512/992/992651.png" class="write_icon">
    <p>영화 요청하기</p>
</div>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>