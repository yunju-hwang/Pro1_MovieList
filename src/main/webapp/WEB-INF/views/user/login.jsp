<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
     Cookie[] cookies = request.getCookies();
     String cookid = "";
     if(cookies != null){
          for(Cookie c : cookies){
               if("cookid".equals(c.getName())){
                    cookid = c.getValue();
                    break;
               }
          }
     }
     request.setAttribute("cookid", cookid);
%>


<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<title>MovieList 로그인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login_findId.css">

</head>

<body>
	<div class="container">
		<h1>MovieList</h1>
		<p>영화 리뷰와 예매 서비스</p>
		   <form action="${pageContext.request.contextPath}/loginPro" method="post" name="fr">


			<div class="form-group">
               <label for="userId">아이디:</label>
              <input type="text" id="user_id" name="user_id" value="${not empty user_id ? user_id : cookid}"
       					placeholder="아이디를 입력하세요" required>
          </div>

          <div class="form-group">
               <label for="userPw">비밀번호:</label>
               <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
          </div>

          <div class="form-group" style="display: flex; align-items: center; gap: 10px;">
     <input type="checkbox" id="rememberUserId" name="idSave" <c:if test="${not empty cookid}">checked</c:if>>
     <label for="rememberUserId">아이디 기억하기</label>
     </div> 
     <div class="form-group" style="display: flex; align-items: center; gap: 10px;">
     <a href="#">아이디 찾기</a>
     
     <a href="#">비밀번호 찾기</a>
     
		</div>

	<!-- 로그인 실패 메시지 출력 -->
			<c:if test="${not empty msg}">
				<div style="color: red; margin-bottom: 10px;">${msg}</div>
			</c:if>
			
          <button type="submit" class="btn btn-primary">로그인</button>
          <button type="button" class="btn btn-secondary"
               onclick="location.href='${pageContext.request.contextPath}/register/step1'">
               회원가입
          </button>
     </form>



		<div class="or-divider">
			<span>또는</span>
		</div>

		<div class="social-login">
			<a href="naver_login.jsp" class="btn btn-success">N 네이버로 로그인</a> 
			<a href="https://kauth.kakao.com/oauth/authorize?client_id=${kakaoClientId}&redirect_uri=${kakaoRedirectUri}&response_type=code" class="btn btn-warning">카카오로 로그인</a>

		</div>
	</div>
	
</body>
</html>