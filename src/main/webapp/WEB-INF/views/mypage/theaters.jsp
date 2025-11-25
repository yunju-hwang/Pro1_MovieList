<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 | 선호 영화관</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f7f7f7;
	min-height: 100vh;
}

/* --- Header & Navigation Styles --- */
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

/* --- Main Content Layout Styles --- */
.container {
	padding: 40px 20px;
	width: 100%;
	max-width: 600px;
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

/* --- Search Input & Results Styles --- */
.cinema-search-group {
	display: flex;
	align-items: flex-start;
	gap: 10px;
	margin-bottom: 10px;
}

.search-input-wrapper {
	flex-grow: 1;
	position: relative;
}

.btn-search-icon {
	position: absolute;
	left: 1px;
	top: 1px;
	height: calc(100% - 2px);
	background-color: transparent;
	color: #888;
	border: none;
	padding: 0 15px;
	border-radius: 4px 0 0 4px;
	cursor: pointer;
	font-size: 15px;
	transition: color 0.2s;
	display: flex;
	align-items: center;
	justify-content: center;
	line-height: 1;
	z-index: 10;
}

.btn-search-icon:hover {
	color: #555;
}

.cinema-search-group input[type="text"] {
	width: 100%;
	padding: 12px;
	padding-left: 50px;
	padding-right: 12px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 15px;
	box-sizing: border-box;
	margin-bottom: 0;
}

.cinema-search-group button.btn-add {
	background-color: #cd0000;
	color: white;
	border: none;
	padding: 12px 15px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 15px;
	transition: background-color 0.2s;
	flex-shrink: 0;
	line-height: 1;
	margin-top: 1px;
}

.cinema-search-group button.btn-add:hover {
	background-color: #a00000;
}

.search-results {
	position: absolute;
	top: 100%;
	left: 0;
	right: 0;
	z-index: 50;
	background-color: white;
	border: 1px solid #ddd;
	border-top: none;
	border-radius: 0 0 4px 4px;
	max-height: 200px;
	overflow-y: auto;
	list-style: none;
	padding: 0;
	margin: 0;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	display: none;
}

.search-results li {
	padding: 10px 15px;
	cursor: pointer;
	border-bottom: 1px solid #eee;
	font-size: 15px;
}

.search-results li:hover {
	background-color: #f0f0f0;
}

.search-results li:last-child {
	border-bottom: none;
}

/* --- Selected Cinemas List Styles --- */
.selected-cinemas {
	list-style: none;
	padding: 0;
	border: 1px solid #eee;
	border-radius: 4px;
	max-height: 200px;
	overflow-y: auto;
}

.selected-cinemas li {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 15px;
	border-bottom: 1px solid #eee;
	font-size: 15px;
	color: #333;
}

.selected-cinemas li.empty-state-message {
	justify-content: center;
	color: #888;
	font-style: italic;
	padding: 15px;
}

.selected-cinemas li span {
	color: #333;
}

.selected-cinemas li:last-child {
	border-bottom: none;
}

.selected-cinemas button.remove-btn {
	background: none;
	border: none;
	color: #ff4d4d;
	cursor: pointer;
	font-size: 18px;
	padding: 0;
	line-height: 1;
	transition: color 0.2s;
}

.selected-cinemas button.remove-btn:hover {
	color: #e63939;
}

/* --- Submit Button Styles --- */
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
	margin-top: 20px;
	transition: background-color 0.2s;
}

.submit-button:hover {
	background-color: #a00000;
}

/* --- Modal Styles (정리 및 최적화 완료) --- */

/* 1. 모달 전체 (배경 오버레이) */
.modal {
	display: none; /* 기본적으로 숨기기 */
	position: fixed; /* 뷰포트에 고정 */
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
}

/* 2. 모달 내용 상자 */
.modal-content {
	background-color: #fefefe;
	margin: 5% auto; /* 상하 여백, 중앙 정렬 */
	padding: 30px;
	border: 1px solid #888;
	width: 80%;
	max-width: 500px;
	border-radius: 8px;
	position: relative;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}

/* 3. 닫기 버튼 */
.close-btn {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	line-height: 1;
}

.close-btn:hover, .close-btn:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

/* 4. 모달 제목 */
.modal-content h2 {
	margin-top: 0;
	margin-bottom: 20px;
	color: #333;
	text-align: center;
}

