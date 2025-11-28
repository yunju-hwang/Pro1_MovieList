<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

<c:forEach var="noticesVO" items="${list}">
    <div class="notice slide-in">

        <!-- 클릭 영역: 카드 전체 -->
        <a href="notice_detail?id=${noticesVO.id}" class="notice-link">

            <div class="img-box icon-box">
                <img src="<c:url value='/resources/img/title-icon.png'/>" alt="공지 아이콘" class="megaphone-img">
            </div>

            <!-- 텍스트 박스 -->
            <div class="text-box">
                <div class="not">공지</div>

                <h3 class="nottitle">${noticesVO.title}</h3>

                <!-- 1줄 요약 -->
                <p class="excerpt">
                    ${fn:length(noticesVO.content) > 40
                        ? fn:substring(noticesVO.content, 0, 40) += "..."
                        : noticesVO.content}
                </p>

                <h4 class="date">${noticesVO.createdAt}</h4>
            </div>

            <!-- 화살표 아이콘 -->
            <div class="arrow">➜</div>

        </a>
    </div>
</c:forEach>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>