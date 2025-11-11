<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<h2>로그인</h2>

<c:if test="${not empty msg}">
    <p style="color:red;">${msg}</p>
</c:if>

<form action="${pageContext.request.contextPath}/login" method="post">
    <label for="user_id">아이디:</label>
    <input type="text" name="user_id" id="user_id" required><br><br>

    <label for="password">비밀번호:</label>
    <input type="password" name="password" id="password" required><br><br>

    <button type="submit">로그인</button>
</form>

<p><a href="${pageContext.request.contextPath}/register/step1">회원가입</a></p>


</body>
</html>