/* 5. 모달 내 목록 컨테이너 */
.modal-cinema-list {
	list-style: none;
	padding: 0;
	max-height: 300px;
	overflow-y: auto;
	border: 1px solid #eee;
	border-radius: 4px;
	margin-bottom: 0;
}

/* 6. 모달 내 목록 항목 */
.modal-cinema-list li {
	padding: 10px;
	border-bottom: 1px solid #eee;
	cursor: pointer;
	transition: background-color 0.2s;
	color: #333;
	font-size: 15px;
}

.modal-cinema-list li:hover {
	background-color: #f0f0f0;
}

.modal-cinema-list li:last-child {
	border-bottom: none;
}

/* 7. 모달 확인 버튼 */
.modal-confirm-btn {
	width: 100%;
	background-color: #5cb85c;
	color: white;
	border: none;
	padding: 12px;
	border-radius: 4px;
	font-size: 16px;
	margin-top: 15px;
	cursor: pointer;
	transition: background-color 0.2s;
}

.modal-confirm-btn:hover {
	background-color: #4cae4c;
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
			<li><a href="/movielist/mypage/profile"><i
					class="fa-regular fa-user"></i> 회원 정보</a></li>
			<li class="active"><a href="/movielist/mypage/theaters"><i
					class="fa-solid fa-map-pin"></i> 선호 영화관</a></li>
			<li><a href="/movielist/mypage/inquiries"><i
					class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
			<li><a href="/movielist/mypage/movierequest"><i
					class="fa-solid fa-film"></i> 영화 요청</a></li>
		</ul>
	</div>

	<div class="container">
		<div class="content-box">

			<h1>선호 영화관 관리</h1>

			<form action="<c:url value="/mypage/theaters/update" />" method="POST" onsubmit="validateForm()">

				<div class="form-group">
					<label for="cinema-search">영화관 검색/추가</label>

					<div class="cinema-search-group">

						<div class="search-input-wrapper">

							<button type="button" class="btn-search-icon">
								<i class="fa-solid fa-magnifying-glass"></i>
							</button>

							<input type="text" id="cinema-search" name="cinemaSearch"
								placeholder="영화관을 검색하면 자동 완성됩니다" autocomplete="off">

							<ul id="search-results" class="search-results">
							</ul>

						</div>

						<button type="button" class="btn-add" id="openModalBtn">
							<i class="fa-solid fa-plus"></i>
						</button>
					</div>
				</div>

				<div class="form-group">
					<label>현재 설정된 선호 영화관</label>
					<ul id="selected-cinemas" class="selected-cinemas">
						<li class="empty-state-message">선호 영화관이 없습니다</li>
						
					</ul>
				</div>

				<button type="submit" class="submit-button">
					<i class="fa-solid fa-cloud-arrow-up"></i> 선호 영화관 저장
				</button>
			</form>

		</div>
	</div>

	<div id="myModal" class="modal">
		<div class="modal-content">
			<span class="close-btn" id="modal-close-btn">&times;</span>
			<h2>전체 상영관 목록</h2>

			<ul class="modal-cinema-list" id="modal-cinema-list">
			</ul>

			<button type="button" class="modal-confirm-btn" id="confirmBtn">확인/닫기</button>
		</div>
	</div>
	<script>
// =========================================================
// 📢 1. 서버 데이터 변수 초기화 (템플릿 엔진 문법에 맞춰 수정 필요)
// =========================================================

// [주의] 이 부분은 템플릿 엔진(JSP, Thymeleaf 등) 문법을 사용해
// Controller에서 Model에 담아 전달한 theaterList 데이터를 JSON.parse()하여
// JavaScript 변수에 할당해야 합니다. 아래는 예시 코드입니다.
// const ALL_THEATERS = /*[[${theaterList}]]*/ [
//     // 서버에서 실제 JSON 데이터가 여기에 삽입됩니다.
//     // { "theaterId": 1, "name": "CGV 강남", "location": "강남구" }, ...
// ]; 

const ALL_THEATERS = JSON.parse('${theaterListJson}');
const SAVED_THEATER_IDS = JSON.parse('${savedTheaterIdsJson}');
// =========================================================
// 2. DOM 요소 및 기본 모달 제어
// =========================================================

const modal = document.getElementById("myModal");
const openBtn = document.getElementById("openModalBtn");
const closeBtn = document.getElementById("modal-close-btn");
const confirmBtn = document.getElementById("confirmBtn");
// 모달 목록 <ul> 요소
const cinemaListElement = document.getElementById("modal-cinema-list");
// 선호 목록 <ul> 요소
const selectedCinemasElement = document.getElementById("selected-cinemas"); 
const theaterUpdateForm = document.getElementById("theaterUpdateForm");




// --- 모달 닫기 함수 (재사용을 위해 함수로 분리) ---
function closeModal() {
    modal.style.display = "none";
}

// --- 모달 열기 ---
if (openBtn) {
    openBtn.onclick = function() {
        modal.style.display = "block";
        // 📢 모달이 열릴 때마다 데이터를 렌더링합니다.
        renderCinemaList(ALL_THEATERS); 
    }
}

// --- 모달 닫기 이벤트 핸들러 (X 버튼, 하단 버튼, 외부 영역) ---
if (closeBtn) {
    closeBtn.onclick = closeModal;
}

if (confirmBtn) {
    confirmBtn.onclick = closeModal;
}

window.onclick = function(event) {
    if (event.target === modal) {
        closeModal();
    }
}

// =========================================================
// 3. 렌더링 및 항목 추가/제거 로직
// =========================================================

// --- 함수: 모달 내 영화관 목록 렌더링 ---
function renderCinemaList(theaters) {
    cinemaListElement.innerHTML = ''; 
    
    

    if (!theaters || theaters.length === 0) {
        cinemaListElement.innerHTML = '<li class="empty-state-message">등록된 영화관이 없습니다.</li>';
        return;
    }

    let html = '';
    theaters.forEach(theater => {
        // data- 속성에 ID, Name, Location을 모두 저장합니다.
//         html += `
//             <li data-id="${cinema.theaterId}" data-name="${cinema.name}" data-location="${cinema.location}">
//                 ${cinema.name} 
//                 <span style="color: #888; font-size: 0.9em;">(${cinema.location})</span>
//             </li>
//         `;
    	    // 템플릿 리터럴 대신, 일반 따옴표를 쓰고 + 연산자로 문자열과 변수를 결합합니다.
    	html += '<li data-id="' + theater.theaterId + '" data-name="' + theater.name + '" data-location="' + theater.location + '">';
        html += '<span>' + theater.name + '</span>';
        html += ' <span style="color: #888; font-size: 0.9em;">(' + theater.location + ')</span>';
        html += '</li>';
    });
    
    cinemaListElement.innerHTML = html;
}

// --- 함수: 선호 영화관 목록에 항목 추가 ---
function addCinemaToSelectedList(id, name, location) {
    
    // 1. 중복 검사: 이미 같은 ID를 가진 항목이 있는지 확인
    const existingItem = selectedCinemasElement.querySelector(`li[data-id="${id}"]`);
    if (existingItem) {
        alert(`[${name}]은(는) 이미 선호 영화관 목록에 추가되어 있습니다.`);
        return;
    }

    // 2. 항목 제거 버튼 HTML (CSS: .remove-btn)
    const removeButtonHtml = 
    '<button type="button" class="remove-btn" data-id="' + id + '">' +
        '&times;' +
    '</button>';
    
    // 3. 목록 항목 HTML 생성
    const newItemHtml = 
    	'<li data-id="' + id + '">' +
        '<span>' + name + ' (' + location + ')</span>' +
        removeButtonHtml + 
        // 📢 이 필드가 Form 제출 시 서버로 ID를 보냅니다.
        // name 속성이 중요합니다. 서버에서 List 형태로 받기 위해 동일하게 지정합니다.
        '<input type="hidden" name="theaterId" value="' + id + '">' +
    '</li>';

    // 4. 비어있던 메시지 제거 (만약 있다면)
    const emptyMessage = selectedCinemasElement.querySelector('.empty-state-message');
    if (emptyMessage) {
        emptyMessage.remove();
    }

    // 5. 선호 목록에 새 항목 추가
    selectedCinemasElement.insertAdjacentHTML('beforeend', newItemHtml);
    
    // 6. 모달 닫기 (선호 항목 추가 후 모달 자동 닫기)
    closeModal();
}

//=========================================================
//📢 [새로 추가] 초기 로딩 시 저장된 목록을 화면에 렌더링하는 함수
//=========================================================
function loadSavedTheaters() {
 
 // 저장된 목록이 없거나 비어 있으면 '없음' 메시지만 표시하고 종료
 if (!SAVED_THEATER_IDS || SAVED_THEATER_IDS.length === 0) {
     // 기존에 혹시 모를 로딩 메시지나 내용을 지우고 설정
     selectedCinemasElement.innerHTML = '<li class="empty-state-message">선호 영화관이 없습니다</li>';
     return;
 }

 // 1. ALL_THEATERS 목록을 Map으로 변환하여 ID로 쉽게 찾을 수 있게 합니다.
 const theaterMap = new Map(
     ALL_THEATERS.map(t => [t.theaterId.toString(), t])
 );
 
 let html = '';
 
 // 2. 저장된 ID 목록을 순회하며 HTML을 생성합니다.
 SAVED_THEATER_IDS.forEach(id => {
     const theaterId = id.toString();
     const theater = theaterMap.get(theaterId);
     
     if (theater) {
          const removeButtonHtml = 
             '<button type="button" class="remove-btn" data-id="' + theaterId + '">' +
                 '&times;' +
             '</button>';
             
          html += 
             '<li data-id="' + theaterId + '">' +
                 '<span>' + theater.name + ' (' + theater.location + ')</span>' +
                 removeButtonHtml + 
                 // 📢 Hidden Input 필드를 초기부터 렌더링해야 저장 시 데이터가 전송됩니다.
                 '<input type="hidden" name="theaterId" value="' + theaterId + '">' +
             '</li>';
     }
 });

 // 3. 선호 목록 영역을 DB 데이터로 완전히 대체합니다.
 selectedCinemasElement.innerHTML = html;
}
//=========================================================

// =========================================================
// 4. 이벤트 리스너: 모달 클릭 시 선호 목록에 추가
// =========================================================

// 모달 목록 <ul> 전체에 이벤트 리스너를 추가 (이벤트 위임)
cinemaListElement.addEventListener('click', function(event) {
    const clickedItem = event.target.closest('li');

    // 유효한 항목인지 확인
    if (!clickedItem || clickedItem.classList.contains('empty-state-message')) {
        return;
    }
    
    const theaterId = clickedItem.dataset.id;
    const theaterName = clickedItem.dataset.name;
    const theaterLocation = clickedItem.dataset.location;

    if (theaterId && theaterName) {
        addCinemaToSelectedList(theaterId, theaterName, theaterLocation);
    }
});

// =========================================================
// 5. 이벤트 리스너: 선호 목록 항목 제거
// =========================================================

// 선호 목록 <ul> 전체에 이벤트 리스너를 추가 (이벤트 위임)
selectedCinemasElement.addEventListener('click', function(event) {
    const removeButton = event.target.closest('.remove-btn');
    
    if (removeButton) {
        // 버튼의 부모인 <li> 항목을 찾아서 제거
        removeButton.closest('li').remove();
        
        // 모든 항목이 제거되었는지 확인 후 '없음' 메시지 표시
        if (selectedCinemasElement.children.length === 0) {
            const emptyStateHtml = '<li class="empty-state-message">선호 영화관이 없습니다</li>';
            selectedCinemasElement.innerHTML = emptyStateHtml;
        }
    }
});

//=========================================================
//6. 📢 [새로 추가] 폼 유효성 검사 함수 (onsubmit에서 호출됨)
//=========================================================

/**
* 폼 제출 시 호출되어 유효성을 검사하는 함수
* @returns {boolean} true면 폼 제출 진행, false면 제출 취소
*/
function validateForm() {
 // Hidden Input 필드를 직접 세지 않고, <li> 항목 개수를 세서 유효성을 검사합니다.
 const selectedItems = selectedCinemasElement.querySelectorAll('li:not(.empty-state-message)');

//  if (selectedItems.length === 0) {
//      alert("저장할 선호 영화관을 1개 이상 선택해 주세요.");
//      return false; // 제출 취소
//  }
 
 // 유효성 검사 통과. 브라우저가 자동으로 <li> 내부의 모든 name="theaterId" 값을 서버로 전송합니다.
 return true; 
}

//=========================================================
//7. 📢 [핵심] 페이지 로딩 완료 후 초기 목록 렌더링
//=========================================================
document.addEventListener('DOMContentLoaded', function() {
 loadSavedTheaters();
});
//=========================================================

</script>
</body>
</html>
