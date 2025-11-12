<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 | 영화 요청</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
/* (스타일 시트 코드는 변경 없음, 생략) */
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
    margin-bottom: 40px; 
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
/* 2. 메인 컨텐츠 스타일 (공통) */
/* ========================================================== */

.container {
    padding: 0 20px;
    width: 100%;
    max-width: 800px;
    margin: 0 auto 40px auto; 
}

.page-header {
    margin-bottom: 40px;
}

.page-header h1 {
    text-align: center;
    margin: 0;
    font-size: 28px;
    color: #333;
}

.content-box {
    background-color: #ffffff;
    padding: 40px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); 
}

/* ========================================================== */
/* 2-1. 요청 목록 스타일 */
/* ========================================================== */

.list-view-content {
    text-align: center;
}

.request-count {
    font-size: 16px;
    color: #777;
    margin-bottom: 30px;
    display: block;
}

.empty-state {
    padding: 50px 0;
    border: 1px dashed #ddd;
    border-radius: 4px;
    margin-bottom: 40px;
    background-color: #fafafa;
}

.empty-state i {
    font-size: 60px;
    color: #ccc;
    margin-bottom: 20px;
}

.empty-state p {
    font-size: 16px;
    color: #888;
    margin: 0;
}

/* 영화 등록 요청하기 버튼 */
.btn-request-movie {
    width: 100%;
    background-color: #cd0000;
    color: white;
    border: none;
    padding: 15px;
    border-radius: 4px;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.2s;
    margin-top: 20px; 
}

.btn-request-movie:hover {
    background-color: #a00000;
}

/* ========================================================== */
/* 2-2. 요청 작성 폼 스타일 */
/* ========================================================== */

/* 3. 영화 요청 폼 전용 스타일 */
.form-group { margin-bottom: 20px; }
.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #333;
    font-size: 15px;
}
.form-input {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 15px;
    box-sizing: border-box;
    height: 48px;
    transition: border-color 0.2s;
    background-color: #f0f0f0;
    border: none;
}
.form-input:focus {
    outline: none;
    background-color: #fff;
    border: 1px solid #aaa;
}
textarea.form-input {
    resize: vertical;
    min-height: 120px;
    height: auto;
    padding: 15px 12px;
}
.form-row { display: flex; gap: 20px; }
.form-row .form-group { flex: 1; min-width: 0; }
.select-wrapper { position: relative; }

/* 🚨 JavaScript로 색상 제어를 위해 CSS에서 :valid 관련 코드를 제거하거나 초기 상태를 명확히 함 */
input[type="date"].form-input {
    -webkit-appearance: initial;  
    appearance: initial;          
    -moz-appearance: initial;     
    color: #999; /* 기본적으로 회색으로 설정 */
    text-align: left;
    padding-right: 12px; 
}
select.form-input {
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    cursor: pointer;
    color: #999; /* 기본적으로 회색으로 설정 */
}

