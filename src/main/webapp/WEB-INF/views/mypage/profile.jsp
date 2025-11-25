<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 | 회원 정보 수정</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
/* (스타일 유지) */
/* ========================================================== */
/* 1. NAV BAR 스타일 (기존 유지) */
/* ========================================================== */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f7f7f7;
	min-height: 100vh;
}

.header-nav {
	width: 100%;
	background-color: #ffffff;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
	padding: 3px 0;
}

.header-nav ul {
	list-style: none;
	padding: 0;
	margin: 0;
	display: flex;
	justify-content: center;
}

.header-nav li {
	padding: 12px 20px;
	font-size: 14px;
	color: #555;
	cursor: pointer;
	transition: color 0.3s, background-color 0.3s;
	border-bottom: none;
	border-radius: 4px;
	margin: 0 7px;
}

.header-nav li:hover {
	color: white;
	background-color: #cd0000;
}

.header-nav li a {
	text-decoration: none;
	color: inherit;
	display: flex;
	align-items: center;
}

.header-nav li.active {
	color: white;
	background-color: #cd0000;
	border-bottom: none;
	font-weight: bold;
}

.header-nav li.active:hover {
	background-color: #a00000;
	color: white;
}

.header-nav li i {
	margin-right: 5px;
}

/* ========================================================== */
/* 2. 메인 컨텐츠 스타일 */
/* ========================================================== */
.container {
	padding: 40px 20px;
	width: 100%;
	max-width: 500px;
	margin: 40px auto;
}

.content-box {
	background-color: #ffffff;
	padding: 40px;
	border-radius: 8px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.content-box h1 {
	text-align: center;
	margin-bottom: 30px;
	font-size: 24px;
	color: #333;
}

/* ========================================================== */
/* 3. 회원 정보 폼 전용 스타일 (상세) */
/* ========================================================== */
.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold;
	color: #333;
	font-size: 15px;
}

/* 필수 항목 별표(*) 스타일 */
.form-group label .required {
	color: #cd0000;
	margin-left: 3px;
	font-size: 1.1em;
}

.form-group input[type="text"], .form-group input[type="email"],
	.form-group input[type="password"], .form-group input[type="date"],
	.form-group select { /* select 추가 */
	width: 100%;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 15px;
	box-sizing: border-box;
	background-color: #fff;
}

/* 아이디와 같은 수정 불가 필드 스타일 */
.form-group input:read-only {
	background-color: #f0f0f0;
	color: #666;
	cursor: not-allowed;
}

.help-text {
	font-size: 12px;
	color: #888;
	margin-top: 5px;
}

/* 오류 메시지 스타일 */
.error-message {
	color: #cd0000; /* 빨간색 */
	font-size: 13px;
	margin-top: 5px;
	display: none; /* 초기에는 숨김 */
	font-weight: bold;
}

/* 성별 라디오 버튼 그룹 스타일 */
.radio-group {
	display: flex;
	gap: 20px;
	align-items: center;
	padding: 12px 0;
}

.radio-group input[type="radio"] {
	margin-right: 5px;
}

/* 비밀번호 변경 버튼 그룹 */
.password-group {
	display: flex;
	justify-content: flex-end;
	margin-top: 10px;
}

/* 비밀번호 변경 버튼 스타일 */
.btn-password-change {
	background-color: #cd0000;
	color: white;
	border: none;
	padding: 10px 15px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.2s;
}

.btn-password-change:hover {
	background-color: #a00000;
}

/* 저장 버튼 */
.submit-button {
	width: 100%;
	background-color: #cd0000;
	color: white;
	border: none;
	padding: 15px;
	border-radius: 4px;
	font-size: 17px;
	font-weight: bold;
	cursor: pointer;
	margin-top: 30px;
	transition: background-color 0.2s;
}

.submit-button:hover {
	background-color: #a00000;
}

