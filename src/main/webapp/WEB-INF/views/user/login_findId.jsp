<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login_findId.css">
</head>
<body>

    <div id="findIdModal" class="modal-overlay">
        
        <div class="modal-content">
            <h2 class="modal-title">아이디 찾기</h2>
            <p class="modal-description">가입 시 등록한 이름과 이메일을 입력해주세요</p>
            
            <form action="/user/findIdProcess" method="post" id="findIdForm">
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
    
    <button type="button" id="openModalButton" style="margin-top: 50px; padding: 10px; font-size: 16px;">아이디 찾기 팝업 열기 (테스트용)</button>

</body>
</html>