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
	align-items: center;
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
	font-size: 15px;
	transition: color 0.2s;
	display: flex;
	align-items: center;
	justify-content: center;
	line-height: 1;
	z-index: 10;
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
	margin-top: 0;
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

.modal-cinema-list li:hover:not(.selected-disabled) {
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

/* --- 항목 비활성화 상태 스타일 (선택된 영화관) --- */
.selected-disabled {
	opacity: 0.5;
	cursor: not-allowed;
	background-color: #fafafa !important; /* 클릭 시 배경색 고정 */
}

/* 🎯 [추가] 지역 탭 스타일 */
.cinema-location-tabs {
	display: flex;
	flex-wrap: wrap; /* 내용이 많으면 다음 줄로 넘어가도록 설정 */
	justify-content: flex-start;
	gap: 5px;
	margin-bottom: 15px;
	padding: 10px 0;
	border-bottom: 1px solid #eee;
}

.location-tab {
	padding: 8px 12px;
	border: 1px solid #ddd;
	border-radius: 20px;
	background-color: #f9f9f9;
	font-size: 14px;
	cursor: pointer;
	transition: all 0.2s;
	flex-shrink: 0;
}

.location-tab:hover {
	background-color: #eee;
}

.location-tab.active {
	background-color: #cd0000;
	color: white;
	border-color: #cd0000;
	font-weight: bold;
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

			<form action="<c:url value="/mypage/theaters/update" />"
				method="POST" onsubmit="return validateForm()">

				<div class="cinema-search-group">
					<div class="search-input-wrapper">

						<span class="btn-search-icon"> <i
							class="fa-solid fa-magnifying-glass"></i>
						</span> 
						<input type="text" id="cinema-search" name="cinemaSearch"
							placeholder="영화관을 검색하면 자동 완성됩니다" autocomplete="off">

						<ul id="search-results" class="search-results">
						</ul>
					</div>

					<button type="button" class="btn-add" id="openModalBtn">
						<i class="fa-solid fa-plus"></i>
					</button>
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

			<div class="cinema-location-tabs" id="modal-location-tabs"></div>
			<ul class="modal-cinema-list" id="modal-cinema-list">
			</ul>

		</div>
	</div>
	<script>
// =========================================================
// 1. 서버 데이터 변수 초기화
// =========================================================

const ALL_THEATERS = JSON.parse('${theaterListJson}');
const SAVED_THEATER_IDS = JSON.parse('${savedTheaterIdsJson}');

// 🎯 [핵심] 현재 선택된 영화관 ID를 추적하는 Set
let selectedIdSet = new Set(); 

// 📢 [유지] 키보드 조작을 위한 전역 변수
let currentFocus = -1; 

// 📢 [추가] 현재 선택된 지역 필터 초기값
let currentFilterLocation = '전체'; 

// =========================================================
// 2. DOM 요소 및 기본 모달 제어
// =========================================================

const modal = document.getElementById("myModal");
const openBtn = document.getElementById("openModalBtn");
const closeBtn = document.getElementById("modal-close-btn");

// 모달 목록 <ul> 요소
const cinemaListElement = document.getElementById("modal-cinema-list");
// 선호 목록 <ul> 요소
const selectedCinemasElement = document.getElementById("selected-cinemas"); 

// 📢 [유지] 검색 관련 DOM 요소 연결
const searchInput = document.getElementById('cinema-search'); 
const searchResultsElement = document.getElementById('search-results'); 

// 🎯 [추가] 지역 탭 컨테이너
const locationTabsElement = document.getElementById("modal-location-tabs");


// --- 모달 닫기 함수 (재사용을 위해 함수로 분리) ---
function closeModal() {
    modal.style.display = "none";
}

// --- 모달 열기 ---
if (openBtn) {
    openBtn.onclick = function() {
        modal.style.display = "block";
        
        // 모달 열 때 지역 탭 렌더링 및 전체 목록 초기 로드
        renderLocationTabs();
        filterAndRenderCinemaList(currentFilterLocation);
    }
}

// --- 모달 닫기 이벤트 핸들러 (X 버튼, 하단 버튼, 외부 영역) ---
if (closeBtn) {
    closeBtn.onclick = closeModal;
}

window.onclick = function(event) {
    if (event.target === modal) {
        closeModal();
    }
}

// =========================================================
// 3. 지역 필터링 및 렌더링 로직
// =========================================================

// 🎯 [추가] 지역 목록 추출 함수
function extractUniqueLocations() {
    // 모든 영화관 데이터에서 고유한 지역 값만 추출
    const locations = new Set(ALL_THEATERS.map(t => t.location));
    // '전체' 옵션을 가장 앞에 추가하고 나머지 지역은 가나다순 정렬
    return ['전체', ...Array.from(locations).sort()];
}

// 🎯 [추가] 지역 탭 렌더링 함수
function renderLocationTabs() {
    const locations = extractUniqueLocations();
    let tabsHtml = '';

    locations.forEach(location => {
        // 현재 필터링 중인 지역에 active 클래스 부여
        const activeClass = location === currentFilterLocation ? ' active' : '';
        tabsHtml += '<div class="location-tab' + activeClass + '" data-location="' + location + '">' + location + '</div>';
    });

    locationTabsElement.innerHTML = tabsHtml;
}

// 🎯 [추가] 지역 필터링 후 목록 렌더링 함수
function filterAndRenderCinemaList(location) {
    let filteredTheaters;
    
    if (location === '전체') {
        filteredTheaters = ALL_THEATERS;
    } else {
        // 선택된 지역과 일치하는 영화관만 필터링
        filteredTheaters = ALL_THEATERS.filter(t => t.location === location);
    }
    
    // 목록 렌더링 함수 호출
    renderCinemaList(filteredTheaters);
}

// 🎯 [추가] 지역 탭 클릭 이벤트 리스너
if (locationTabsElement) {
    locationTabsElement.addEventListener('click', function(event) {
        const clickedTab = event.target.closest('.location-tab');
        if (clickedTab) {
            const newLocation = clickedTab.dataset.location;
            
            // 1. 현재 지역 필터 업데이트
            currentFilterLocation = newLocation;
            
            // 2. 활성 클래스 업데이트
            locationTabsElement.querySelectorAll('.location-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            clickedTab.classList.add('active');
            
            // 3. 필터링된 목록 렌더링
            filterAndRenderCinemaList(newLocation);
        }
    });
}


// --- 함수: 모달 내 전체 영화관 목록 렌더링 ---
function renderCinemaList(theaters) {
    cinemaListElement.innerHTML = ''; 
    
    if (!theaters || theaters.length === 0) {
        cinemaListElement.innerHTML = '<li class="empty-state-message">선택된 지역에 등록된 영화관이 없습니다.</li>';
        return;
    }

    let html = '';
    theaters.forEach(theater => {
        const theaterId = String(theater.theaterId);
        // 🎯 [핵심] selectedIdSet을 사용해 이미 선택된 영화관은 비활성화 클래스 부여
        const disabledClass = selectedIdSet.has(theaterId) ? ' selected-disabled' : '';

    	html += '<li class="cinema-item' + disabledClass + '" data-id="' + theaterId + '" data-name="' + theater.name + '" data-location="' + theater.location + '">';
        html += '<span>' + theater.name + '</span>';
        html += ' <span style="color: #888; font-size: 0.9em;">(' + theater.location + ')</span>';
        html += '</li>';
    });
    
    cinemaListElement.innerHTML = html;
}

// 📢 [수정] 함수: 검색 결과를 HTML로 렌더링
function renderSearchResults(results) {
    searchResultsElement.innerHTML = ''; // 기존 목록 초기화
    
    if (!results || results.length === 0) {
        currentFocus = -1;
        searchResultsElement.style.display = 'none'; // 결과 없으면 숨기기
        return;
    }

    let html = '';
    results.forEach(theater => {
        const theaterId = String(theater.theaterId);
        // 🎯 [핵심] selectedIdSet을 사용해 이미 선택된 영화관은 비활성화 클래스 부여
        const disabledClass = selectedIdSet.has(theaterId) ? ' selected-disabled' : '';

        // 검색 결과 항목은 'search-item' 클래스를 사용하여 식별합니다.
        html += '<li class="search-item' + disabledClass + '" ';
        html += 'data-id="' + theaterId + '" ';
        html += 'data-name="' + theater.name + '" ';
        html += 'data-location="' + theater.location + '">';
        html += '<span>' + theater.name + '</span>';
        html += ' <span style="color: #888; font-size: 0.8em;">(' + theater.location + ')</span>';
        html += '</li>';
    });

    searchResultsElement.innerHTML = html;
    searchResultsElement.style.display = 'block'; // 결과가 있으면 보여주기
}

//--- 함수: 선호 영화관 목록에 항목 추가 ---
function addCinemaToSelectedList(id, name, location) {
    
    const stringId = String(id); 

    // 1. Set을 이용한 중복 검사 (🚨 경고창 없이 즉시 반환)
    if (selectedIdSet.has(stringId)) { 
        return; 
    }

    // 2. 항목 제거 버튼 HTML
    const removeButtonHtml = 
    '<button type="button" class="remove-btn" data-id="' + stringId + '">' +
        '&times;' +
    '</button>';
    
    // 3. 목록 항목 HTML 생성
    const newItemHtml = 
    	'<li data-id="' + stringId + '">' +
        '<span>' + name + ' (' + location + ')</span>' +
        removeButtonHtml + 
        '<input type="hidden" name="theaterId" value="' + stringId + '">' + 
    '</li>';

    // 4. 비어있던 메시지 제거 (유지)
    const emptyMessage = selectedCinemasElement.querySelector('.empty-state-message');
    if (emptyMessage) {
        emptyMessage.remove();
    }

    // 5. 선호 목록에 새 항목 추가 (유지)
    selectedCinemasElement.insertAdjacentHTML('beforeend', newItemHtml);
    
    // 🎯 Set에 ID 추가
    selectedIdSet.add(stringId);

    // 🎯 모달 목록 및 검색 결과 비활성화 처리 (실시간 업데이트)
    const modalItem = cinemaListElement.querySelector('.cinema-item[data-id="' + stringId + '"]');
    if (modalItem) {
        modalItem.classList.add('selected-disabled'); 
    }
    
    const searchItem = searchResultsElement.querySelector('.search-item[data-id="' + stringId + '"]');
    if (searchItem) {
        searchItem.classList.add('selected-disabled');
    }
}

// 📢 [유지] 함수: 서버에 검색 요청을 보내는 AJAX 함수
function fetchSearchResults(keyword) {
    // 키워드가 짧으면 요청을 보내지 않고 결과를 지웁니다. (서버와 동일한 최소 길이 2글자 권장)
    if (!keyword || keyword.length < 2) {
        renderSearchResults([]); 
        return;
    }

    // JSP 환경에서는 contextPath를 포함하여 URL 구성
    const contextPath = '${pageContext.request.contextPath}' || ''; 
    const url = contextPath + '/mypage/theaters/search?keyword=' + encodeURIComponent(keyword);

    fetch(url)
        .then(response => {
            if (!response.ok) {
                console.error('검색 요청 오류 발생. 상태 코드:', response.status);
                throw new Error('검색 요청 실패');
            }
            return response.json();
        })
        .then(data => {
            renderSearchResults(data); 
        })
        .catch(error => {
            console.error('검색 중 오류:', error);
            renderSearchResults([]);
        });
}


//=========================================================
//📢 초기 로딩 시 저장된 목록을 화면에 렌더링하는 함수
//=========================================================
function loadSavedTheaters() {
    // 🎯 Set 초기화 및 초기 ID 추가
    selectedIdSet = new Set();
    
    if (!SAVED_THEATER_IDS || SAVED_THEATER_IDS.length === 0) {
        selectedCinemasElement.innerHTML = '<li class="empty-state-message">선호 영화관이 없습니다</li>';
        return;
    }

    const theaterMap = new Map(
        ALL_THEATERS.map(t => [t.theaterId.toString(), t])
    );
 
    let html = '';
 
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
                    '<input type="hidden" name="theaterId" value="' + theaterId + '">' +
                '</li>';
            
            // 🎯 Set에 초기 ID 추가
            selectedIdSet.add(theaterId);
        }
    });

    selectedCinemasElement.innerHTML = html;
}
//=========================================================