/* 회원 탈퇴 버튼 스타일 */
.btn-withdrawal {
	width: 100%;
	background-color: #6c757d;
	color: white;
	border: none;
	padding: 10px;
	border-radius: 4px;
	font-size: 15px;
	font-weight: bold;
	cursor: pointer;
	margin-top: 20px;
}

.btn-withdrawal:hover {
	background-color: #5a6268;
}

/* 프로필 이미지 및 파일 업로드 관련 스타일 */
.profile-section {
	text-align: center;
	margin-bottom: 30px;
}

.profile-image-container {
	position: relative;
	display: inline-block;
	width: 90px;
	height: 90px;
	margin-bottom: 10px;
}

/* 기본 프로필 아이콘 */
.profile-circle-icon {
	font-size: 80px;
	color: #ccc;
	line-height: 90px;
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: block;
}

/* 프로필 미리보기 이미지 스타일 */
#profileImagePreview {
	width: 90px;
	height: 90px;
	border-radius: 50%;
	object-fit: cover;
	position: absolute;
	top: 0;
	left: 0;
	display: none;
}

/* 연필 아이콘 스타일 */
.profile-pencil-icon {
	position: absolute;
	bottom: 0;
	right: 0;
	background-color: #cd0000;
	color: white;
	border-radius: 50%;
	padding: 3px;
	font-size: 10px;
	cursor: pointer;
	width: 18px;
	height: 18px;
	display: flex;
	align-items: center;
	justify-content: center;
	border: 2px solid #fff;
	box-shadow: 0 0 3px rgba(0, 0, 0, 0.2);
	z-index: 10;
}

.profile-section input[type="file"] {
	display: none;
}

/* 아이디와 이름 표시 스타일 */
.profile-name-id {
	font-size: 16px;
	color: #333;
	font-weight: bold;
	margin-bottom: 5px;
}

.profile-id {
	font-size: 14px;
	color: #666;
	margin-bottom: 20px;
}

/* 이메일 입력 그룹 스타일 */
.email-input-group {
	/* 이메일 필드를 하나로 통일했으므로 flex 속성은 유지해도 되지만, input이 100%를 차지하게 됩니다. */
	display: flex;
	align-items: center;
	gap: 10px;
}

/* 단일 이메일 input에 100% 적용 */
.email-input-group input[type="text"] {
	width: 100% !important;
}

