<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 | 문의 내역</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
/* ========================================================== */
/* 1. 전역 스타일 및 NAV BAR 스타일 (기존 유지) */
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
	border-bottom: none; /* 기존 밑줄 제거 */
	border-radius: 4px; /* 버튼 모서리 둥글게 */
	margin: 0 7px; /* 버튼 간 간격 조정 */
}

.header-nav li:hover {
	color: white;
	background-color: #cd0000;
}

/* 🚨 A 태그 스타일 (링크 스타일 초기화 및 영역 확장) */
.header-nav li a {
	text-decoration: none; /* 링크 밑줄 제거 */
	color: inherit; /* 부모 li의 색상을 상속받음 */
	display: flex; /* 아이콘과 텍스트 중앙 정렬 */
	align-items: center;
}

/* 🚨 문의 내역 메뉴를 활성화합니다. */
.header-nav li.active {
	color: white;
	background-color: #cd0000; /* 진한 빨간색 적용 */
	border-bottom: none; /* 밑줄 제거 */
	font-weight: bold;
}

/* 🚨 활성화된 메뉴 Hover 효과: 더 진한 빨간색 */
.header-nav li.active:hover {
	background-color: #a00000; /* cd0000보다 더 진한 색상 */
	color: white;
}

.header-nav li i {
	margin-right: 5px;
}

/* ========================================================== */
/* 2. 메인 컨텐츠 스타일 (기존 유지) */
/* ========================================================== */
.container {
	padding: 40px 20px;
	width: 100%;
	max-width: 800px;
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
	margin-bottom: 5px; /* 30px에서 줄임 */
	font-size: 28px; /* 글자 크기 키움 */
	color: #333;
}

.content-box p.count { /* 새로운 스타일 추가 */
	text-align: center;
	margin-bottom: 30px; /* 제목과 컨텐츠 박스 사이 여백 */
	color: #777;
	font-size: 16px;
}

/* 폼 화면 전용 제목/설명 스타일 */
#inquiry-form-area h1 {
	text-align: left;
}

#inquiry-form-area .form-description {
	text-align: left;
	margin-bottom: 40px;
	color: #555;
	font-size: 16px;
}

/* 폼 디자인 */
.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	font-weight: bold;
	margin-bottom: 8px;
	color: #333;
}

.form-input {
	width: 100%;
	padding: 12px 15px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	font-size: 14px;
	color: #333;
}

.textarea-input {
	resize: vertical;
	min-height: 150px;
}

.help-text {
	font-size: 12px;
	color: #888;
	margin-top: 5px;
	margin-left: 2px;
}

/* 안내 사항 박스 */
.info-box {
	background-color: #ffe6e6; /* 연한 핑크색 배경 */
	border-radius: 4px;
	padding: 20px;
	margin-top: 30px;
	margin-bottom: 30px;
}

.info-box h4 {
	color: #cd0000;
	margin-top: 0;
	font-size: 16px;
	margin-bottom: 10px;
}

.info-box ul {
	list-style-type: disc;
	padding-left: 20px;
	margin: 0;
	color: #cd0000;
}

.info-box li {
	font-size: 13px;
	margin-bottom: 5px;
	color: #cd0000;
}

.info-box li::marker {
	color: #cd0000;
}

/* 폼 액션 버튼 */
.form-action-buttons {
	display: flex;
	justify-content: center;
	gap: 15px;
	margin-top: 40px;
}

.form-button {
	padding: 12px 30px;
	border: none;
	border-radius: 4px;
	font-size: 16px;
	cursor: pointer;
	font-weight: bold;
	transition: background-color 0.2s;
}

.btn-cancel {
	background-color: #ddd;
	color: #555;
}

.btn-cancel:hover {
	background-color: #ccc;
}

.btn-submit {
	background-color: #cd0000;
	color: white;
}

.btn-submit:hover {
	background-color: #a00000;
}

/* FAQ 링크 영역 */
.faq-link-area {
	text-align: center;
	margin-top: 40px;
	border-top: 1px solid #eee;
	padding-top: 20px;
}

.faq-link-area p {
	color: #555;
	margin-bottom: 10px;
}

.faq-link-area a {
	color: #cd0000;
	text-decoration: none;
	font-weight: bold;
	font-size: 15px;
}

.faq-link-area a:hover {
	text-decoration: underline;
}

/* ========================================================== */
/* 3. 문의 내역 리스트 전용 스타일 */
/* ========================================================== */

