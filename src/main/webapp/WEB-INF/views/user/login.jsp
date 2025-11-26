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
<html lang="ko">
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
               <input type="text" id="user_id" name="user_id" value="${cookid}" placeholder="아이디를 입력하세요" required>
          </div>

          <div class="form-group">
               <label for="userPw">비밀번호:</label>
               <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
          </div>

          <div class="form-group" style="display: flex; align-items: center; gap: 10px;">
     <input type="checkbox" id="rememberUserId" name="idSave" <c:if test="${not empty cookid}">checked</c:if>>
     <label for="rememberUserId">아이디 기억하기</label>
     
     <a href="#" id="findIdLink">아이디 찾기</a> | 
     
     <a href="find_pw.jsp">비밀번호 찾기</a>
</div>

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
          <a href="kakao_login.jsp" class="btn btn-warning">카카오로 로그인</a>
     </div>
</div>

<div id="findIdModal" class="modal-overlay">
     
     <div class="modal-content">
          <h2 class="modal-title">아이디 찾기</h2>
          <p class="modal-description">가입 시 등록한 이름과 이메일을 입력해주세요</p>
          
          <form action="${pageContext.request.contextPath}/user/findIdProcess" method="post" id="findIdForm">
               <div class="input-group">
                    <label for="userName">이름</label>
                    <input type="text" id="userName" name="userName" placeholder="이름을 입력하세요" required>
               </div>
               
               <div class="input-group">
                    <label for="userEmail">이메일</label>
                    <input type="email" id="userEmail" name="userEmail" placeholder="이메일을 입력하세요" required>
               </div>
               
               <div class="button-group">
                    <button type="submit" class="btn-submit">아이디 찾기</button>
               </div>
          </form>
          
          <button type="button" class="btn-close">&times;</button>
     </div>
     
</div>

<script src="${pageContext.request.contextPath}/resources/js/login_findId.js"></script>

</body>
</html>