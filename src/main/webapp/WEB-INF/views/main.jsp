<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MovieList Main</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movieList.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">


</head>


<body>


<script>
// DOM이 로드된 이후 이벤트 등록
document.addEventListener("DOMContentLoaded", () => {
    // login 여부
    const isLogin = ${not empty sessionScope.loginUser ? 'true' : 'false'};

    // ai review button click event
    const aiBtn = document.getElementById("aiReviewBtn");
    if (aiBtn) {
        aiBtn.addEventListener("click", function(event) {
            if (!isLogin) {
                event.preventDefault();
                alert("로그인이 필요한 서비스입니다.");
                window.location.href = "${pageContext.request.contextPath}/main";
            }
        });
    }
});
</script>



<!-- search section 삽입 -->
<div class="search-section">
    <%@ include file="/WEB-INF/views/movies/search.jsp" %>
</div>

<div class="mnavbar">
    <a href="${pageContext.request.contextPath}/main">Home</a>
    <a href="${pageContext.request.contextPath}/movies/ai_review" id="aiReviewBtn">AI Review</a>
</div>


<!-- movieList.js에서 card형태로 영화 값 받아옴  -->
<div id="movie-list"></div>

<script>
	const ctx = "${ctx}"; // JSP에서 context path 전달
</script>
<script src="${pageContext.request.contextPath}/resources/js/movieList.js"></script>

</body>

</html>