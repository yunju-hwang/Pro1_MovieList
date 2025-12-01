<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 상세 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/detail.css">
</head>
<body>
<div id="movie-detail">
    <div class="detail-container">

        <!-- 왼쪽 박스 (포스터만 표시) -->
        <div class="left-box">
            <div class="poster-wrapper">
                <img class="poster" src="https://image.tmdb.org/t/p/w400${posterPath}" alt="${title}">
            </div>
        </div>

        <!-- 오른쪽 박스: 영화 정보 -->
        <div class="right-box">
            <h1 class="movie-title">${title}</h1>
            <div class="meta">
                <span><strong>상영시간:</strong> ${runtimeText}</span>
            </div>
            <p><strong>개봉일:</strong> ${releaseDate}</p>
            <p><strong>장르:</strong> ${genresText}</p>
            <p class="overview"><strong>개요:</strong> ${overview}</p>
        </div>

    </div>
    <!-- 출연진 영역 -->
	<div class="credit-section">
    <h2>출연진</h2>
    <div class="cast-list">
        <c:forEach var="actor" items="${credits.cast}">
            <div class="cast-card">
                <img 
                    src="<c:choose>
                             <c:when test='${not empty actor.profile_path}'>
                                 https://image.tmdb.org/t/p/w500${actor.profile_path}
                             </c:when>
                             <c:otherwise>
                                 ${pageContext.request.contextPath}/resources/img/no_img_people.png
                             </c:otherwise>
                         </c:choose>" 
                    alt="${actor.name != null ? actor.name : '이름 없음'}"
                />
                <p>${actor.name != null ? actor.name : "이름 없음"}</p>
                <c:if test="${not empty actor.role}">
                    <p class="role">(${actor.role})</p>
                </c:if>
            </div>
        </c:forEach>
    </div>
</div>


    
    <!-- 추천 영화 섹션 -->
	<div class="recommend-section">
        <h2>추천 영화</h2>
        <div class="recommend-list">
            <c:forEach var="rec" items="${recommendations}">
                <div class="recommend-card">
                    <a href="${pageContext.request.contextPath}/movies/search/detail/${rec.id}">
                        <img src="https://image.tmdb.org/t/p/w200${rec.poster_path}" alt="${rec.title}" />
                        <p>${rec.title}</p>
                    </a>
                </div>
            </c:forEach>
            <c:if test="${fn:length(recommendations) == 0}">
                <p>추천 영화가 없습니다.</p>
            </c:if>
        </div>
    </div>



</div>

<!-- 찜/리뷰 기능이 없으므로 JS 필요 없음 -->
</body>
</html>