/* 실제 옵션 텍스트는 검은색으로 유지 */
select.form-input option { color: #000; }

/* 🚨 :valid 선택자를 사용하지 않고 JS로 제어합니다. */
/* 아래 코드를 제거하거나 주석 처리하여 JS가 색상을 제어하도록 합니다. */
/* select.form-input:valid,
input[type="date"].form-input:valid { 
    color: #000;
} */


.select-wrapper .fa-caret-down {
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    pointer-events: none; 
    color: #555;
    font-size: 1.1em; 
}
.form-group.request-reason textarea.form-input {
    background-color: #f0f0f0;
    border: none;
}
.form-actions {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-top: 30px;
}
.form-actions button {
    padding: 15px 30px;
    border-radius: 4px;
    font-size: 17px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.2s;
    width: 150px;
}
.btn-cancel {
    background-color: #ffffff;
    color: #cd0000;
    border: 1px solid #cd0000;
}
.btn-cancel:hover { background-color: #f7e0e0; }
.btn-submit {
    background-color: #cd0000;
    color: white;
    border: none;
}
.btn-submit:hover { background-color: #a00000; }
/* 4. 안내 사항 및 등록 기준 영역 스타일 */
.info-box-group {
    margin-top: 30px;
    margin-bottom: 30px;
}
.guide-box {
    background-color: #fcebeb;
    color: #cd0000;
    padding: 20px;
    border-radius: 4px;
    font-size: 14px;
    margin-bottom: 20px;
    line-height: 1.6;
}
.guide-box strong { font-weight: bold; }
.criteria-box {
    display: flex;
    gap: 15px;
    font-size: 14px;
    text-align: center;
}
.criteria-item {
    flex: 1;
    padding: 20px 15px;
    border-radius: 4px;
    line-height: 1.6;
}
.criteria-item.ok {
    background-color: #e5f7e5;
    border: 1px solid #4CAF50;
    color: #2e7d32;
}
.criteria-item.no {
    background-color: #fcebeb;
    border: 1px solid #cd0000;
    color: #cd0000;
}
.criteria-item h3 {
    font-size: 16px;
    font-weight: bold;
    margin-top: 0;
    margin-bottom: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}
.criteria-item ul {
    list-style: none;
    padding: 0;
    margin: 0;
    text-align: left;
}
.criteria-item ul li { margin-bottom: 5px; }
.criteria-item .ok-icon { color: #4CAF50; }
.criteria-item .no-icon { color: #cd0000; }
/* 🚨 커스텀 에러 메시지 스타일 */
.error-message {
    color: #cd0000;
    font-size: 13px;
    margin-top: 5px;
    display: none;
}
.error-message.show {
    display: block !important; 
}
    </style>
</head>

<body>
    
    <div class="header-nav">
        <ul>
            <li><a href="/movielist/mypage/reservations"><i class="fa-solid fa-calendar-check"></i> 예매 내역</a></li>
            <li><a href="/movielist/mypage/favorites"><i class="fa-regular fa-heart"></i> 관심 목록</a></li>
            <li><a href="/movielist/mypage/profile"><i class="fa-regular fa-user"></i> 회원 정보</a></li>
            <li><a href="/movielist/mypage/theaters"><i class="fa-solid fa-map-pin"></i> 선호 영화관</a></li>
            <li><a href="/movielist/mypage/paymentmethod"><i class="fa-solid fa-credit-card"></i> 결제 수단</a></li>
            <li><a href="/movielist/mypage/inquiries"><i class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
            <li class="active"><a href="/movielist/mypage/movierequest"><i class="fa-solid fa-film"></i> 영화 요청</a></li>
        </ul>
    </div>

    <div class="container">
        <div class="page-header">
            <h1 id="page-main-title">영화 등록 요청 내역</h1>
        </div>
        
        <div class="content-box">
            
            <div id="request-list-view" class="list-view-content">
                
                <span class="request-count">총 0건의 요청</span>
                
                <div class="empty-state">
                    <i class="fa-solid fa-video"></i> 
                    <p>문의 내역이 없습니다</p>
                </div>
                
                <button type="button" class="btn-request-movie" id="btn-show-write-form">
                    영화 등록 요청하기
                </button>
            </div>


            <div id="request-write-view" style="display: none;">
                
                <form action="" method="POST" id="movie-request-form"> 
                    
                    <div class="form-group">
                        <label for="movie-title">영화 제목 *</label>
                        <input type="text" id="movie-title" name="movieTitle" class="form-input" 
                                placeholder="영화 제목을 입력해주세요"> 
                        <span class="error-message" data-for="movie-title"></span> 
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="genre">장르 *</label>
                            <div class="select-wrapper">
                                <select id="genre" name="genre" class="form-input"> 
                                    <option value="" selected disabled>장르 선택</option>
                                    <option value="action">액션</option>
                                    <option value="comedy">코미디</option>
                                    <option value="drama">드라마</option>
                                    <option value="thriller">스릴러</option>
                                    <option value="fantasy">판타지</option>
                                </select>
                                <i class="fa-solid fa-caret-down"></i>
                            </div>
                            <span class="error-message" data-for="genre"></span> 
                        </div>
                        
                        <div class="form-group">
                            <label for="release-date-input">개봉 연도 *</label>
                            <div class="select-wrapper">
                                <input type="date" id="release-date-input" name="releaseDate" class="form-input" 
                                        title="날짜를 선택하세요">
                            </div>
                            <span class="error-message" data-for="release-date-input"></span> 
                        </div>
                    </div>
                    
                    <div class="form-group request-reason">
                        <label for="request-reason">요청 사유 *</label>
                        <textarea id="request-reason" name="requestReason" class="form-input" 
                                     placeholder="이 영화를 등록 요청하시는 사유를 작성해주세요"></textarea> 
                        <span class="error-message" data-for="request-reason"></span> 
                    </div>
                    
                    <div class="info-box-group">
                        <div class="guide-box">
                            <p><strong>안내 사항</strong></p>
                            <ul>
                                <li>요청하신 영화는 검토 후 등록 여부를 알려드립니다.</li>
                                <li>이미 등록된 영화는 중복 등록되지 않습니다.</li>
                                <li>등록 여부 검토 결과는 마이페이지에서 확인 가능합니다.</li>
                            </ul>
                        </div>

                        <div class="criteria-box">
                            <div class="criteria-item ok">
                                <h3><i class="fa-solid fa-circle-check ok-icon"></i> 등록 가능</h3>
                                <ul>
                                    <li>정식 개봉된 극장판 영화</li>
                                    <li>OTT 오리지널 영화</li>
                                </ul>
                            </div>
                            <div class="criteria-item no">
                                <h3><i class="fa-solid fa-circle-xmark no-icon"></i> 등록 불가</h3>
                                <ul>
                                    <li>비공식 독립 영화</li>
                                    <li>개인 제작 콘텐츠</li>
                                    <li>성인 콘텐츠</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn-cancel" id="btn-cancel-write">
                            취소
                        </button>
                        <button type="submit" class="btn-submit">
                            요청하기
                        </button>
                    </div>
                </form>

            </div>
        </div>
    </div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // ---------------------- 뷰 관리 요소 ----------------------
    const listView = document.getElementById('request-list-view');
    const writeView = document.getElementById('request-write-view');
    const btnShowWriteForm = document.getElementById('btn-show-write-form');
    const btnCancelWrite = document.getElementById('btn-cancel-write');
    const pageTitle = document.getElementById('page-main-title');

    // ---------------------- 폼 요소 및 에러 메시지 연결 ----------------------
    const form = document.getElementById('movie-request-form');
    const movieTitleInput = document.getElementById('movie-title');
    const genreSelect = document.getElementById('genre');
    const releaseDateInput = document.getElementById('release-date-input');
    const requestReasonTextarea = document.getElementById('request-reason');
    
    const movieTitleError = document.querySelector('.error-message[data-for="movie-title"]');
    const genreError = document.querySelector('.error-message[data-for="genre"]');
    const releaseDateError = document.querySelector('.error-message[data-for="release-date-input"]');
    const requestReasonError = document.querySelector('.error-message[data-for="request-reason"]');

    const allErrorSpans = [ movieTitleError, genreError, releaseDateError, requestReasonError ];
    
    // ---------------------- 유틸리티 함수 ----------------------

    function clearErrors() {
        allErrorSpans.forEach(el => {
            if (el) {  
                el.style.display = 'none';
                el.textContent = '';
                el.classList.remove('show');
            }
        });
    }

    function displayError(inputElement, errorElement, message) {
        if (errorElement) {
            errorElement.textContent = message;
            errorElement.classList.add('show');
            errorElement.style.display = 'block'; 
        }
        if (inputElement) {
            inputElement.focus();
        }
    }
    
    // ---------------------- 뷰 전환 함수 ----------------------

    function showListView() {
        if (listView) {
            listView.style.display = 'block';
            pageTitle.textContent = '영화 등록 요청 내역';
        }
        if (writeView) {
            writeView.style.display = 'none';
        }
        const form = document.getElementById('movie-request-form');
        if (form) form.reset();
        clearErrors(); 
        updateFieldColor(genreSelect); // 목록 전환 시 필드 색상 초기화
        updateFieldColor(releaseDateInput); // 목록 전환 시 필드 색상 초기화
    }

    function showWriteView() {
        if (listView) {
            listView.style.display = 'none';
        }
        if (writeView) {
            writeView.style.display = 'block';
            pageTitle.textContent = '영화 등록 요청';
        }
        // 작성 폼 표시 시 초기 색상 설정
        updateFieldColor(genreSelect); 
        updateFieldColor(releaseDateInput);
    }

    // ---------------------- 🚨 색상 제어 로직 (JS 추가) ----------------------
    /**
     * 필드 값에 따라 텍스트 색상을 업데이트합니다.
     * 값이 있으면 검은색(#000), 없으면 회색(#999)으로 설정합니다.
     */
    function updateFieldColor(element) {
        if (!element) return;
        
        // select 또는 date input의 현재 값을 확인
        const value = element.value; 
        
        if (value === "" || value === element.getAttribute('title')) {
            // 값이 없거나, placehoder와 동일할 경우 회색으로 설정
            element.style.color = '#999';
        } else {
            // 값이 선택된 경우 검은색으로 설정
            element.style.color = '#000';
        }
    }

    // ---------------------- 뷰 전환 이벤트 연결 ----------------------
    
    if (btnShowWriteForm) {
        btnShowWriteForm.addEventListener('click', showWriteView);
    }
    
    if (btnCancelWrite) {
        btnCancelWrite.addEventListener('click', showListView);
    }
    
    showListView(); 


    // ---------------------- 유효성 검사 함수 ----------------------
    function validateForm(event) {
        event.preventDefault(); 
        
        clearErrors();
        
        // 1. 영화 제목 검사
        if (movieTitleInput && movieTitleInput.value.trim() === "") {
            displayError(movieTitleInput, movieTitleError, '영화 제목을 작성해주세요.');
            return false;
        }

        // 2. 장르 검사
        if (genreSelect && genreSelect.value === "") {
            displayError(genreSelect, genreError, '장르를 선택해주세요.');
            return false;
        }

        // 3. 개봉 연도 검사
        if (releaseDateInput && releaseDateInput.value.trim() === "") {
            displayError(releaseDateInput, releaseDateError, '개봉 연도를 선택해주세요.');
            return false;
        }
        
        // 4. 요청 사유 검사
        if (requestReasonTextarea && requestReasonTextarea.value.trim() === "") {
            displayError(requestReasonTextarea, requestReasonError, '요청 사유를 작성해주세요.');
            return false;
        }
        
        // --- 유효성 검사 모두 통과 시 ---
        
        alert('영화 요청이 성공적으로 접수되었습니다! (서버 전송 시뮬레이션)');
        
        showListView();
        
        return true; 
    }
    
    // ---------------------- 폼 이벤트 및 색상 제어 핸들러 연결 ----------------------
    if (form) {
        form.addEventListener('submit', validateForm);
    }

    const colorControlledFields = [genreSelect, releaseDateInput];

    colorControlledFields.forEach(input => {
        if (input) {
            // 값이 변경되거나(change) 입력이 일어날 때(input) 색상 업데이트
            input.addEventListener('change', () => updateFieldColor(input));
            input.addEventListener('input', () => updateFieldColor(input));
            
            // 페이지 로드 후 초기 색상 설정
            updateFieldColor(input);
        }
    });

    // 입력 시 에러 메시지 숨김 처리 (기존 유지)
    const allFields = [
        { input: movieTitleInput, error: movieTitleError },
        { input: genreSelect, error: genreError },
        { input: releaseDateInput, error: releaseDateError },
        { input: requestReasonTextarea, error: requestReasonError }
    ];

    allFields.forEach(({ input, error }) => {
        if (input && error) {
            const hideError = () => {
                if (input.value.trim() !== "" && input.value !== "") {
                    if (error) {
                         error.style.display = 'none';
                         error.textContent = '';
                         error.classList.remove('show');
                    }
                }
            };

            input.addEventListener('input', hideError);
            input.addEventListener('change', hideError);
            input.addEventListener('focus', hideError);
        }
    });

    clearErrors();
});
</script>
</body>
</html>