/* 리스트 헤더 (컬럼명) */
.inquiry-header {
	display: flex;
	padding: 15px 10px;
	border-top: 2px solid #333; /* 상단 두꺼운 선 */
	border-bottom: 1px solid #ddd;
	font-weight: bold;
	color: #333;
	font-size: 14px;
	background-color: #f9f9f9;
}

/* 개별 문의 항목 */
.inquiry-item {
	display: flex;
	align-items: center;
	padding: 15px 10px;
	border-bottom: 1px solid #eee;
	font-size: 14px;
	color: #555;
	cursor: pointer;
}

/* 컬럼 너비 설정 */
.col-type {
	width: 15%;
	text-align: center;
}

.col-title {
	width: 55%;
}

.col-date {
	width: 15%;
	text-align: center;
}

.col-status {
	width: 15%;
	text-align: center;
	font-weight: bold;
}

/* 상태별 색상 */
.status-completed {
	color: #4CAF50;
} /* 답변 완료 (녹색) */
.status-pending {
	color: #ff4d4d;
} /* 답변 대기 (빨간색) */

/* 하단 액션 버튼 영역 */
.action-bar {
	text-align: center;
	margin-top: 30px;
}

.inquiry-button {
	background-color: #cd0000; /* 네비게이션과 동일한 진한 빨간색 */
	color: white;
	border: none;
	width: 100%; /* 너비를 100%로 확장 */
	padding: 18px 20px;
	/* 버튼 높이를 키움 */
	border-radius: 4px;
	font-size: 18px; /* 글자 크기 키움 */
	font-weight: bold;
	cursor: pointer;
	transition: background-color 0.2s;
	color: white;
	border: none;
	width: 100%; /* 너비를 100%로 확장 */
	padding: 18px 20px; /* 버튼 높이를 키움 */
	border-radius: 4px;
	font-size: 18px; /* 글자 크기 키움 */
	font-weight: bold;
	cursor: pointer;
	border: none;
	width: 100%; /* 너비를 100%로 확장 */
	padding: 18px 20px;
	/* 버튼 높이를 키움 */
	border-radius: 4px;
	font-size: 18px; /* 글자 크기 키움 */
	font-weight: bold;
	cursor: pointer;
	width: 100%; /* 너비를 100%로 확장 */
	padding: 18px 20px;
	/* 버튼 높이를 키움 */
	border-radius: 4px;
	font-size: 18px; /* 글자 크기 키움 */
	font-weight: bold;
	cursor: pointer;
}

.inquiry-button:hover {
	background-color: #a00000;
}

/* 문의 내역이 없을 때 메시지 */
.no-inquiries {
	/* 기존의 테두리/배경색 대신, 이미지처럼 컨텐츠 박스 내부에 깔끔하게 보이도록 조정 */
	text-align: center;
	padding: 60px 0 100px 0; /* 위아래 여백을 늘려 영역 확보 */
	color: #999;
	font-size: 16px;
	/* 이미지에 보이는 채팅 아이콘 스타일 (Font Awesome 기준) */
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}
/* 이미지에 보이는 아이콘을 위한 임시 스타일 (HTML에 <i class="fa-regular fa-comment-dots"></i> 필요) */
.no-inquiries i {
	font-size: 3em;
	color: #ddd; /* 아이콘 색상을 연한 회색으로 */
	margin-bottom: 15px;
}