// 🎯 X 버튼 클릭 시 DB에 단일 삭제 요청을 보내는 AJAX 함수
function deleteTheaterFromDB(theaterId, liElement) {
    
    // 🔔 [추가] 삭제 의사 확인
    const confirmDelete = confirm("선호 영화관 목록에서 삭제하시겠습니까?");
    if (!confirmDelete) {
        return; // 사용자가 '취소'를 누르면 함수 종료
    }
    
    const contextPath = '${pageContext.request.contextPath}' || '';
    
    const url = contextPath + '/mypage/theaters/delete/ajax'; 

    fetch(url, {
        method: 'POST', 
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'theaterId=' + encodeURIComponent(theaterId)
    })
    .then(response => {
        if (response.ok) {
            liElement.remove(); 
            
            // 🎯 Set에서 ID 제거
            selectedIdSet.delete(theaterId);
            
            // 🎯 모달 목록에서 재활성화 (실시간 업데이트)
            // 현재 활성화된 지역 필터로 목록을 다시 렌더링하여 비활성화 상태를 해제합니다.
            filterAndRenderCinemaList(currentFilterLocation);
            
            // 🎯 검색 결과에서도 재활성화
            const searchItem = searchResultsElement.querySelector('.search-item[data-id="' + theaterId + '"]');
            if (searchItem) {
                searchItem.classList.remove('selected-disabled');
            }

            // 🔔 [추가] 삭제 성공 알림
            alert("선호 영화관이 목록에서 삭제되었습니다.");

            // 목록이 비었을 경우 빈 상태 메시지 표시 로직
            if (selectedCinemasElement.children.length === 0) {
                const emptyStateHtml = '<li class="empty-state-message">선호 영화관이 없습니다</li>';
                selectedCinemasElement.innerHTML = emptyStateHtml;
            }
        } else {
            alert('즉시 삭제에 실패했습니다. 잠시 후 다시 시도해 주세요.');
            console.error('AJAX 삭제 실패, 상태 코드:', response.status);
        }
    })
    .catch(error => {
        alert('서버 통신 오류로 삭제에 실패했습니다.');
        console.error('AJAX 오류:', error);
    });
}


