<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<title>공지사항</title>
<link rel="stylesheet" href="<c:url value='/resources/css/notice.css'/>">
</head>
<body>
	<h1>고객센터/공지 목록</h1>
	<h1 class="title">공지 사항</h1>
	<h2 class="show">MovieList의 새로운 소식과 공지사항을 확인하세요</h2>

<a href="notice_detail" class="notice-link">
	<div class="notice">
				<div class="not">공지	</div>
		<c:forEach var="noticesVO" items="${notice_list }">
			<h3 class="nottitle">${noticesVO.title }</h3>
			<h4>${noticesVO.createdAt }</h4>
		</c:forEach>
	</div>
</a>




</body>
</html>