/* 🚨 오류 메시지 스타일 추가 */
.error-message {
	color: #ff4d4d; /* 빨간색 */
	font-size: 13px;
	margin-top: 5px;
	margin-left: 2px;
	font-weight: bold;
	display: none; /* 기본적으로 숨김 */
}
</style>
</head>
<body>

	<div class="header-nav"></div>

	<div class="container">
		<div class="content-box">
			<h1>문의 내역</h1>
			<p class="count" id="page-count">총 ${ fn:length(qnaList) }건의 문의</p>

			<div id="inquiry-list-area">
				<div class="inquiry-list">
					<c:choose>
						<c:when test="${not empty qnaList}">
							<div class="inquiry-header">
								<div class="col-type">상태</div>
								<div class="col-title">제목</div>
								<div class="col-date">작성일</div>
								<div class="col-status">유형</div>
							</div>
							<c:forEach var="inquiry" items="${qnaList}">
								<div class="inquiry-item">
									<div class="col-type">
										<span
											class="status-<c:out value='${inquiry.status eq "완료" ? "completed" : "pending"}'/>">
											<c:out value="${inquiry.status}" />
										</span>
									</div>
									<div class="col-title">${inquiry.title}</div>
									<div class="col-date">
										<fmt:formatDate value="${inquiry.createdAt}"
											pattern="yyyy.MM.dd" />
									</div>
									<div class="col-status">기타</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="no-inquiries">
								<i class="fa-regular fa-comment-dots"></i>
								<p>문의 내역이 없습니다</p>
							</div>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="action-bar">
					<button class="inquiry-button" id="show-form-button">1:1
						문의하기</button>
				</div>
			</div>

			<div id="inquiry-form-area" style="display: none;">
				<p class="form-description">궁금한 사항을 남겨주시면 빠르게 답변 드리겠습니다</p>

				<form id="inquiry-form" action="/movielist/mypage/inquiries"
					method="POST">
					                                                             <input
						type="hidden" name="userId" value="${sessionScope.userId}" />

					<div class="form-group">
						<label for="type">문의 유형 *</label>                                 
						                <select id="type" name="type"
							class="form-input select-input">
							<option value="" disabled selected>문의 유형을 선택하세요</option>
							<option value="reservation">예매/결제</option>
							<option value="member">회원정보</option>
							<option value="movie">영화정보</option>
							<option value="tech">기술지원</option>
							<option value="etc">기타</option>
						</select>
						<p id="type-error" class="error-message"></p>
					</div>

					<div class="form-group">
						<label for="title">제목 *</label>                                   
						              <input type="text" id="title" name="title"
							class="form-input" placeholder="문의 제목을 입력하세요">
						<p id="title-error" class="error-message"></p>
					</div>

					<div class="form-group">
						<label for="email">이메일 주소 *</label>                               
						                  <input type="email" id="email" name="email"
							class="form-input" placeholder="답변 받으실 이메일 주소">
						<p class="help-text">답변은 입력하신 이메일로 발송됩니다</p>
						<p id="email-error" class="error-message"></p>
					</div>

					<div class="form-group">
						<label for="content">문의 내용 *</label>                              
						                 
						<textarea id="content" name="content"
							class="form-input textarea-input"
							placeholder="문의 내용을 10자 이상 입력해주세요"></textarea>
						<p class="help-text min-length">최소 10자 이상 입력해주세요</p>
						<p id="content-error" class="error-message"></p>
					</div>

					<div class="info-box">
						<h4>안내 사항</h4>
						<ul>
							<li>평일 기준 24시간 이내 답변 드립니다</li>
							<li>주말/공휴일 문의는 다음 영업일에 순차적으로 답변 드립니다</li>
							<li>긴급한 사항은 고객센터(1588-0000)로 연락해주세요</li>
						</ul>
					</div>

					<div class="form-action-buttons">
						<button type="button" class="form-button btn-cancel"
							id="hide-form-button">취소</button>
						<button type="submit" class="form-button btn-submit"
							id="submit-button">문의하기</button>
					</div>
				</form>

				<div class="faq-link-area">
					<p>자주 묻는 질문을 확인해보셨나요?</p>
					<a href="#">FAQ 바로가기 <i class="fa-solid fa-arrow-right"></i></a>
				</div>
			</div>

		</div>
	</div>

	<script>
