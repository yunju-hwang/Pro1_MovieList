<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" href="<c:url value='/resources/css/notice.css?after'/>">
</head>
<body>
    <h1 class="title">공지 사항</h1>
    <h2 class="show">MovieList의 새로운 소식과 공지사항을 확인하세요</h2>

    <!-- 🔥 DB 리스트 반복하여 박스 여러 개 생성 -->
    <c:forEach var="noticesVO" items="${list}">
        <a href="notice_detail?id=${noticesVO.id}" class="notice-link">
            <div class="notice">
                <div class="not">공지</div>

                <h3 class="nottitle">${noticesVO.title}</h3>
                <h4>${noticesVO.createdAt}</h4>
            </div>
        </a>
    </c:forEach>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>