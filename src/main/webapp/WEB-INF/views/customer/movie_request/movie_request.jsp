<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/movie_request.css?after'/>">
</head>
<body>
	<h1 class="movie-req">영화 등록 요청 내역</h1>
	<h4 class="req">총 ${MovieRequestVO.count } 건의 요청</h4>
	<div class="container">
		<p class="ma">요청 내역이 없습니다</p>	
	</div>
<a href="/movielist/customer/write_movie_request" class="mov-write">
	<div class="movie">
		<p>영화 등록 요청하기</p>
	</div>
</a>
</body>
</html>