.email-input-group .at-sign {
	font-weight: bold;
	color: #333;
	font-size: 16px;
	flex-shrink: 0;
}
</style>
</head>
<body>

	<div class="header-nav">
		<ul>
			<li><a href="/movielist/mypage/reservations"><i
					class="fa-solid fa-calendar-check"></i> 예매 내역</a></li>
			<li><a href="/movielist/mypage/favorites"><i
					class="fa-regular fa-heart"></i> 관심 목록</a></li>
			<li class="active"><a href="/movielist/mypage/profile"><i
					class="fa-regular fa-user"></i> 회원 정보</a></li>
			<li><a href="/movielist/mypage/theaters"><i
					class="fa-solid fa-map-pin"></i> 선호 영화관</a></li>
			<li><a href="/movielist/mypage/inquiries"><i
					class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
			<li><a href="/movielist/mypage/movierequest"><i
					class="fa-solid fa-film"></i> 영화 요청</a></li>
		</ul>
	</div>

	<div class="container">
		<div class="content-box">
			<h1>회원 정보 수정</h1>

			<div class="profile-section">
				<div class="profile-image-container">

					<c:set var="hasProfileImage"
						value="${not empty loginMember.profileImage}" />

					<img id="profileImagePreview" src="${loginMember.profileImage}"
						alt="Profile Image Preview"
						style="display: ${hasProfileImage ? 'block' : 'none'};"> <i
						id="profileIcon"
						class="fa-regular fa-circle-user profile-circle-icon"
						style="display: ${hasProfileImage ? 'none' : 'block'};"> </i> <i
						class="fa-solid fa-pencil profile-pencil-icon"
						onclick="document.getElementById('profileImageUpload').click();"></i>

					<input type="file" id="profileImageUpload" name="profileImage"
						accept="image/*" onchange="handleImageUpload(event)">
				</div>

				<p class="profile-name-id">${loginMember.username}님</p>
				<p class="profile-id">ID: ${loginMember.user_id}</p>
			</div>

			<form action="/mypage/profile/update" method="POST"
				onsubmit="return validateForm()">

				<div class="form-group">
					<label>닉네임</label> <input type="text"
						value="${loginMember.user_id}">
				</div>

				<div class="form-group">
					<label>비밀번호 <span class="required">*</span></label> <input
						type="password" readonly>
					<p class="help-text">비밀번호는 보안을 위해 별도의 변경 절차를 거칩니다.</p>
					<div class="password-group">
						<button type="button" class="btn-password-change"
							onclick="openPasswordChangeModal()">
							<i class="fa-solid fa-lock"></i> 비밀번호 변경
						</button>
					</div>
				</div>

				<div class="form-group">
					<label for="memberEmail">이메일 <span class="required">*</span></label>
					<div class="email-input-group">
						<input type="text" id="memberEmail" name="memberEmail"
							value="${loginMember.email}">

					</div>
					<div id="emailError" class="error-message"></div>
				</div>

				<div class="form-group">
					<label>성별 <span class="required">*</span></label>
					<div class="radio-group" id="genderGroup">

						<%-- **Step 1: DB에서 불러온 성별 값을 대문자로 변환하여 변수에 저장합니다.** --%>
						<c:set var="genderUpper"
							value="${fn:toUpperCase(loginMember.gender)}" />

						<%-- **Step 2: 변환된 genderUpper 값과 'M'을 비교합니다.** --%>
						<input type="radio" id="genderM" name="memberGender" value="M"
							<c:if test="${genderUpper eq 'M'}">checked</c:if>> <label
							for="genderM" style="font-weight: normal; margin-bottom: 0;">남성</label>

						<%-- **Step 3: 변환된 genderUpper 값과 'F'를 비교합니다.** --%>
						<input type="radio" id="genderF" name="memberGender" value="F"
							<c:if test="${genderUpper eq 'F'}">checked</c:if>> <label
							for="genderF" style="font-weight: normal; margin-bottom: 0;">여성</label>
					</div>
					<div id="genderError" class="error-message"></div>
				</div>

				<div class="form-group">
					<label for="memberBirth">생년월일 <span class="required">*</span></label>
					<input type="date" id="memberBirth" name="memberBirth"
						value="${loginMember.birthDate}">
					<div id="birthError" class="error-message"></div>
				</div>

				<div class="form-group">
					<label for="memberPhone">전화번호 <span class="required">*</span></label>
					<input type="text" id="memberPhone" name="memberPhone"
						value="${loginMember.phone}">
					<div id="phoneError" class="error-message"></div>
				</div>

				<button type="submit" class="submit-button">저장</button>
			</form>

			<button type="button" class="btn-withdrawal"
				onclick="openWithdrawalConfirm()">회원 탈퇴</button>

		</div>
	</div>

	<script>
        // 헬퍼 함수: 오류 메시지 표시
        function displayError(elementId, message) {
            // memberEmail의 오류 메시지는 id="emailError"에 표시해야 합니다.
            const errorElement = document.getElementById(elementId + 'Error');
            if (errorElement) {
                errorElement.textContent = message;
                errorElement.style.display = 'block';
            }
        }

        // 헬퍼 함수: 모든 오류 메시지 숨김
        function clearErrors() {
            document.querySelectorAll('.error-message').forEach(el => {
                el.textContent = '';
                el.style.display = 'none';
            });
        }
        
        // 🚨 이메일 도메인 변경 함수는 사용하지 않으므로 제거하거나 주석 처리합니다.
        // function changeEmailDomain(value) { ... } 
        
        // 이미지 업로드 및 미리보기 처리 함수 (기존 유지)
        function handleImageUpload(event) {
            const file = event.target.files[0];
            const preview = document.getElementById('profileImagePreview');
            const icon = document.getElementById('profileIcon');

            if (file) {
                const reader = new FileReader();

                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    icon.style.display = 'none';
                };

                reader.readAsDataURL(file);
            } else {
                // 파일 선택 취소 시, 기존 DB 값(loginMember.profileImage)이 남아있다면 그걸 표시하도록 로직을 추가할 수 있지만, 
                // 간단하게는 기본 아이콘을 다시 표시하도록 합니다.
                // **DB 저장된 이미지가 있을 경우:** 파일 선택 취소 시 DB 이미지를 보여주는 로직이 필요할 수 있으나, 
                // 여기서는 파일 업로드 input 기준의 로직만 유지합니다.
                preview.src = '';
                preview.style.display = 'none';
                icon.style.display = 'block';
            }
        }

        // 폼 유효성 검사 (인라인 오류 메시지 사용)
        function validateForm() {
            clearErrors();    
            let isValid = true;
            
            // 🚨 단일 이메일 필드로 변경
            const email = document.getElementById('memberEmail');
            const birth = document.getElementById('memberBirth');
            const phone = document.getElementById('memberPhone');
            const genderSelected = document.querySelector('input[name="memberGender"]:checked');
            
            // 1. 이메일 검사 (단일 필드)
            if (email.value.trim() === "") {
                displayError('email', "이메일을 입력해주세요.");
                email.focus();
                isValid = false;
            } else {
                // 2. 이메일 형식 검사 (간단한 @와 . 포함 여부)
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailPattern.test(email.value.trim())) {
                    displayError('email', "유효한 이메일 형식(예: user@example.com)을 입력해주세요.");
                    email.focus();
                    isValid = false;
                }
            }
            
            // 3. 성별 선택 검사
            if (isValid && (!genderSelected || (genderSelected.value !== 'M' && genderSelected.value !== 'F'))) {
                displayError('gender', "성별을 선택해주세요.");
                isValid = false;
            }
            
            // 4. 생년월일 검사
            if (isValid && birth.value.trim() === "") {
                displayError('birth', "생년월일을 입력해주세요.");
                birth.focus();
                isValid = false;
            }
            
            // 5. 전화번호 검사
            if (isValid && phone.value.trim() === "") {
                displayError('phone', "전화번호는 필수 입력 항목입니다.");
                phone.focus();
                isValid = false;
            }
            
            // 6. 전화번호 형식 검사
            if (isValid) {
                const phonePattern = /^\d{2,3}-\d{3,4}-\d{4}$/;
                if (phone.value.trim().length > 0 && !phonePattern.test(phone.value.trim())) {
                    displayError('phone', "유효한 전화번호 형식(010-XXXX-XXXX)으로 입력해주세요.");
                    phone.focus();
                    isValid = false;
                }
            }

            if (isValid) {
                return confirm("회원 정보를 수정하시겠습니까?");
            }
            
            return false;
        }
        
        // 비밀번호 변경 모달/팝업 호출 함수 (더미)
        function openPasswordChangeModal() {
            alert("비밀번호 변경을 위해 현재 비밀번호를 확인하는 팝업/모달이 곧 표시됩니다.");
        }
        
        // 회원 탈퇴 확인 함수 (더미)
        function openWithdrawalConfirm() {
            if (confirm("정말로 회원 탈퇴를 하시겠습니까? 모든 정보가 삭제되며 복구할 수 없습니다.")) {
                 alert("회원 탈퇴 처리를 위한 비밀번호 확인 창으로 이동합니다.");
                 // window.location.href = "/mypage/withdrawalConfirm"; // 실제 탈퇴 확인 페이지로 이동
            }
        }
        
    </script>
</body>
</html>