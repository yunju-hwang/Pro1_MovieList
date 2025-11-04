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
        <!-- 고객센터 드롭다운 -->
        <li class="dropdown">
            <a href="<c:url value='/customer/notices' />">고객센터</a>
            <ul class="dropdown-menu">
                <li><a href="<c:url value='/customer/notices' />">공지사항</a></li>
                <li><a href="<c:url value='/customer/faqs' />">FAQ</a></li>
                <li><a href="<c:url value='/customer/inquiries' />">1:1 문의</a></li>
                <li><a href="<c:url value='/customer/movie_request' />">영화 등록 요청</a></li>
            </ul>
        </li>

        <!-- 로그인 여부에 따라 메뉴 분기 -->
        <c:choose>
    
            <c:when test="${empty sessionScope.loginUser}">
                <li><a href="<c:url value='/login' />">로그인</a></li>
                <li><a href="<c:url value='/register/step1' />">회원가입</a></li>
            </c:when>

           
            <c:otherwise>
                 <li class="dropdown">
                    <a href="<c:url value='/mypage/favorites' />">마이페이지</a>
                    <ul class="dropdown-menu">
                        <li><a href="<c:url value='/mypage/favorites' />">관심 영화</a></li>
                        <li><a href="<c:url value='/mypage/reservations' />">예매 내역</a></li>
                        <li><a href="<c:url value='/mypage/paymentmethod' />">결제 수단</a></li>
                        <li><a href="<c:url value='/mypage/theaters' />">선호 영화관</a></li>
                        <li><a href="<c:url value='/mypage/profile' />">회원정보 수정</a></li>
                        <li><a href="<c:url value='/mypage/inquiries' />">문의 내역</a></li>
                        <li><a href="<c:url value='/mypage/movierequest' />">영화 요청</a></li>
                    </ul>
                </li>
                <li><a href="<c:url value='/member/logout' />">로그아웃</a></li>
            </c:otherwise>
        </c:choose>
    </ul>
</nav>

</body>
</html>