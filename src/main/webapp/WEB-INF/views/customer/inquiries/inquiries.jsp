<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/inquiries.css' />">


</head>

<body>
	<h1 class="inquery">문의 내역</h1>
	<h4 class="many">총 0건의 문의 내역</h4>
	<div class="container">
		<p class="ma">문의 내역이 없습니다</p>
	</div>
	<div class="btn_con">
		<input type="button" value="1:1 문의하기" name="inquirey" class="inquirey">
	</div>
</body>
</html>