<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/register_step2.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<!-- 아이디 중복체크 -->
<script type="text/javascript">
    $(function() {
        $('#check-btn').click(function() {
//             alert("클릭");
            if ($('#user_id').val() == "") {
                alert("아이디 입력하세요");
                $('#user_id').focus();
                return;
            }

            $.ajax({
                method: "GET",
                url: "${pageContext.request.contextPath}/register/idCheck",
                data: { user_id: $('#user_id').val() }, // 파라미터 이름 확인
                dataType: "json",
                success: function(result) {
//                     alert(JSON.stringify(result)); // 응답 확인
                    if (result.exists) { // 예: exists라는 속성을 사용한다고 가정
                        $('#divCheck2').html("아이디 중복");
                    } else {
                        $('#divCheck2').html("아이디 사용가능");
                    }
                },
                error: function(xhr, status, error) {
                    alert("요청 중 오류가 발생했습니다: " + error);
                }
            });
        });
    });
</script>

</head>

<body>
	<div class="join-container">
		<form class="join-form"
			action="${pageContext.request.contextPath}/register/step2Pro"
			method="post">
			<h2>정보 입력</h2>

			<label>아이디 *</label>
			<div class="input-row" id="divCheck">
				<input type="text" id="user_id" name="user_id" placeholder="아이디를 입력하세요" required>
				<button type="button" id="check-btn" class="check-btn">중복 확인</button>
			</div>
			<div id="divCheck2"></div>

			<label>비밀번호 *</label> <input type="password" name="password"
				placeholder="비밀번호 (8자 이상)" required> <label>비밀번호 확인
				*</label> <input type="password" name="passwordCheck"
				placeholder="비밀번호를 다시 입력하세요" required> <label>이름 *</label> <input
				type="text" name="username" placeholder="이름을 입력하세요" required>

			<label>별명 *</label> <input type="text" name="nickname"
				placeholder="별명을 입력하세요" required> <label>이메일 *</label> <input
				type="email" name="email" placeholder="example@email.com" required>

			<label>성별 *</label>
			<div class="gender-row">
				<label><input type="radio" name="gender" value="m">
					남성</label> <label><input type="radio" name="gender" value="f">
					여성</label>
			</div>

			<label>생년월일 *</label> <input type="date" name="birthDate" required>

			<label>전화번호 *</label> <input type="tel" name="phone"
				placeholder="010-0000-0000" required>

			<div class="btn-row">
				<button type="button" class="prev-btn" onclick="history.back()">이전</button>
				<button type="submit" class="next-btn">다음</button>
			</div>
		</form>
	</div>
</body>
</html>
