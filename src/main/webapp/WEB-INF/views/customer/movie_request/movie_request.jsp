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
                <span class="sp_num">번호</span>
                <span class="sp_title">제목</span>
                <span class="sp_content">내용</span>
                <span class="sp_date">요청일</span>
                <span class="sp_status">상태</span>
                <div class="sort-container">
                    <form method="get" action="/movielist/customer/movie_request">
                        <select name="sort" onchange="this.form.submit()">
                        	<option value="date_desc" ${param.sort == 'date_desc' ? 'selected' : ''}>최신순</option>
                        	<option value="date_asc" ${param.sort == 'date_asc' ? 'selected' : ''}>오래된순</option>
                            <option value="completed" ${param.sort == 'completed' ? 'selected' : ''}>답변 완료</option>
                            <option value="pending" ${param.sort == 'pending' ? 'selected' : ''}>답변 대기</option>
                        </select>
                    </form>
                </div>
            </div>

            <!-- 리스트 -->
            <c:forEach var="movieRequest" items="${movie_request_list}" varStatus="status">
                <div class="request_item grid-row" onclick="location.href='/movielist/customer/movie_request_detail?id=${movieRequest.id}'">

                    <span class="item_num">${status.index + 1}</span>
                    <span class="item_title"><c:choose>
                            <c:when test="${fn:length(movieRequest.title) > 15}">
                                ${fn:substring(movieRequest.title, 0, 15)}...
                            </c:when>
                            <c:otherwise>${movieRequest.title}</c:otherwise>
                        </c:choose></span>
                    <span class="item_content">
                        <c:choose>
                            <c:when test="${fn:length(movieRequest.content) > 15}">
                                ${fn:substring(movieRequest.content, 0, 15)}...
                            </c:when>
                            <c:otherwise>${movieRequest.content}</c:otherwise>
                        </c:choose>
                    </span>
                    <span class="item_date">${movieRequest.createdAt}</span>

                    <span class="item_status">
                        <c:choose>
                            <c:when test="${movieRequest.status eq 'pending'}">
                                <img src="https://cdn-icons-png.flaticon.com/512/595/595067.png" class="status_icon">
                                대기
                            </c:when>
                            <c:otherwise>
                                <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" class="status_icon">
                                완료
                            </c:otherwise>
                        </c:choose>
                    </span>

                    <!-- 버튼 그룹: pending(대기)일 때만 표시 -->
<c:if test="${movieRequest.status eq 'pending'}">
    <div class="button-group">
        <span class="item_edit" onclick="event.stopPropagation(); location.href='/movielist/customer/write_movie_request?id=${movieRequest.id}'">
            <img src="https://cdn-icons-png.flaticon.com/512/1827/1827933.png" class="edit_icon">수정
        </span>
        <span class="item_delete" onclick="event.stopPropagation(); if(confirm('정말 삭제하시겠습니까?')) location.href='/movielist/customer/movie_request_delete?id=${movieRequest.id}'">
            <img src="https://cdn-icons-png.flaticon.com/512/3405/3405244.png" class="delete_icon">삭제
        </span>
    </div>
</c:if>


                </div>
            </c:forEach>

        </c:otherwise>
    </c:choose>

</div>

<div class="req-con" onclick="location.href='/movielist/customer/write_movie_request'">
    <img src="https://cdn-icons-png.flaticon.com/512/992/992651.png" class="write_icon">
    <p>영화 요청하기</p>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
