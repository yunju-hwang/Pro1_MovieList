<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<head>
<meta charset="UTF-8" />
<title>회원가입 - 약관동의</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/register_step1.css" />



</head>
<body>
	<div class="terms-container">
		<h3>약관 동의</h3>
		<form action="${pageContext.request.contextPath}/register/step2"
			method="get" id="termsForm">
			<div class="checkbox-group">
				<label> <input type="checkbox" id="allAgree" /> 전체 동의
				</label>
			</div>
			<div class="checkbox-group sub-checks">
				<label> <input type="checkbox" name="agree" value="terms"
					required /> [필수] 이용약관 동의
				</label> <a href="#" class="view-link">보기</a>
			</div>
			<div class="checkbox-group sub-checks">
				<label> <input type="checkbox" name="agree" value="privacy"
					required /> [필수] 개인정보 처리방침 동의
				</label> <a href="#" class="view-link">보기</a>
			</div>
			<div class="checkbox-group sub-checks">
				<label> <input type="checkbox" name="agree"
					value="marketing" /> [선택] 마케팅 정보 수신 동의
				</label> <a href="#" class="view-link">보기</a>
			</div>
			<div class="buttons">
				<button type="button" onclick="history.back()">취소</button>
				<button type="submit" id="nextBtn" disabled>다음</button>
			</div>
		</form>
	</div>

	<script>
        const allAgree = document.getElementById('allAgree');
        const checkboxes = document.querySelectorAll('input[name="agree"]');
        const nextBtn = document.getElementById('nextBtn');

        allAgree.addEventListener('change', e => {
            checkboxes.forEach(checkbox => {
                checkbox.checked = allAgree.checked;
            });
            checkNextBtn();
        });

        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', e => {
                // 전체 동의 체크박스 상태 변경
                allAgree.checked = [...checkboxes].every(chk => chk.checked);
                checkNextBtn();
            });
        });

        function checkNextBtn(){
            // 필수 항목 2개 모두 체크되어야 다음 버튼 활성화
            const requiredChecked = [...checkboxes].filter(chk => chk.required && chk.checked).length === 2;
            nextBtn.disabled = !requiredChecked;
        }dddd
    </script>
</body>
</html>