<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 등록 요청 내역</title>
<link rel="stylesheet" href="<c:url value='/resources/css/movie_request.css?after'/>">
</head>
<body>

<h1 class="movie-req">영화 등록 요청 내역</h1> 
<h4 class="req">총 ${count} 건의 요청</h4>

<div class="container">
    <c:choose>
        <c:when test="${count == 0}">
            <p class="ma">요청 내역이 없습니다</p>
        </c:when>

        <c:otherwise>
            <div class="inquiry_head">
                <span class="sp_num">글번호</span>
                <span class="sp_title">제목</span>
                <span class="sp_content">내용</span>
                <span class="sp_wri_date">작성일</span>
                <span class="sp_ans">승인여부</span>
            </div>

            <div class="inquiry_list">
                <c:forEach var="movieRequest" items="${movie_request_list}">
                    <div class="inquiry_item">
                        <span class="item_num">${movieRequest.id}</span>
                        <span class="item_title">${movieRequest.title}</span>

                        <!-- 내용 15자 제한 -->
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

                        <!-- 포맷된 날짜 출력 -->
                        <span class="item_date">${movieRequest.createdAt}</span>

                        <!-- 상태 표시 -->
                        <c:choose>
                            <c:when test="${movieRequest.status eq 'pending'}">
                                <span class="item_status_pen">대기</span>
                            </c:when>

                            <c:when test="${movieRequest.status eq 'approved'}">
                                 <a href="${pageContext.request.contextPath }/customer/movie_request_detail"  class="item_status_app">
                                <span>승인</span>
                                 </a>
                            </c:when>
                           
                            <c:when test="${movieRequest.status eq 'rejected'}">
                                <span class="item_status_rej">거부</span>
                            </c:when>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<a href="${pageContext.request.contextPath}/customer/write_movie_request" class="mov-write">
    <div class="movie">
        <p class="movie">영화 등록 요청하기</p>
    </div>
</a>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>