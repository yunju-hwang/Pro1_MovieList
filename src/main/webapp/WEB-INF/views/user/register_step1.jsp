<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MovieList - 회원가입</title>
<script>
    function toggleAllCheckboxes() {
        var agreeAll = document.getElementById("agreeAll");
        var agreeTerms = document.getElementById("agreeTerms");
        var agreePrivacy = document.getElementById("agreePrivacy");
        var agreeMarketing = document.getElementById("agreeMarketing");
        
        agreeTerms.checked = agreeAll.checked;
        agreePrivacy.checked = agreeAll.checked;
        agreeMarketing.checked = agreeAll.checked;
    }
</script>
</head>
<body>
    <h1>MovieList 회원가입</h1>
    <form action="register.jsp" method="post">
        <h2>약관 동의</h2>
        <div>
            <input type="checkbox" name="agreeAll" id="agreeAll" onclick="toggleAllCheckboxes()"> 
            <label for="agreeAll">전체 동의</label>
        </div>
        <div>
            <input type="checkbox" name="agreeTerms" id="agreeTerms" required>
            <label for="agreeTerms">[필수] 이용약관 동의</label>
            <a href="#" class="view-terms">보기</a>
        </div>
        <div>
            <input type="checkbox" name="agreePrivacy" id="agreePrivacy" required>
            <label for="agreePrivacy">[필수] 개인정보 처리방침 동의</label>
            <a href="#" class="view-privacy">보기</a>
        </div>
        <div>
            <input type="checkbox" name="agreeMarketing" id="agreeMarketing">
            <label for="agreeMarketing">[선택] 마케팅 정보 수신 동의</label>
            <a href="#" class="view-marketing">보기</a>
        </div>
     
        
        <div>
    		<button type="button" onclick="history.back()">취소</button>
    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/register/step2'">다음</button>
		</div>
		
    </form>
</body>
</html>
