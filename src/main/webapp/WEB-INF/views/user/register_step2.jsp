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
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<!-- 회원가입 아이디 생성 정규식 -->

<script type="text/javascript">
	$(function() {
		// id="submitBtn" 클릭 했을때 form태그 전송
		$('.join-form').submit(function() {
			// 										alert("클릭");
			// 			화면제어
			// 			if($('#id_lbl').val() == ''){
			// 				alert("아이디 입력하세요")
			// 				$('#id_lbl').focus();
			// 				return false;
			// 			}
			if ($('#user_id').val().length == 0) {
				alert("아이디 입력하세요")
				$('#user_id').focus();
				return false;
			}

			// 			정규표현식(Regular Expression)
			// 			: 문자열을 처리하기 위한 패턴 기반의 문자열
			// 			: 정규표현식을 통해 처리할 문자열의 패턴 지정
			// 			: 패스워크 유효성 검사, 전화번호, 이메일 양식 검사
			//  		: 자바, 자바스크립트 모든 언어 사용가능
			// 			: 네트워크, 서버 환경 설정 등 공용으로 사용하는 표준 표현식
			// 			=> 영어만 입력가능[a-zA-Z]
			// 			=> 숫자만 입력가능 [0-9]
			// 			=> 한글만 입력가능 [가-힣]
			// 			=> [] 하나 이상 포함, () 문자열 그대로 포함, {} 문자열 반복
			// 			=> ^ 시작하는 문자열, $ 끝나는 문자열
			//             . 1개 문자, + 반복, * 0번이상 반복
			//             ? 나올 수도 있고 나오지 않을 수도 있는 문자열
			// 		       | 또는 포함되는 문자열

			// 			아이디 => 영문 대소문자, 숫자, 특수문자(_, -) 입력가능
			// 			5 ~ 20 자리 입력 체크
			let idCheck = RegExp(/^[a-z0-9]{6,12}$/);
			if (!idCheck.test($('#user_id').val())) {
				alert("아이디 형식 아님");
				$('#user_id').focus();
				return false;
			}
			// 			비밀번호 => 영문 대소문자, 숫자, 특수문자(!@#$%^*) 하나 이상 포함
			// 			8~16 자리 입력 체크
			// 			let passCheck = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*]).{8,16}$/);
			// 			if(! passCheck.test($('#pwd_lbl').val())){
			// 				alert("비밀번호 형식 아님");
			// 				$('#pwd_lbl').focus();
			// 				return false;
			// 			}

			// 			작성자 => 한글 2 ~ 6

			// 비밀번호 정규식
			let passwordCheck = RegExp(/^[a-z0-9]{6,12}$/);

			if (!passwordCheck.test($('#password').val())) {
				alert("비밀번호 형식이 올바르지 않습니다.");
				$('#password').focus();
				return false;
			}

			// 비밀번호 확인 입력 확인
			let passwordConfirm = $('#passwordCheck').val().trim();
			if (passwordConfirm.length === 0) {
			    alert("비밀번호 확인을 입력하세요.");
			    $('#passwordCheck').focus();
			    return false; // 폼 전송 막기
			}
			
			// 비밀번호 확인 정규식
			if (!passwordCheck.test($('#passwordCheck').val())) {
				alert("비밀번호 확인 형식이 올바르지 않습니다.");
				$('#passwordCheck').focus();
				return false;
			}

			// 두 비밀번호가 같은지 비교
			if ($('#password').val() !== $('#passwordCheck').val()) {
				alert("비밀번호가 서로 일치하지 않습니다.");
				$('#passwordCheck').focus();
				return false;
			}

			// 이름 입력 확인
			let username = $('#username').val().trim(); // 공백 제거
			if (username.length === 0) {
			    alert("이름을 입력하세요.");
			    $('#username').focus();
			    return false; // 폼 전송 막기
			}

			// 이름 정규식 체크
			let nameCheck = /^[가-힣a-zA-Z]{2,30}$/;
			if (!nameCheck.test(username)) {
			    alert("이름은 한글 또는 영문으로 2~30자 입력하세요.");
			    $('#username').focus();
			    return false;
			}
			
			// 별명 입력 확인
			let nickname = $('#nickname').val().trim();
			if (nickname.length === 0) {
			    alert("별명을 입력하세요.");
			    $('#nickname').focus();
			    return false;
			}

			// 별명 정규식 (한글, 영문, 숫자 2~20자)
			let nicknameCheck = /^[가-힣a-zA-Z0-9]{2,20}$/;
			if (!nicknameCheck.test(nickname)) {
			    alert("별명은 한글, 영문, 숫자로 2~20자 입력하세요.");
			    $('#nickname').focus();
			    return false;
			}

			// 이메일 입력 확인
			let email = $('#email').val().trim();
			if (email.length === 0) {
			    alert("이메일을 입력하세요.");
			    $('#email').focus();
			    return false; // 폼 전송 막기
			}

			// 이메일 정규식 체크
			let emailCheck = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
			if (!emailCheck.test(email)) {
			    alert("올바른 이메일 형식이 아닙니다.");
			    $('#email').focus();
			    return false; // 폼 전송 막기
			}
			
			// 성별 체크 확인
			let genderChecked = $('input[name="gender"]:checked').length;
			if (genderChecked === 0) {
			    alert("성별을 선택하세요.");
			    return false; // 폼 전송 막기
			}
			
			

		});
	});
</script>



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
				method : "GET",
				url : "${pageContext.request.contextPath}/register/idCheck",
				data : {
					user_id : $('#user_id').val()
				}, // 파라미터 이름 확인
				dataType : "json",
				success : function(result) {
					//                     alert(JSON.stringify(result)); // 응답 확인
					if (result.exists) { // 예: exists라는 속성을 사용한다고 가정
						$('#divCheck2').html("아이디 중복");
					} else {
						$('#divCheck2').html("아이디 사용가능");
					}
				},
				error : function(xhr, status, error) {
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

			<label for="" id_lbl" class="tit_lbl pilsoo_item" id="">아이디 *</label>
			<div class="input-row" id="divCheck">
				<input type="text" id="user_id" name="user_id"
					placeholder="아이디를 입력하세요">
				<button type="button" id="check-btn" class="check-btn">중복
					확인</button>
			</div>
			<div id="divCheck2"></div>

			<label>비밀번호 *</label> <input type="password" id="password"
				name="password" placeholder="비밀번호 (8자 이상)"> <label>비밀번호
				확인 *</label> <input type="password" id="passwordCheck" name="passwordCheck"
				placeholder="비밀번호를 다시 입력하세요"> <label>이름 *</label> <input
				type="text" id="username" name="username" placeholder="이름을 입력하세요"> <label>별명
				*</label> <input type="text" id="nickname" name="nickname" placeholder="별명을 입력하세요">
			<label>이메일 *</label> <input type="email" id="email" name="email"
				placeholder="example@email.com"> <label>성별 *</label>
			<div class="gender-row">
				<label><input type="radio" id="gender" name="gender" value="m">
					남성</label> <label><input type="radio" id="gender" name="gender" value="f">
					여성</label>
			</div>

			<label>생년월일 *</label> <input type="date" id="birthDate" name="birthDate">
			 <label>전화번호*</label> <input type="tel" name="phone" placeholder="010-0000-0000">

			<div class="btn-row">
				<button type="button" class="prev-btn" onclick="history.back()">이전</button>
				<button type="submit" class="next-btn">다음</button>
			</div>
		</form>
	</div>
</body>
</html>