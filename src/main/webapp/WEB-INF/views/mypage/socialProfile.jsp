<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
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

/* 폼 요소 스타일 통일 */
.form-group input[type="text"], .form-group input[type="email"],
	.form-group input[type="password"], .form-group input[type="date"],
	.form-group select { /* select는 현재 사용하지 않지만 스타일 통일을 위해 남겨둠 */
	box-sizing: border-box;
	width: 100%;
	padding: 8px 12px;
	border: 1px solid #ddd; /* 얇은 회색 테두리 */
	border-radius: 4px;
	font-size: 15px;
	box-sizing: border-box;
	background-color: #fff;
	height: 40px; /* 폼 요소 높이 통일 */
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
	cursor: default;
}

.radio-group label {
	cursor: pointer;
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

/* 모달 오버레이 (배경을 어둡게 처리하고 전체 화면을 덮음) */
.modal-overlay {
	/* 🔑 필수: 화면에 고정하고 전체를 덮습니다. */
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	/* 🔑 필수: 배경을 반투명하게 만듭니다. */
	background-color: rgba(0, 0, 0, 0.6);
	/* 🔑 필수: 다른 요소보다 항상 위에 있도록 설정합니다. */
	z-index: 1000;
	/* 내용을 중앙에 배치하기 위한 flex 설정 */
	display: flex;
	justify-content: center;
	align-items: center;
}

.modal-content {
	background-color: #ffffff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
	width: 100%;
	max-width: 400px; /* 모달 크기 제한 */
	transform: translateY(-50px); /* 약간 위에서 내려오는 효과 (선택 사항) */
	transition: transform 0.3s ease-out;
}

/* 모달 내부 버튼 스타일 (메인 저장 버튼과 구분) */
.modal-content .btn-primary, .modal-content .btn-secondary {
	padding: 10px 15px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 15px;
	margin-top: 15px;
	width: 48%; /* 버튼 2개가 가로로 나란히 오도록 */
}

#passwordConfirmModal .btn-primary {
	width: 100%;
	margin-right: 0;
}

.modal-content .btn-primary {
	background-color: #cd0000;
	color: white;
	margin-right: 4%; /* 버튼 사이 간격 */
}

.modal-content .btn-secondary {
	background-color: #6c757d;
	color: white;
}

.modal-content .btn-primary:hover {
	background-color: #a00000;
}

.modal-content .btn-secondary:hover {
	background-color: #5a6268;
}

/* 모달 제목 */
.modal-content h2 {
	text-align: center;
	margin-bottom: 25px;
	color: #333;
	font-size: 20px;
}

#passwordChangeModal .modal-content .btn-primary, #passwordChangeModal .modal-content .btn-secondary
	{
	width: 100%; /* 너비를 100%로 설정하여 입력 필드와 동일한 폭을 가지게 함 */
	margin-top: 10px; /* 버튼 간 세로 간격 조정 */
	margin-right: 0; /* 우측 마진 제거 */
}

/* 첫 번째 버튼 (변경 내용 적용)의 불필요한 마진 제거 */
#passwordChangeModal .modal-content .btn-primary {
	/* 기본 .modal-content .btn-primary에 4% margin-right가 적용되어 있으므로 덮어씁니다. */
	margin-right: 0;
}

#socialAlertModal .modal-content {
    text-align: center;
    max-width: 350px;
}
#socialAlertModal .modal-content h4 {
    color: #cd0000;
    margin-bottom: 15px;
    font-size: 18px;
}
#socialAlertModal .modal-content p {
    font-size: 15px;
    color: #555;
    line-height: 1.4;
    margin-bottom: 25px;
}
.social-login {
    display: block; /* 버튼 그룹이 블록 요소로 전체 너비를 차지하도록 */
    width: 100%;
    margin-bottom: 10px;
}
.social-login .btn-warning {
    box-sizing: border-box;
    background-color: #cd0000; 
    color: white; 
    font-weight: bold;
    border: none;
    padding: 10px;
    border-radius: 4px;
    text-decoration: none;
    display: block;
    width: 100%;
    font-size: 16px;
    transition: background-color 0.2s;
}

