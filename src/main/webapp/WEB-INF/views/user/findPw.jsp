<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>비밀번호 찾기</title>
</head>
<body>
    <h2>비밀번호 찾기</h2>
    <form action="${pageContext.request.contextPath}/findPw/sendEmail" method="post">
        <label for="userId">아이디:</label>
        <input type="text" id="userId" name="userId" required><br><br>
        
        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" required><br><br>
        
        <button type="submit">임시 비밀번호 발급</button>
        <button type="button" onclick="history.back()">뒤로 가기</button>
    </form>
</body>
</html>