<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>선호 장르 선택</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/register_step3.css" />
</head>
<body>
<div class="genre-container">
    <form class="genre-form" action="${pageContext.request.contextPath }/register/step3Pro" method="post">
        <h2>선호하는 영화 장르를 선택해주세요</h2>
        <p class="sub-text">여러 개 선택 가능합니다</p>

        <div class="genre-grid">
			
			<c:forEach var="genres" items="${genresVOList}"> 
				<label><input type="checkbox" name="genre" value="${genres.genreId }" ><span>${genres.genreName}</span></label>
			
			</c:forEach>

           
        </div>

        <div class="btn-row">
            <button type="button" class="prev-btn" onclick="history.back()">이전</button>
            <button type="submit" class="next-btn">가입 완료</button>
        </div>
    </form>
</div>

<script src="${pageContext.request.contextPath}/resources/js/register_step3_genresChecked.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/register_step3_genresMinSelect.js"></script>

</body>
</html>