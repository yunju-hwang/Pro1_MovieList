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
	
</head>
<body>

<h2>영화 목록</h2>

<div id="movie-list"></div>

<script src="${pageContext.request.contextPath}/resources/js/movieList.js"></script>

</body>

</html>