#closeModalAndStayBtn {
    box-sizing: border-box;
    width: 100%;
    background-color: #ccc;
    color: #333;
    font-weight: bold;
    border: none;
    border-radius: 4px;
    padding: 10px;
    margin-top: 10px;
}

/* ========================================================== */
/* 🟢 [재추가] 단일 이메일 입력 필드 스타일 및 드롭다운 아이콘 제거 */
/* ========================================================== */
#memberFullEmailInput {
	/* 공통 스타일 상속 */
	width: 100%;
	padding: 8px 12px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 15px;
	height: 40px;
	box-sizing: border-box;
	/* 드롭다운 아이콘 제거 (브라우저별) */
	/* datalist를 사용하면 일부 브라우저에서 드롭다운 아이콘이 생길 수 있으므로 이를 제거합니다. */
	-webkit-appearance: none; /* Chrome, Safari */
	-moz-appearance: none;
	appearance: none;
	 
	  /* Standard */
}

/* Internet Explorer의 드롭다운 버튼 제거 */
#memberFullEmailInput::-ms-expand {
	display: none;
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
		<div class="content-box" id="profileContentBox">
			<h1>회원 정보 수정</h1>


			<div class="profile-section">
				<div class="profile-image-container">

					<c:set var="hasProfileImage"
						value="${not empty loginMember.profileImage}" />

					<img id="profileImagePreview"
						src="<c:url value="${loginMember.profileImage}" />"
						alt="Profile Image Preview"
						style="display: ${hasProfileImage ? 'block' : 'none'};"> <i
						id="profileIcon"
						class="fa-regular fa-circle-user profile-circle-icon"
						style="display: ${hasProfileImage ? 'none' : 'block'};"> </i> <i
						class="fa-solid fa-pencil profile-pencil-icon"
						onclick="document.getElementById('profileImageUpload').click();"></i>

				</div>

				<p class="profile-name-id">${loginMember.username}님</p>
				<p class="profile-id">ID: ${loginMember.user_id}</p>
			</div>
			            
			<form action="<c:url value="/mypage/profile/update" />" method="POST"
				enctype="multipart/form-data" onsubmit="return validateForm()">

				<input type="file" id="profileImageUpload" name="uploadFile"
					accept="image/*" onchange="handleImageUpload(event)"
					style="display: none;"> <input type="hidden"
					id="memberProfileImage" name="profileImage"
					value="${loginMember.profileImage}">

				<div class="form-group">
					<label>닉네임 <span class="required">*</span></label> <input
						type="text" id="memberNickname" name="nickname"
						value="${loginMember.nickname}">
					<div id="nicknameError" class="error-message"></div>
				</div>

				<div class="form-group">
					<label>비밀번호 <span class="required">*</span></label> <input
						type="password" value="********" readonly>

					<p class="help-text">비밀번호는 변경 버튼을 통해 수정할 수 있습니다.</p>

					<div class="password-group">
						<button type="button" class="btn-password-change"
							onclick="openPasswordChangeModal()">
							<i class="fa-solid fa-lock"></i> 비밀번호 변경
						</button>
					</div>
				</div>

				<div id="passwordChangeModal" class="modal-overlay"
					style="display: none;">
					<div class="modal-content">
						<h2>새 비밀번호 변경</h2>

						<div class="form-group">
							<label for="modalNewPassword">새 비밀번호</label> <input
								type="password" id="modalNewPassword" placeholder="새 비밀번호 입력">
							<p id="passwordError" class="error-message" style="color: red;"></p>
						</div>

						<div class="form-group">
							<label for="modalConfirmPassword">새 비밀번호 확인</label> <input
								type="password" id="modalConfirmPassword"
								placeholder="새 비밀번호 확인">
						</div>

						<button type="button" id="applyPasswordBtn"
							class="btn btn-primary">변경 내용 적용</button>
						<button type="button" onclick="closePasswordChangeModal()"
							class="btn btn-secondary">취소</button>
					</div>
				</div>


				<%-- 🟢 [재추가] 단일 이메일 입력 필드에 datalist 속성 및 제안 목록 추가 --%>
				<div class="form-group">
					<label for="memberFullEmailInput">이메일</label>
					<div>
						<input type="text" id="memberFullEmailInput" name="email"
							value="${loginMember.email}" maxlength="50"
							placeholder="이메일 주소를 입력하세요" list="emailDomainSuggestions"
							oninput="updateSuggestions()">

						<%-- 🟢 [재추가] 자동 완성 제안 목록을 담을 datalist --%>
						<datalist id="emailDomainSuggestions">
						</datalist>
					</div>
					<div id="emailError" class="error-message"></div>
				</div>

				<div class="form-group">
					<label>성별</label>
					<div class="radio-group" id="genderGroup">

						<c:set var="genderUpper"
							value="${fn:toUpperCase(loginMember.gender)}" />

						<input type="radio" id="genderM" name="gender" value="M"
							<c:if test="${genderUpper eq 'M'}">checked</c:if>> <label
							for="genderM" style="font-weight: normal; margin-bottom: 0;">남성</label>

						<input type="radio" id="genderF" name="gender" value="F"
							<c:if test="${genderUpper eq 'F'}">checked</c:if>> <label
							for="genderF" style="font-weight: normal; margin-bottom: 0;">여성</label>
					</div>
					<div id="genderError" class="error-message"></div>
				</div>

				<div class="form-group">
					<label for="memberBirth">생년월일</label> <input type="date"
						id="memberBirth" name="birthDate" value="${loginMember.birthDate}">
					<div id="birthError" class="error-message"></div>
				</div>

				<div class="form-group">
					<label for="memberPhone">전화번호</label> <input type="text"
						id="memberPhone" name="phone" value="${loginMember.phone}">
					<div id="phoneError" class="error-message"></div>
				</div>

				<button type="submit" class="submit-button">저장</button>
			</form>

			<button type="button" class="btn-withdrawal"
				onclick="confirmWithdrawal()">회원 탈퇴</button>

		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    
    // 🚨 [삭제] 소셜 로그인 재인증 관련 변수들을 제거했습니다.
    // const alertMessage = "${alertMessage}";
    // const redirectUrl = "${redirectUrl}";
    // const $socialAlertModal = $('#socialAlertModal');
    // const KAKAO_AUTH_URL = "..."; 


    $(document).ready(function() {
        // 🚨 [삭제] 재인증 모달 관련 로직 전체를 제거했습니다.
        /*
        if (alertMessage && redirectUrl) {
            $socialAlertModal.show();
        }
        $('#closeModalAndStayBtn').on('click', function() { ... });
        $('#reauthenticateKakaoBtn').click(function(e) { ... });
        */
        
        // --- 2. [핵심 수정] 비밀번호 변경 모달에서 Enter 키 처리 (유지) ---
        $('#modalNewPassword, #modalConfirmPassword').on('keydown', function(e) {
            if (e.keyCode === 13 || e.key === 'Enter') {
                e.preventDefault(); 
                e.stopPropagation(); 
                $('#applyPasswordBtn').click();
                return false; 
            }
        });

        // --- 3. [변경 내용 적용] 버튼 클릭 이벤트 (유지) ---
        $('#applyPasswordBtn').click(function() {
            const newPwd = $('#modalNewPassword').val();
            const confirmPwd = $('#modalConfirmPassword').val();
            
            const $errorDisplay = $('#passwordError');
            $errorDisplay.text('');
            
            // 1. 유효성 검사
            if (newPwd === '' || confirmPwd === '') {
                $errorDisplay.text('새 비밀번호를 입력해주세요.');
                return;
            }
            if (newPwd.length < 6 || newPwd.length > 12) {	
                $errorDisplay.text('비밀번호는 최소 6자, 최대 12자까지 입력할 수 있습니다.');
                return;
            }
            const invalidCharPattern = /[^a-zA-Z0-9]/;
            if (invalidCharPattern.test(newPwd)) {
                $errorDisplay.text('비밀번호는 영문과 숫자만 포함해야 합니다.');
                return;
            }
            const letterPattern = /[a-zA-Z]/;
            if (!letterPattern.test(newPwd)) {
                $errorDisplay.text('비밀번호는 최소 1개 이상의 영문이 포함되어야 합니다.');
                return;
            }
            const numberPattern = /[0-9]/;
            if (!numberPattern.test(newPwd)) {
                $errorDisplay.text('비밀번호는 최소 1개 이상의 숫자가 포함되어야 합니다.');
                return;
            }
        
            if (newPwd !== confirmPwd) {
                $errorDisplay.text('새 비밀번호와 일치하지 않습니다.');
                return;
            }
            
            // 2. 유효성 검사 통과: 새 비밀번호 업데이트 AJAX 요청
            $.ajax({
                url: '<c:url value="/mypage/profile/updatePassword" />',	
                type: 'POST',
                data: { newPassword: newPwd },	
                dataType: 'json',
                success: function(response) {
                    if (response.isUpdated) {	
                        closePasswordChangeModal();
                        alert('비밀번호가 성공적으로 변경되었습니다!');
                        $('#modalNewPassword').val('');
                        $('#modalConfirmPassword').val('');
                    } else {
                        $errorDisplay.text(response.message || '비밀번호 변경 중 오류가 발생했습니다.');
                    }
                },
                error: function() {
                    $errorDisplay.text('서버 통신 오류가 발생했습니다. (변경 요청)');
                }
            });
        });

        // --- 4. 메인 폼 제출 시 (유지) ---
        $('#updateForm').on('submit', function(e) {
            // 이 핸들러는 다른 데이터 수정 처리를 위해 유지됩니다.
        });
    });
    
    // ==========================================================
    // Controller에서 전달된 메시지 변수 (유지)
    var successMsg = "${msg}";
    var errorMsg = "${errorMsg}";

    // ==========================================================
    // JS 헬퍼 함수 (유지)
    function displayError(elementId, message) {
        const errorElement = document.getElementById(elementId + 'Error');
        if (errorElement) {
            errorElement.textContent = message;
            errorElement.style.display = 'block';
        }
    }

    function clearErrors() {
        document.querySelectorAll('.error-message').forEach(el => {
            el.textContent = '';
            el.style.display = 'none';
        });
    }
    
    // ==========================================================
    // 이메일 자동 완성 로직 (유지)
    const DOMAINS = [
        'naver.com', 'hanmail.net', 'daum.net', 'nate.com', 'gmail.com',
        'hotmail.com', 'outlook.com', 'yahoo.com'
    ];
    
    const currentEmail = "${loginMember.email}";
    let currentDomain = '';
    const atIndexInCurrent = currentEmail.indexOf('@');
    if (atIndexInCurrent !== -1) {
        currentDomain = currentEmail.substring(atIndexInCurrent + 1);
        
        if (currentDomain !== '' && !DOMAINS.includes(currentDomain)) {
            DOMAINS.unshift(currentDomain);
        }
    }

    function updateSuggestions() {
        const fullEmailInput = document.getElementById('memberFullEmailInput');
        const datalist = document.getElementById('emailDomainSuggestions');
        if (!fullEmailInput) return;

        const inputValue = fullEmailInput.value.trim();
        let idPart = inputValue;
        const atIndex = inputValue.indexOf('@');
        
        if (atIndex !== -1) {
            idPart = inputValue.substring(0, atIndex);
        }

        if (datalist) datalist.innerHTML = '';

        if (idPart === '' || (atIndex !== -1 && inputValue.substring(atIndex + 1).length > 0 && !inputValue.includes('.'))) return;


        DOMAINS.forEach(domain => {
            if (atIndex !== -1) {
                const domainPart = inputValue.substring(atIndex + 1);
                if (!domain.startsWith(domainPart)) return;
            }
            
            const option = document.createElement('option');
            option.value = idPart + '@' + domain;
            if (datalist) datalist.appendChild(option);
        });
    }
    
    document.addEventListener('DOMContentLoaded', function() {
        updateSuggestions();
    });


    // 이미지 업로드 및 미리보기 처리 함수 (유지)
    function handleImageUpload(event) {
        const file = event.target.files[0];
        const preview = document.getElementById('profileImagePreview');
        const icon = document.getElementById('profileIcon');
        
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                if (preview) preview.src = e.target.result;
                if (preview) preview.style.display = 'block';
                if (icon) icon.style.display = 'none';
            };
            reader.readAsDataURL(file);
        } else {
            if (preview) preview.src = '';
            if (preview) preview.style.display = 'none';
            if (icon) icon.style.display = 'block';
        }
    }

    // ==========================================================
    // 폼 유효성 검사 (validateForm) - 유지
    function validateForm() {
        clearErrors();	
        let isValid = true;
        
        const nickname = document.getElementById('memberNickname');
        	

        // 닉네임 검사
        if (!nickname || nickname.value.trim() === "") {
            displayError('nickname', "닉네임을 입력해주세요.");
            if (nickname) nickname.focus();	
            isValid = false;
        }
        
        // 이메일 검사
        const fullEmailInput = document.getElementById('memberFullEmailInput');
        let fullEmail = fullEmailInput ? fullEmailInput.value.trim() : '';
        
        if (isValid && fullEmail !== "") { 
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(fullEmail)) {
            displayError('email', "유효한 이메일 형식(예: user@example.com)이 아닙니다.");
            fullEmailInput.focus();
            isValid = false;
        }
    }
        
        // 전화번호 검사 및 형식 검사
        const phone = document.getElementById('memberPhone');
    if (isValid && phone.value.trim() !== "") { 
        const phonePattern = /^\d{2,3}-\d{3,4}-\d{4}$/;
        if (!phonePattern.test(phone.value.trim())) {
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
    
    // ==========================================================
    // 🟢 [핵심 수정] 모달 관련 함수: 비밀번호 변경 불가 알림으로 대체
    // ==========================================================
    function openPasswordChangeModal() {
        // 소셜 로그인 사용자는 비밀번호 변경을 막고 알림을 띄웁니다.
        alert("소셜 로그인 상태에서는 비밀번호를 변경할 수 없습니다.");
        
        // 기존에 모달을 열던 코드는 주석 처리 또는 제거했습니다.
        // $('#passwordChangeModal').show();	
        // $('#modalNewPassword').val('');	
        // $('#modalConfirmPassword').val('');	
        // $('#passwordError').text('');
    }
    
    function closePasswordChangeModal() {
        // 이 함수는 모달이 실제로 열리지 않기 때문에 아무 일도 하지 않지만, 오류 방지를 위해 남겨둡니다.
        $('#passwordChangeModal').hide();
    }
    
    // ==========================================================
    // 회원 탈퇴 확인 및 처리 함수 (유지)
    // ==========================================================
    function confirmWithdrawal() {
        if (confirm("정말로 회원 탈퇴를 하시겠습니까? 모든 정보가 삭제되며 복구할 수 없습니다.")) {
            
            $.ajax({
                url: '<c:url value="/mypage/profile/withdrawal" />',	
                type: 'POST',	
                dataType: 'json',	
                success: function(response) {
                    if (response.isSuccess) {	
                        alert("탈퇴 완료 되었습니다.");
                        window.location.href = '${contextPath}/main';
                    } else {
                        alert(response.message || '탈퇴 처리 중 오류가 발생했습니다.');
                    }
                },
                error: function() {
                    alert('서버 통신 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.');
                }
            });
        }
    }
</script>
</body>
</html>