document.addEventListener('DOMContentLoaded', function() {
    // ---------------------- 요소 연결 ----------------------
    const listArea = document.getElementById('inquiry-list-area'); 
    const formArea = document.getElementById('inquiry-form-area'); 
    const showFormButton = document.getElementById('show-form-button'); 
    const hideFormButton = document.getElementById('hide-form-button'); 
    const inquiryForm = document.getElementById('inquiry-form');
    
    // 폼 요소
    const inquiryType = document.getElementById('type'); 
    const inquiryTitle = document.getElementById('title');
    const inquiryEmail = document.getElementById('email');
    const inquiryContent = document.getElementById('content');
    
    // 오류 메시지 요소
    const typeError = document.getElementById('type-error');
    const titleError = document.getElementById('title-error');
    const emailError = document.getElementById('email-error');
    const contentError = document.getElementById('content-error');
    
    // 페이지 상태 표시 요소
    const pageTitle = document.querySelector('.content-box h1');
    const pageCount = document.querySelector('.content-box p.count');
    const formDescription = document.querySelector('#inquiry-form-area .form-description');

    // ---------------------- 유틸리티 함수 ----------------------

    /** 모든 오류 메시지를 숨김 */
    function clearErrors() {
        [typeError, titleError, emailError, contentError].forEach(el => {
            if (el) { el.textContent = ''; el.style.display = 'none'; }
        });
    }

    /** 특정 요소에 오류 메시지를 표시하고 포커스 */
    function displayError(inputElement, errorElement, message) {
        if (errorElement) {
            errorElement.textContent = message;
            errorElement.style.display = 'block';
        }
        if (inputElement) {
            inputElement.focus();
        }
    }

    // ---------------------- ✅ 유효성 검사 함수 ----------------------
    function validateForm() {
        clearErrors(); 

        // 1. 문의 유형 검사
        if (inquiryType && inquiryType.value === "") {
            displayError(inquiryType, typeError, '문의 유형을 선택해주세요.');
            return false;
        }
        
        // 2. 제목 검사
        if (inquiryTitle && inquiryTitle.value.trim() === "") {
            displayError(inquiryTitle, titleError, '제목을 입력해야 합니다.');
            return false;
        }

        // 3. 이메일 검사 (빈 값)
        if (inquiryEmail && inquiryEmail.value.trim() === "") {
            displayError(inquiryEmail, emailError, '답변 받으실 이메일 주소를 입력해야 합니다.');
            return false;
        }
        
        // 4. 이메일 형식 검사
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (inquiryEmail && !emailRegex.test(inquiryEmail.value.trim())) {
             displayError(inquiryEmail, emailError, '올바른 이메일 형식으로 입력해주세요.');
             return false;
        }

        // 5. 문의 내용 검사 (10자 미만)
        if (inquiryContent && inquiryContent.value.trim().length < 10) {
            displayError(inquiryContent, contentError, '문의 내용을 최소 10자 이상 입력해주세요.');
            return false;
        }
        
        return true;
    }
    
    // ---------------------- 이벤트 핸들러 ----------------------

    // '1:1 문의하기' 버튼 클릭 시 (목록 -> 폼)
    showFormButton.addEventListener('click', function() {
        listArea.style.display = 'none';
        formArea.style.display = 'block';
        
        pageTitle.textContent = '1:1 문의';
        pageTitle.style.textAlign = 'left';

        pageCount.style.display = 'none'; 
        formDescription.style.display = 'block'; 
        
        clearErrors();
    });
    
    // '취소' 버튼 클릭 시 (폼 -> 목록)
    hideFormButton.addEventListener('click', function() {
        formArea.style.display = 'none';
        listArea.style.display = 'block';
        
        pageTitle.textContent = '문의 내역';
        pageTitle.style.textAlign = 'center';
        
        pageCount.style.display = 'block'; 
        formDescription.style.display = 'none';
        
        if (inquiryForm) inquiryForm.reset();
        clearErrors();
    });

    // 🚨 폼의 submit 이벤트를 가로챕니다. (AJAX 통신)
    if (inquiryForm) { 
        inquiryForm.addEventListener('submit', function(e) {
            e.preventDefault();  // 🛑 주소 이동 방지

            if (validateForm()) {
                // 💡 [핵심 수정] 전통적인 폼 제출 대신 AJAX로 데이터 전송
                const formData = $(this).serialize(); // 폼 데이터를 직렬화

                $.ajax({
                    // Controller의 @PostMapping("/mypage/inquiries")와 일치
                    url: $(this).attr('action'), 
                    type: 'POST',
                    data: formData,

                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 

                    dataType: 'text',
                    
                    success: function(response) {
    // 성공 메시지 표시 (Controller에서 반환된 "문의가 성공적으로 등록되었습니다." 예상)
    alert(response); 
    inquiryForm.reset();
    
    // 폼 숨기고 목록 보기 상태로 전환
    document.getElementById('inquiry-form-area').style.display = 'none'; 
    document.getElementById('inquiry-list-area').style.display = 'block';
    document.querySelector('.content-box h1').textContent = '문의 내역';
    
    window.location.reload(); 
},
error: function(xhr) {
    // 🚨 [수정] 깨진 문자열 대신 HTTP 상태 코드와 응답 본문을 확인
    // xhr.responseText에 깨지지 않은 에러 메시지가 담겨야 합니다.
    let errorMessage = xhr.responseText || '알 수 없는 오류가 발생했습니다.';
    
    // HTTP 상태 코드 확인 (400 Bad Request, 500 Internal Server Error 등)
    let status = xhr.status; 
    
    alert(`문의 등록 실패 (상태: ${status}): ${errorMessage}`);
}
                });
            }
        });
    }

    // 페이지 로드 시 초기 상태 설정
    formDescription.style.display = 'none';
    clearErrors();
});
</script>

</body>

</html>