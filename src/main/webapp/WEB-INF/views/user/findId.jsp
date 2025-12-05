<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>아이디 찾기</title>
</head>
<body>
    <h2>아이디 찾기</h2>
    <form action="${pageContext.request.contextPath}/findId/sendEmail" method="post">
        <label for="email">가입 시 입력한 이메일:</label>
        <input type="email" id="email" name="email" required><br><br>
        
        <button type="submit">아이디 찾기</button>
        <button type="button" onclick="history.back()">뒤로 가기</button>
    </form>
</body>
</html>