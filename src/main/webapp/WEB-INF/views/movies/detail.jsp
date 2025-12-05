<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 상세페이지</title>
<link rel="stylesheet" href="${ctx}/resources/css/detail.css">
</head>
<body>

<div id="movie-detail">Loading...</div>

<div class="recommend-section">
    <h2>추천 영화</h2>

    <div class="recommend-list">
        <c:forEach var="rec" items="${recommendations}">
            <a href="${ctx}/movies/search/detail/${rec.id}" class="rec-card-link">
                <div class="rec-card">
                    <img src="https://image.tmdb.org/t/p/w500${rec.poster_path}" />
                    <p>${rec.title}</p>
                </div>
            </a>
        </c:forEach>
    </div>
</div>





<!-- JS 분리 -->
<script>
    // JSP에서 ctx와 tmdbId를 JS로 전달
    const ctx = "${ctx}";
    const urlParams = new URLSearchParams(window.location.search);
    const tmdbId = urlParams.get("tmdbId");
	 // 세션이 없으면 false, 있으면 true
    const isLogin = <%= (session.getAttribute("loginUser") != null ? "true" : "false") %>;

</script>
<script src="${ctx}/resources/js/detail.js"></script>

</body>
</html>
