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

/* 폼 요소 스타일 통일 */
.form-group input[type="text"], .form-group input[type="email"],
	.form-group input[type="password"], .form-group input[type="date"],
	.form-group select { /* select는 현재 사용하지 않지만 스타일 통일을 위해 남겨둠 */
	width: 100%;
	padding: 8px 12px;
	border: 1px solid #ddd; /* 얇은 회색 테두리 */
	border-radius: 4px;
	font-size: 15px;
	box-sizing: border-box;
	background-color: #fff;
	 
	 
	height
	:
	40px; /* 폼 요소 높이 통일 */
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
	 
	  /* Firefox */
	appearance
	:
	none;
	 
	 
	 
	 
	  /* Standard */
}

/* Internet Explorer의 드롭다운 버튼 제거 */
#memberFullEmailInput::-ms-expand {    display:none;
	
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

			<!--         <div class="message-container"> -->
			<%--             <c:if test="${not empty msg}"> --%>
			<!--                 <div class="alert alert-success" role="alert"> -->
			<%--                     <i class="fa-solid fa-check-circle"></i> ${msg} --%>
			<!--                 </div> -->
			<%--             </c:if> --%>

			<%--             <c:if test="${not empty errorMsg}"> --%>
			<!--                 <div class="alert alert-danger" role="alert"> -->
			<%--                     <i class="fa-solid fa-triangle-exclamation"></i> ${errorMsg} --%>
			<!--                 </div> -->
			<%--             </c:if> --%>
			<!--         </div> -->


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
						type="password" readonly>
					<p class="help-text">비밀번호는 보안을 위해 별도의 변경 절차를 거칩니다.</p>
					<div class="password-group">
						<button type="button" class="btn-password-change"
							onclick="openPasswordChangeModal()">
							<i class="fa-solid fa-lock"></i> 비밀번호 변경
						</button>
					</div>
				</div>

				<%-- 🟢 [재추가] 단일 이메일 입력 필드에 datalist 속성 및 제안 목록 추가 --%>
				<div class="form-group">
					<label for="memberFullEmailInput">이메일 <span
						class="required">*</span></label>
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
					<label>성별 <span class="required">*</span></label>
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
					<label for="memberBirth">생년월일 <span class="required">*</span></label>
					<input type="date" id="memberBirth" name="birthDate"
						value="${loginMember.birthDate}">
					<div id="birthError" class="error-message"></div>
				</div>

				<div class="form-group">
					<label for="memberPhone">전화번호 <span class="required">*</span></label>
					<input type="text" id="memberPhone" name="phone"
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
	
	// 🟢 Controller에서 전달된 메시지 변수를 JavaScript로 가져옵니다.
    // (RedirectAttributes를 통해 넘어온 값이 여기에 삽입됩니다.)
    var successMsg = "${msg}";
    var errorMsg = "${errorMsg}";

    window.onload = function() {
        // 1. 오류 메시지 (errorMsg)가 있을 경우
        if (errorMsg && errorMsg.trim() !== '') {
            // 중복 오류 메시지를 알림으로 띄웁니다.
            alert(errorMsg);
        } 
        // 2. 성공 메시지 (msg)가 있을 경우
        else if (successMsg && successMsg.trim() !== '') {
            // 회원 정보 수정 성공 메시지를 알림으로 띄웁니다.
            alert(successMsg);
        }
    };
        // ==========================================================
        // JS 헬퍼 함수
        // ==========================================================
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
        // 🟢 [재추가] 이메일 자동 완성 도메인 목록 및 로직
        // ==========================================================
		// 자주 사용되는 도메인 목록
		const DOMAINS = [
			'naver.com', 'hanmail.net', 'daum.net', 'nate.com', 'gmail.com',
			'hotmail.com', 'outlook.com', 'yahoo.com'
		];
		
		// JSP 변수에서 현재 이메일 도메인을 추출 (JS 변수에 저장)
		// C:set을 이용해 JSTL 변수를 생성하지 않았으므로, loginMember.email에서 직접 추출합니다.
		const currentEmail = "${loginMember.email}";
		let currentDomain = '';
		const atIndexInCurrent = currentEmail.indexOf('@');
		if (atIndexInCurrent !== -1) {
			currentDomain = currentEmail.substring(atIndexInCurrent + 1);
			
			// 현재 도메인이 기본 목록에 없으면 맨 앞에 추가하여 우선 제안합니다.
			if (currentDomain !== '' && !DOMAINS.includes(currentDomain)) {
				DOMAINS.unshift(currentDomain);
			}
		}

		/**
		 * 입력된 이메일 아이디를 바탕으로 자동 완성 제안 목록을 업데이트합니다.
		 */
		function updateSuggestions() {
			const fullEmailInput = document.getElementById('memberFullEmailInput');
			const datalist = document.getElementById('emailDomainSuggestions');
			const inputValue = fullEmailInput.value.trim();

			// @ 기호 이전의 아이디 부분 추출
			let idPart = inputValue;
			const atIndex = inputValue.indexOf('@');
			
			// @가 있으면 @ 앞부분만 사용 (예: admin@daum.net을 입력 중이면 'admin'만 사용)
			if (atIndex !== -1) {
				idPart = inputValue.substring(0, atIndex);
			}

			// datalist 초기화
			datalist.innerHTML = '';

			// 아이디 부분이 없거나, @ 이후에 이미 도메인이 길게 입력되었으면 제안하지 않습니다.
			if (idPart === '' || (atIndex !== -1 && inputValue.substring(atIndex + 1).length > 0 && !inputValue.includes('.'))) return;


			// 미리 정의된 도메인 목록을 사용하여 새로운 option 태그 생성
			DOMAINS.forEach(domain => {
				// 현재 입력된 값에 @가 포함되어 있으면, 입력된 도메인 부분으로 시작하는 도메인만 제안
				if (atIndex !== -1) {
					const domainPart = inputValue.substring(atIndex + 1);
					// 현재 입력된 도메인 부분으로 시작하는 도메인만 제안
					if (!domain.startsWith(domainPart)) return;
				}
				
				const option = document.createElement('option');
				// '아이디@도메인' 형식으로 제안
				option.value = idPart + '@' + domain;
				datalist.appendChild(option);
			});
		}
        
        // 🟢 [재추가] 페이지 로드 시 초기 제안 목록 생성 및 이벤트 등록
        document.addEventListener('DOMContentLoaded', function() {
			updateSuggestions();
        });


        // 이미지 업로드 및 미리보기 처리 함수 (기존 유지)
        function handleImageUpload(event) {
            const file = event.target.files[0];
            const preview = document.getElementById('profileImagePreview');
            const icon = document.getElementById('profileIcon');
            // ... (기존 로직 유지)
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    icon.style.display = 'none';
                };
                reader.readAsDataURL(file);
            } else {
                preview.src = '';
                preview.style.display = 'none';
                icon.style.display = 'block';
            }
        }

        // ==========================================================
        // 🟢 [유지] 폼 유효성 검사 (validateForm)
        // ==========================================================
        function validateForm() {
            clearErrors();    
            let isValid = true;
            
            // DOM 요소 캐싱
            const nickname = document.getElementById('memberNickname');
            const birth = document.getElementById('memberBirth');
            const phone = document.getElementById('memberPhone');
            const genderSelected = document.querySelector('input[name="gender"]:checked');
            
            // 이메일 관련 DOM 요소 (단일 필드)
            const fullEmailInput = document.getElementById('memberFullEmailInput');
			let fullEmail = fullEmailInput ? fullEmailInput.value.trim() : '';

            // ----------------------------------------------------
            // 0. 닉네임 검사
            // ----------------------------------------------------
            if (!nickname || nickname.value.trim() === "") {
                displayError('nickname', "닉네임을 입력해주세요.");
                if (nickname) nickname.focus(); 
                isValid = false;
            }
            
            // ----------------------------------------------------
            // 1. 이메일 검사 (단일 필드)
            // ----------------------------------------------------
            if (isValid && fullEmail === "") {
                displayError('email', "이메일 주소를 입력해주세요.");
                fullEmailInput.focus();
                isValid = false;
            } else if (isValid) {
                // 최종 형식 검사
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailPattern.test(fullEmail)) {
                    displayError('email', "유효한 이메일 형식(예: user@example.com)이 아닙니다.");
                    fullEmailInput.focus();
                    isValid = false;
                }
            }
            
            // ----------------------------------------------------
            // 2. 성별 선택 검사
            // ----------------------------------------------------
            if (isValid && (!genderSelected || (genderSelected.value !== 'M' && genderSelected.value !== 'F'))) {
                displayError('gender', "성별을 선택해주세요.");
                isValid = false;
            }
            
            // ----------------------------------------------------
            // 3. 생년월일 검사
            // ----------------------------------------------------
            if (isValid && birth.value.trim() === "") {
                displayError('birth', "생년월일을 입력해주세요.");
                birth.focus();
                isValid = false;
            }
            
            // ----------------------------------------------------
            // 4. 전화번호 검사 및 형식 검사
            // ----------------------------------------------------
            if (isValid && phone.value.trim() === "") {
                displayError('phone', "전화번호는 필수 입력 항목입니다.");
                phone.focus();
                isValid = false;
            } else if (isValid) {
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