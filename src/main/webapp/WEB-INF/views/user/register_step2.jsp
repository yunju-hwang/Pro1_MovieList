<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입 - 2단계</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/register_step2.css" />
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script>
	const contextPath = "${pageContext.request.contextPath}";
</script>
<script
	src="${pageContext.request.contextPath}/resources/js/register_step2_validation.js"></script>


</head>
<body>
	<div class="join-container">
		<form class="join-form"
			action="${pageContext.request.contextPath}/register/step2Pro"
			method="post">
			<h2>회원 정보 입력</h2>

			<label>아이디 *</label>
			<div class="input-row">
				<input type="text" id="user_id" name="user_id"
					placeholder="아이디를 입력하세요" value="${user_id != null ? user_id : ''}">
				<button type="button" id="check-btn" class="check-btn">중복
					확인</button>
			</div>
			<span id="userIdError"
				style="color: red; display: block; min-height: 18px;"></span> <input
				type="hidden" id="user_idChecked" value="false"> <label>비밀번호
				*</label> <input type="password" id="password" name="password"
				placeholder="비밀번호 (6~12자리)"> <span id="passwordError"
				style="color: red; display: block; min-height: 18px;"></span> <label>비밀번호
				확인 *</label> <input type="password" id="passwordCheck" name="passwordCheck"
				placeholder="비밀번호 재입력"> <span id="passwordCheckError"
				style="color: red; display: block; min-height: 18px;"></span> <label>이름
				*</label> <input type="text" id="username" name="username"
				placeholder="이름을 입력하세요" value="${username != null ? username : ''}">
			<span id="usernameError" style="display: block; min-height: 18px;"></span>

			<label>별명 *</label> <input type="text" id="nickname" name="nickname"
				placeholder="별명을 입력하세요" value="${nickname != null ? nickname : ''}">
			<span id="nicknameError"
				style="color: red; display: block; min-height: 18px;"></span> <label>이메일
				*</label>
			<div class="email-row">
				<!-- 이메일 아이디 입력 필드 -->
				<input type="text" id="emailId" name="emailId" placeholder="이메일 아이디"
					value="${emailId != null ? emailId : ''}"> <span>@</span>

				<!-- 이메일 도메인 입력 필드 (직접 입력 가능 / 드롭다운 선택 가능) -->
				<input type="text" id="emailDomain" name="emailDomain"
					placeholder="naver.com"
					value="${emailDomain != null ? emailDomain : 'naver.com'}" disabled>

				<!-- 이메일 도메인 선택 드롭다운 -->
				<select id="emailDomainSelect" name="emailDomainSelect">
					<option value="">직접 입력</option>
					<option value="naver.com">naver.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="daum.net">daum.net</option>
					<option value="kakao.com">kakao.com</option>
				</select>

				<!-- 최종 이메일을 저장할 hidden 필드 -->
				<input type="hidden" id="email" name="email">
			</div>

			<!-- 이메일 오류 메시지 -->
			<span id="emailError"
				style="color: red; display: block; min-height: 18px;"></span> <input
				type="hidden" id="emailChecked" value="false"> <label>성별
				*</label>
			<div class="gender-row">
				<label><input type="radio" name="gender" value="m"
					${gender == 'm' ? 'checked' : ''}>남성</label> <label><input
					type="radio" name="gender" value="f"
					${gender == 'f' ? 'checked' : ''}>여성</label>
			</div>

			<!-- 성별 오류 메시지 -->
			<span id="genderError" class="error-message"></span> <label>생년월일
				*</label> <input type="date" id="birthDate" name="birthDate"
				value="${birthDate != null ? birthDate : ''}">

			<!-- 생년월일 오류 메시지 -->
			<span id="birthDateError" class="error-message"></span> <label>전화번호
				*</label>
			<div class="phone-row">
				<div class="area-code-container">
					<!-- 지역번호 드롭다운 -->
					<select id="areaCodeSelect" name="areaCode">
						<option value="010">010</option>
						<option value="02">02</option>
						<option value="031">031</option>
						<option value="032">032</option>
						<option value="033">033</option>
						<option value="041">041</option>
						<option value="042">042</option>
						<option value="043">043</option>
						<option value="044">044</option>
						<option value="051">051</option>
						<option value="052">052</option>
						<option value="053">053</option>
						<option value="054">054</option>
						<option value="055">055</option>
						<option value="061">061</option>
						<option value="062">062</option>
						<option value="063">063</option>
						<option value="064">064</option>
					</select>
				</div>

				<span>-</span>

				<!-- 중간번호와 끝번호 입력칸 -->
				<input type="text" id="middle" name="middle" placeholder="0000"
					maxlength="4"> <span>-</span> <input type="text" id="end"
					name="end" placeholder="0000" maxlength="4">
			</div>

			<!-- 최종 DB로 넘어가는 phone 필드 -->
			<input type="hidden" id="phone" name="phone">

			<!-- 전화번호 중복 체크 결과 표시 -->
			<span id="phoneError"
				style="color: red; display: block; min-height: 18px;"></span> <input
				type="hidden" id="phoneChecked" value="false">




			<div class="btn-row">
				<button type="button" class="prev-btn" onclick="history.back()">이전</button>
				<button type="submit" class="next-btn">다음</button>
			</div>


		</form>
	</div>
</body>
</html>