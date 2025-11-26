<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 - 약관 동의</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/register_step1.css" />
</head>
<body>
    <div class="terms-container">
        <h3>약관 동의</h3>
        <form action="${pageContext.request.contextPath}/register/step2" method="POST">
            <div class="checkbox-group">
                <label> <input type="checkbox" id="allAgree" /> 전체 동의 </label>
            </div>
            <div class="checkbox-group sub-checks">
                <label> <input type="checkbox" name="agree_terms" value="agree_terms" required /> [필수] 이용약관 동의 </label>
                <a href="#" class="view-link">보기</a>
            </div>
            <div class="checkbox-group sub-checks">
                <label> <input type="checkbox" name="agree_privacy" value="agree_privacy" required /> [필수] 개인정보 처리방침 동의 </label>
                <a href="#" class="view-link">보기</a>
            </div>
            <div class="checkbox-group sub-checks">
                <label> <input type="checkbox" name="agree_marketing" value="agree_marketing" /> [선택] 마케팅 정보 수신 동의 </label>
                <a href="#" class="view-link">보기</a>
            </div>
            <div class="buttons">
                <button type="button" onclick="history.back()">취소</button>
                <button type="submit" id="nextBtn" disabled>다음</button>
            </div>
        </form>
    </div>

    <!-- JS 파일 분리 -->
    <script src="${pageContext.request.contextPath}/resources/js/register_step1_Agree.js"></script>
</body>
</html>
