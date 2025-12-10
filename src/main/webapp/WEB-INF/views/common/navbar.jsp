<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/navbar.css' />">
</head>
<body>

<nav class="navbar">
    <div class="navbar-logo">
        <a href="<c:url value='/' />">MOVIELIST</a>
    </div>

    <ul class="navbar-menu">
        

        <!-- 로그인 여부에 따라 메뉴 분기 -->
        <c:choose>
    
            <c:when test="${empty sessionScope.loginUser}">
                <li><a href="<c:url value='/login' />">로그인</a></li>
                <li><a href="<c:url value='/register/step1' />">회원가입</a></li>
            </c:when>

           
            <c:otherwise>
                 <li class="dropdown">
                    <a href="<c:url value='/mypage/reservations' />">
                ${sessionScope.loginUser.nickname}님
            </a>
                </li>
                <li><a href="<c:url value='/member/logout' />">로그아웃</a></li>
            </c:otherwise>
        </c:choose>
    </ul>
</nav>

</body>
</html>