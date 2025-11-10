<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
    <h1>회원 가입</h1>
    <form action="register.jsp" method="post">
        <label for="userId">아이디:</label>
        <input type="text" id="userId" name="userId" required><br>

        <label for="userPw">비밀번호:</label>
        <input type="password" id="password" name="userPw" required><br>

        <label for="userName">이름:</label>
        <input type="text" id="username" name="userName" required><br>

        <label for="userEmail">이메일:</label>
        <input type="email" id="email" name="userEmail" required><br>

        <label>성별:</label>
        <input type="radio" id="userGenderMale" name="gender" value="male" required>
        <label for="userGenderMale">남성</label>
        <input type="radio" id="userGenderFemale" name="gender" value="female" required>
        <label for="userGenderFemale">여성</label>
        <input type="radio" id="userGenderOther" name="gender" value="other" required>
        <label for="userGenderOther">기타</label><br>

        <label for="userBirthday">생년월일:</label>
        <input type="date" id="userBirthday" name="userBirthday" required><br>

        <label for="userPhone">전화번호:</label>
        <input type="tel" id="userPhone" name="userPhone" required><br>

        <input type="submit" value="가입하기">
    </form>


</body>
</html>
