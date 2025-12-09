<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세</title>
<link rel="stylesheet" href="<c:url value='/resources/css/notice_detail.css'/>">
</head>
<body>


<div class="notice-container">
<a href="/movielist/customer/notices">
<h3 class="back">
<img src="<c:url value='/resources/img/right_arrow.png'/>" alt="오른쪽 화살표" class="right-arrow">
목록으로 돌아가기
</h3>
</a>


<h1>${notice.title}</h1>
<h4>${createdDate}</h4>


<div class="content-box">
<c:out value="${formattedContent}" escapeXml="false" />
</div>
</div>


</body>
</html>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>