// =========================================================
// 4. 이벤트 리스너: 모달 클릭 시 선호 목록에 추가 (유지)
// =========================================================
cinemaListElement.addEventListener('click', function(event) {
    const clickedItem = event.target.closest('li');

    if (!clickedItem || clickedItem.classList.contains('empty-state-message')) {
        return;
    }
    
    // 🎯 [핵심] 비활성화된 항목은 클릭 이벤트 무시
    if (clickedItem.classList.contains('selected-disabled')) {
        alert("이미 선호 영화관으로 등록된 항목입니다.");
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
// 5. 이벤트 리스너: 선호 목록 항목 제거 (유지)
// =========================================================
selectedCinemasElement.addEventListener('click', function(event) {
    const removeButton = event.target.closest('.remove-btn');
    
    if (removeButton) {
        const liItem = removeButton.closest('li');
        const theaterIdToDelete = liItem.dataset.id;
        
        // deleteTheaterFromDB 함수 호출 (내부에서 confirm 및 비활성화 해제 처리)
        deleteTheaterFromDB(theaterIdToDelete, liItem);
    }
});


//=========================================================
//6. 폼 유효성 검사 함수 (onsubmit에서 호출됨) 
//=========================================================
function validateForm() {
    // 🔔 알림은 사용자 경험을 위해 제출 전에 보여줍니다.
    alert("선호 영화관 설정이 저장되었습니다.");
    return true; 
}

//=========================================================
// 7. 📢 [핵심] 페이지 로딩 완료 후 초기 목록 렌더링 (유지)
//=========================================================
document.addEventListener('DOMContentLoaded', function() {
 loadSavedTheaters();
});


//=========================================================
// 8. 📢 [수정] 검색창 이벤트 처리 로직 (AJAX 및 키보드 조작)
//=========================================================

let searchTimeout;

if (searchInput) {
    // 1. 입력 변화 감지 (디바운싱 적용)
    searchInput.addEventListener('input', function() {
        clearTimeout(searchTimeout); 
        const keyword = this.value.trim();
        
        currentFocus = -1;

        // 입력이 멈춘 후 300ms 후에 검색 요청을 보냅니다.
        searchTimeout = setTimeout(() => {
            fetchSearchResults(keyword); 
        }, 300);
    });

    // 📢 [수정] 키보드 이벤트 핸들러: 자동 완성 연동 및 포커스 이동 처리
    searchInput.addEventListener('keydown', function(e) {
        const results = searchResultsElement.querySelectorAll('li.search-item:not(.selected-disabled)');

        // 검색 결과가 없거나 드롭다운이 닫혀 있으면 키보드 조작을 무시합니다.
        if (results.length === 0 || searchResultsElement.style.display === 'none') {
            if (e.key === 'Enter') {
                 e.preventDefault(); 
            }
            return;
        }

        // 🎯 [핵심] ArrowUp/ArrowDown 키의 기본 스크롤/커서 이동 동작을 여기서 막습니다.
        if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
             e.preventDefault(); 
        }

        if (e.key === 'ArrowDown') {
            // 아래 방향키: 다음 항목으로 이동
            currentFocus++;
            addActive(results);
            
        } else if (e.key === 'ArrowUp') {
            // 위 방향키: 이전 항목으로 이동
            currentFocus--;
            addActive(results);
            
        } else if (e.key === 'Enter') {
            // Enter 키: 현재 활성화된 항목 선택 및 저장
            if (currentFocus > -1) {
                e.preventDefault(); 
                
                if(results[currentFocus]) {
                    results[currentFocus].click(); 
                }
            }
        }
    });
}

if (searchResultsElement) {
    // 2. 검색 결과 항목 클릭 이벤트 (이벤트 위임)
    searchResultsElement.addEventListener('click', function(event) {
        const clickedItem = event.target.closest('.search-item');

        if (clickedItem) {
            // 🎯 [핵심] 비활성화된 항목은 클릭 이벤트 무시
            if (clickedItem.classList.contains('selected-disabled')) {
                alert("이미 선호 영화관으로 등록된 항목입니다.");
                return; 
            }
            
            const id = clickedItem.dataset.id;
            const name = clickedItem.dataset.name;
            const location = clickedItem.dataset.location;
            
            // 선호 목록에 추가합니다.
            addCinemaToSelectedList(id, name, location); 

            // 항목 추가 후 검색창 초기화 및 드롭다운 닫기
            searchInput.value = '';
            renderSearchResults([]); // 드롭다운을 숨깁니다.
            // 항목 선택 후 포커스 초기화
            currentFocus = -1;
        }
    });
}

// 3. 검색창 외 다른 곳을 클릭하면 드롭다운 숨기기 (유지)
document.addEventListener('click', function(event) {
    if (searchInput && searchResultsElement) {
        // 클릭된 요소가 검색창도 아니고, 검색 결과 드롭다운 내부도 아니라면 숨깁니다.
        if (event.target !== searchInput && event.target.closest('#search-results') !== searchResultsElement) {
            // 드롭다운을 숨길 때 포커스 초기화
            currentFocus = -1;
            searchResultsElement.style.display = 'none';
        }
    }
});

// 📢 [유지] 키보드 활성화 상태 제거 함수
function removeActive(x) {
    // 모든 항목에서 'active' 클래스 제거
    for (let i = 0; i < x.length; i++) {
        x[i].classList.remove("active");
    }
}

// 📢 [수정] 키보드 활성화 상태 관리 및 검색창 자동 완성 함수 (유지)
function addActive(x) {
    // 기존 활성화 클래스 제거
    removeActive(x);
    
    // 인덱스 범위 확인 및 조정 (순환)
    if (currentFocus >= x.length) currentFocus = 0;
    if (currentFocus < 0) currentFocus = (x.length - 1);
    
    // 현재 항목에 'active' 클래스 추가
    if (x[currentFocus]) {
        x[currentFocus].classList.add("active");
        
        // 🎯 [핵심 추가] 포커스된 항목의 텍스트를 검색창에 자동 완성
        const focusedText = x[currentFocus].textContent.split('(')[0].trim(); // 위치 정보 제외
        searchInput.value = focusedText; 
        
        // 활성화된 항목이 드롭다운 영역 내에 보이도록 스크롤
        x[currentFocus].scrollIntoView({ block: 'nearest', behavior: 'smooth' });
    }
}
//=========================================================
</script>
</body>
</html>