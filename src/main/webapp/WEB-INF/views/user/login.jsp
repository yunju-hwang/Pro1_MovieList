<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/login.css" />
<meta charset="UTF-8">
<title>MovieList 로그인</title>
<style>
/* CSS 스타일 작성 */
</style>
</head>
<body>
	<div class="container">
		<h1>MovieList</h1>
		<p>영화 리뷰와 예매 서비스</p>
		<form action="${pageContext.request.contextPath }/loginPro" name="fr"
			method="post">

			<div class="form-group">
				<label for="userId">아이디:</label> <input type="text" id=user_id
					name="user_id" placeholder="아이디를 입력하세요" required>
			</div>
			<div class="form-group">
				<label for="userPw">비밀번호:</label> <input type="password"
					id="password" name="password" placeholder="비밀번호를 입력하세요" required>
			</div>
			<div class="form-group">
				<input type="checkbox" id="rememberUserId" name="rememberUserId">
				<label for="rememberUserId">아이디 기억하기</label>
			</div>
			<div class="form-group">
				<a href="${pageContext.request.contextPath}/findId">아이디 찾기</a> | <a href="${pageContext.request.contextPath}/findPw">비밀번호 찾기</a>
			</div>
			<button type="submit" class="btn btn-primary">로그인</button>
			<button type="button" class="btn btn-secondary"
				onclick="location.href='${pageContext.request.contextPath}/register/step1'">
				회원가입</button>
		</form>



		<div class="or-divider">
			<span>또는</span>
		</div>

		<div class="social-login">
			<a href="naver_login.jsp" class="btn btn-success">N 네이버로 로그인</a> 
			<a href="https://kauth.kakao.com/oauth/authorize?client_id=${kakaoClientId}&redirect_uri=${kakaoRedirectUri}&response_type=code&prompt=login" class="btn btn-warning">카카오로 로그인</a>


		</div>
	</div>
</body>
</html>