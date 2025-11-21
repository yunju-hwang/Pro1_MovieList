<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
    <c:when test="${sessionScope.role eq 'admin'}">
        <%@ include file="/WEB-INF/views/admin/admin_navbar.jsp" %> 
    </c:when>
    <c:otherwise>
        <%@ include file="/WEB-INF/views/common/navbar.jsp" %>
    </c:otherwise>
</c:choose>


<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MovieList Main</title>
<link rel="stylesheet" href="${ctx}/resources/css/movieList.css">
<link rel="stylesheet" href="${ctx}/resources/css/main.css">
<link rel="stylesheet" href="${ctx}/resources/css/search.css">
</head>
<body>

<div class="mnavbar">
    <a href="${ctx}/main">Home</a>
    <a href="${ctx}/movies/ai_review" id="aiReviewBtn">AI Review</a>
</div>

<!-- search section -->

<div id="search-wrapper">
	<div id="search-container"></div>
	
	<select id="sort-select">
	    <option value="latest">최신순</option>
	    <option value="popularity">인기순</option>
	</select>
	
</div>


<!-- 영화 목록 표시 -->
<div id="movie-list" data-ctx="${ctx}" data-islogin="<c:out value='${not empty sessionScope.loginUser}' default='false'/>"></div>





<!-- JS 변수 선언 후 외부 JS 호출 -->
<script>
    // JSP에서 ctx와 isLogin을 외부 JS에서 사용 가능하게 전달
    const container = document.getElementById("movie-list");
    const ctx = container.dataset.ctx;
    const isLogin = container.dataset.islogin === 'true';
    const loginUser = '<c:out value="${sessionScope.loginUser.user_id}" default=""/>';
    localStorage.setItem("userId", "${sessionScope.loginUser.user_id}");
</script>



<script src="${ctx}/resources/js/movieList.js"></script>
<script src="${ctx}/resources/js/search.js"></script>


</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>  