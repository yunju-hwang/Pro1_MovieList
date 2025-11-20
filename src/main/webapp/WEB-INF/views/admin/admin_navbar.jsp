<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin_navbar</title>
<link rel="stylesheet"
	href="<c:url value='/resources/css/navbar.css' />">
<style>
.navbar-menu li a img {
	width: 20px; /* 아이콘 크기 지정 */
	height: 20px;
	vertical-align: middle; /* 텍스트 중간에 맞추기 */
	margin-right: 5px; /* 텍스트와 약간 간격 두기 */
}
</style>
</head>
<body>
	<nav class="navbar">
		<div class="navbar-logo">
			<a href="<c:url value='/' />">MOVIELIST</a>
		</div>
		<ul class="navbar-menu">
			<c:if test="${not empty sessionScope.loginUser}">
			<li><a href="#"><c:out value="${sessionScope.loginUser.user_id}" />님</a></li></c:if>
			<li><a href="<c:url value='/admin/dashboard' />">
			<img src="${pageContext.request.contextPath}/resources/img/warning.png">관리자	페이지</a></li>
			<li><a href="<c:url value='/member/logout' />">로그아웃</a></li>

		</ul>
	</nav>

</body>
</html>

