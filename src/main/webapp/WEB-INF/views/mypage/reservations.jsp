<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 | 예매 내역</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f7f7f7;
	min-height: 100vh;
}

.header-nav {
	width: 100%;
	margin: 0;
	background-color: #ffffff;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
	/* 🚨 NAVBAR 전체 높이 유지를 위해 상하 패딩 추가 */
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
	/* 🚨 버튼 크기 수정: 위아래 15px -> 12px, 양옆 25px -> 20px */
	padding: 12px 20px;
	font-size: 14px;
	color: #555;
	cursor: pointer;
	/* 🚨 배경색 전환 효과 및 버튼 형태 스타일 추가/수정 */
	transition: color 0.3s, background-color 0.3s;
	border-bottom: none; /* 기존 밑줄 제거 */
	border-radius: 4px; /* 버튼 모서리 둥글게 */
	margin: 0 7px; /* 버튼 간 간격 조정 */
}

/* 🚨 Hover 효과: 배경색 진한 빨간색 (#cd0000), 글자색 흰색 */
.header-nav li:hover {
	color: white;
	background-color: #cd0000;
}

/* 🚨 A 태그 스타일 (링크 스타일 초기화 및 영역 확장) */
.header-nav li a {
	text-decoration: none;
	color: inherit;
	display: flex;
	align-items: center;
}

/* 🚨 활성화된 메뉴 스타일: 진한 빨간색 버튼 */
.header-nav li.active {
	color: white;
	background-color: #cd0000; /* 진한 빨간색 적용 */
	border-bottom: none; /* 기존 밑줄 제거 */
	font-weight: bold;
}

/* 🚨 활성화된 메뉴 Hover 효과: 더 진한 빨간색 */
.header-nav li.active:hover {
	background-color: #a00000; /* #cd0000보다 더 진한 색상으로 설정 */
	color: white;
}

.header-nav li i {
	margin-right: 5px;
}

.container {
	padding: 40px 20px;
	width: 100%;
	max-width: 900px;
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

.reservation-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
	padding-bottom: 10px;
	border-bottom: 1px solid #eee;
}

.reservation-summary {
	font-size: 14px;
	color: #555;
	font-weight: bold;
}

.reservation-item {
	border: 1px solid #f0f0f0;
	background-color: #fff8f8;
	border-radius: 8px;
	margin-bottom: 20px;
	padding: 20px;
}

.item-main-info {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding-bottom: 15px;
	margin-bottom: 15px;
	border-bottom: 1px solid #f0e0e0;
}

.movie-title-group {
	display: flex;
	align-items: center;
}

.movie-title-group i {
	color: #cd0000;
	margin-right: 10px;
	font-size: 20px;
}

.movie-title-group h2 {
	margin: 0;
	font-size: 18px;
	color: #333;
}

.movie-title-group small {
	display: block;
	font-size: 12px;
	color: #777;
	margin-top: 3px;
}

.status-tag {
	background-color: #cd0000;
	color: white;
	padding: 5px 10px;
	border-radius: 4px;
	font-size: 13px;
	font-weight: bold;
}

.item-detail {
	display: grid;
	grid-template-columns: 1fr 1fr; /* 좌우 2단 */
	gap: 10px 30px;
	font-size: 14px;
	color: #555;
}

.detail-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.detail-row strong {
	color: #333;
	white-space: nowrap;
	font-weight: bold;
	vertical-align: middle;
	font-size: 15px;
}

.info-left {
    display: flex;
    flex-direction: column;
    gap: 10px; /* 내부 detail-row 간격 추가 */
}

.info-right {
    display: flex; /* 내부 요소들을 세로로 배치하기 위해 flex 사용 */
    flex-direction: column;
    gap: 10px; /* 내부 detail-row 간격 */
}

.final-amount-row {
    grid-column: 1 / span 2; /* 전체 너비 사용 */
    margin-top: 15px;
	padding-top: 15px;
	border-top: 1px dashed #f0e0e0; /* 경계선 추가 */
	font-size: 16px; /* 강조 */
}

.cancel-box {
	text-align: center;
	margin-top: 20px;
	padding-top: 10px;
	border-top: 1px solid #f0f0f0;
}

.cancel-btn {
	padding: 10px 20px;
	background: none;
	border: 1px solid #cd0000;
	color: #cd0000;
	font-weight: bold;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.2s;
}

.cancel-btn:hover {
	background-color: #fcebeb;
}

.no-reservations {
	text-align: center;
	padding: 50px 0;
	color: #888;
	font-size: 16px;
	border: 1px dashed #ddd;
	border-radius: 8px;
}

#pagination-controls {
    text-align: center;
    margin-top: 30px;
    padding-top: 20px;
    border-top: 1px solid #eee;
}

#pagination-controls button:disabled {
    cursor: not-allowed;
    opacity: 0.5;
}

.status-tag.canceled {
    background-color: #888; /* 회색 계열 */
}

/* 취소된 항목 전체 배경색 */
.reservation-item.canceled-item {
    background-color: #f0f0f0; 
    border: 1px solid #ddd;
    opacity: 0.8;
}

/* 비활성화된 버튼 스타일 */
.cancel-btn:disabled {
    cursor: not-allowed;
    opacity: 0.6;
    border-color: #aaa;
    color: #aaa;
    background-color: #f7f7f7 !important;
}
.cancel-btn:disabled:hover {
    background-color: #f7f7f7;
}

.page-nav-btn {
    padding: 10px 15px; 
    margin: 0 5px;
    cursor: pointer; 
    border: 1px solid #ccc; 
    background-color: white; 
    border-radius: 4px;
}
.page-nav-btn:hover:not(:disabled) {
    background-color: #f0f0f0;
}

.filter-controls {
    margin: 15px 0;
    text-align: center;
}

.filter-controls .filter-btn {
    padding: 8px 15px;
    margin: 0 5px;
    border: 1px solid #ccc;
    background-color: #f8f8f8;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
}

.filter-controls .filter-btn.active {
    background-color: #cd0000; /* 활성화 색상 */
    color: white;
    border-color: #cd0000;
    font-weight: bold;
}

</style>

</head>
<body>
	<div class="header-nav">
		<ul>
			<li class="active"><a href="/movielist/mypage/reservations"><i
					class="fa-solid fa-calendar-check"></i> 예매 내역</a></li>
			<li><a href="/movielist/mypage/favorites"><i
					class="fa-regular fa-heart"></i> 관심 목록</a></li>
			<li><a href="/movielist/mypage/profile"><i
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
		<div class="reservation-header">
			<h1>예매 내역</h1>
			<div class="reservation-summary">총 ${count}건의 예매</div>
		</div>
		
		<div class="filter-controls">
			<button class="filter-btn active" data-filter="all">전체</button>
			<button class="filter-btn" data-filter="reserved">예매 완료</button>
			<button class="filter-btn" data-filter="cancelled">예매 취소</button>
		</div>
		<hr>
		
		<div id="reservation-list">
			<c:choose>
				<c:when test="${not empty reservationList}">
					<c:forEach var="reservation" items="${reservationList}">
						<%-- 취소 여부 판단 변수 설정: 'cancelled'와 비교 --%>
						<c:set var="isCanceled" value="${reservation.status eq 'cancelled'}" />
						
						<div class="reservation-item ${isCanceled ? 'canceled-item' : ''}" 
							data-id="${reservation.id}" 
							data-status="${reservation.status}">

							<div class="item-main-info">
								<div class="movie-title-group">
									<i class="fa-solid fa-ticket"></i>
									<div>
										<h2>${reservation.movieTitle}</h2>
										<c:set var="resDate" value="${reservation.reservationDate}" />
										<small>예매일: <c:out
												value="${fn:substring(resDate, 0, 10)}" /> <c:out
												value="${fn:substring(resDate, 11, 16)}" />
										</small>
									</div>
								</div>
								<%-- isCanceled 값에 따라 한글 상태 태그 출력 --%>
								<span class="status-tag ${isCanceled ? 'canceled' : ''}" style="background-color: ${isCanceled ? '#888' : '#cd0000'};">
									${isCanceled ? '예매 취소' : '예매 완료'}
								</span>
							</div>

							<div class="item-detail">
								
								<div class="info-left">
									<div class="detail-row">
										<span>상영관</span> <strong>${reservation.theaterName}</strong>
									</div>
									<div class="detail-row">
										<span>상영 일시</span>
										<c:set var="screenTime" value="${reservation.screeningTime}" />
										<strong> <c:out
												value="${fn:substring(screenTime, 0, 10)}" /> 	
										<c:out value="${fn:substring(screenTime, 11, 16)}" />
										</strong>
									</div>
								</div>

								<div class="info-right">
									
									<div class="detail-row">
										<span>관람 인원</span> 
										<strong>
											성인 ${reservation.adultPeople}명
											<c:if test="${reservation.childPeople > 0}"> / 어린이 ${reservation.childPeople}명
											</c:if>
										</strong>
									</div>
									
									<div class="detail-row">
										<span>좌석</span> <strong>${reservation.seat}</strong>
									</div>
									
								</div>
								
								<div class="final-amount-row detail-row">
									<span>최종 결제 금액</span> 
									<strong><fmt:formatNumber value="${reservation.finalAmount}" pattern="#,###" />원</strong>
								</div>

							</div>
                            <div class="cancel-box">
								<%-- isCanceled 값에 따라 버튼 비활성화 및 텍스트 변경 --%>
								<button class="cancel-btn"
									data-reservation-id="${reservation.id}"
									${isCanceled ? 'disabled' : ''}>
									${isCanceled ? '취소 완료' : '예매 취소'}
								</button>
							</div>
						</div>
					</c:forEach>
				</c:when>
				</c:choose>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	   
	<script>
    // jQuery 사용 방지 설정
    const j = jQuery.noConflict();  
    
    // --- 페이지네이션 변수 설정 ---
    const container = document.getElementById('reservation-list');
    let items; // 현재 표시되는 예매 항목
    let totalItems;
    let currentPage = 1;
    const itemsPerPage = 1; // 한 페이지에 1개의 예매 내역만 표시
    const pageBlockSize = 5; // 한 번에 보여줄 페이지 번호 개수 (예: 1 2 3 4 5)

    // ==========================================================
    // 1. 예매 내역 정렬 함수 (취소된 항목을 뒤로)
    // ==========================================================
    function sortReservations() {
    const listContainer = document.getElementById('reservation-list');
    const allItems = document.querySelectorAll('.reservation-item');
    const currentItems = Array.from(allItems);

    currentItems.sort((a, b) => {
        // 1. 예매일 문자열 추출
        // a.querySelector('small').textContent는 "예매일: 2025-12-04 12:00" 형태의 문자열을 반환합니다.
        const dateStringA = a.querySelector('small').textContent.replace('예매일: ', '').trim();
        const dateStringB = b.querySelector('small').textContent.replace('예매일: ', '').trim();

        // 2. Date 객체로 변환 (정확한 비교를 위해)
        // YYYY-MM-DD HH:MM 형식은 ISO 포맷처럼 인식되므로 new Date() 사용 가능
        const dateA = new Date(dateStringA);
        const dateB = new Date(dateStringB);
        
        // 3. 내림차순 정렬 (최신 예매일이 앞으로)
        return dateB.getTime() - dateA.getTime();
    });

    // 정렬된 순서대로 DOM에 다시 삽입하여 순서만 변경합니다.
    currentItems.forEach(item => {
        listContainer.appendChild(item);
    });
    
    // 정렬 후, 현재 활성화된 필터 값을 기준으로 목록을 업데이트합니다.
    const activeFilter = document.querySelector('.filter-btn.active')?.dataset.filter || 'all';
    filterReservations(activeFilter);
}
    
    // ==========================================================
    // 2. 페이지네이션 초기화 및 표시 함수
    // ==========================================================
    function initializePagination() {
        totalItems = items.length;
        currentPage = 1; 
        
        if (totalItems > 0) {
            displayPage(currentPage);
        } else {
             // 항목이 0개일 경우 페이지네이션 컨트롤 삭제
             const existingControls = document.getElementById('pagination-controls');
             if (existingControls) existingControls.remove();
        }
    }

    // 3. 페이지네이션 컨트롤러 생성 함수 (페이지 번호 목록)
    function createPaginationControls() {
        const existingControls = document.getElementById('pagination-controls');
        if (existingControls) {
            existingControls.remove();
        }

        const totalPages = Math.ceil(totalItems / itemsPerPage);
        
        if (totalPages <= 1) return; 

        const controls = document.createElement('div');
        controls.id = 'pagination-controls';
        controls.style.cssText = 'text-align: center; margin-top: 20px;';

        const currentBlock = Math.ceil(currentPage / pageBlockSize);
        const startPage = (currentBlock - 1) * pageBlockSize + 1;
        let endPage = startPage + pageBlockSize - 1;
        
        if (endPage > totalPages) {
            endPage = totalPages;
        }

        // [이전] 버튼
        if (startPage > 1) {
            const prevBlockBtn = document.createElement('button');
            prevBlockBtn.textContent = '이전';
            prevBlockBtn.className = 'page-nav-btn';
            prevBlockBtn.style.cssText = 'padding: 10px 15px; margin-right: 10px; cursor: pointer; border: 1px solid #ccc; background-color: white; border-radius: 4px;';
            prevBlockBtn.onclick = () => {
                currentPage = startPage - 1; 
                displayPage(currentPage);
            };
            controls.appendChild(prevBlockBtn);
        }

        // 페이지 번호 링크
        for (let i = startPage; i <= endPage; i++) {
            const pageBtn = document.createElement('button');
            pageBtn.textContent = i;
            pageBtn.className = 'page-num-btn';
            pageBtn.style.cssText = 'margin: 0 5px; padding: 5px 10px; cursor: pointer; border: 1px solid #ccc; background-color: white; border-radius: 4px;';
            
            if (i === currentPage) {
                pageBtn.style.cssText = 'margin: 0 5px; padding: 5px 10px; border: 1px solid #cd0000; background-color: #cd0000; color: white; border-radius: 4px; font-weight: bold; cursor: default;';
                pageBtn.disabled = true;
            }

            pageBtn.onclick = (function(pageNumber) {
                return function() {
                    currentPage = pageNumber;
                    displayPage(currentPage);
                };
            })(i);
            
            controls.appendChild(pageBtn);
        }

        // [다음] 버튼
        if (endPage < totalPages) {
            const nextBlockBtn = document.createElement('button');
            nextBlockBtn.textContent = '다음';
            nextBlockBtn.className = 'page-nav-btn';
            nextBlockBtn.style.cssText = 'padding: 10px 15px; margin-left: 10px; cursor: pointer; border: 1px solid #ccc; background-color: white; border-radius: 4px;';

            nextBlockBtn.onclick = () => {
                currentPage = endPage + 1; 
                displayPage(currentPage);
            };
            controls.appendChild(nextBlockBtn);
        }
        
        container.parentNode.insertBefore(controls, container.nextSibling);
    }

    // 4. 특정 페이지의 항목만 표시하는 함수
    function displayPage(page) {
        const start = (page - 1) * itemsPerPage;
        const end = start + itemsPerPage;

        items.forEach((item, index) => {
            if (index >= start && index < end) {
                item.style.display = 'block';
            } else {
                item.style.display = 'none';
            }
        });
        
        createPaginationControls(); 
    }
    
    // ==========================================================
    // 5. 🟢 [수정] 필터링 함수 (DOM 조작 대신 display 토글 사용)
    // ==========================================================
    function filterReservations(filterStatus) {
        // DOM에 있는 모든 예매 항목을 가져옵니다.
        const allItemsInDOM = document.querySelectorAll('.reservation-item');
        const listContainer = document.getElementById('reservation-list');
        
        // 이전에 추가된 'no-reservations' 메시지가 있다면 제거
        const existingNoReservations = listContainer.querySelector('.no-reservations');
        if (existingNoReservations) {
            existingNoReservations.remove();
        }
        
        const filteredItems = [];

        // 1. 모든 항목을 순회하며 display 스타일 토글
        allItemsInDOM.forEach(item => {
            const itemStatus = item.dataset.status;
            let shouldShow = false;

            if (filterStatus === 'all') {
                shouldShow = true;
            } else if (filterStatus === itemStatus) {
                shouldShow = true;
            }

            if (shouldShow) {
                item.style.display = 'block';
                filteredItems.push(item);
            } else {
                item.style.display = 'none';
            }
        });

        // 2. 항목이 0개일 때 처리
        if (filteredItems.length === 0) {
            const noReservationsDiv = document.createElement('div');
            noReservationsDiv.className = 'no-reservations';
            noReservationsDiv.innerHTML = `
                <i class="fa-solid fa-ticket fa-2x" style="margin-bottom: 10px;"></i>
                <p>예매 내역이 없습니다.</p>
            `;
            listContainer.appendChild(noReservationsDiv);
        }
        
        // 3. 페이지네이션 재실행
        items = filteredItems;
        initializePagination();
    }

    // ==========================================================
    // 6. DOMContentLoaded (이벤트 핸들러)
    // ==========================================================
    document.addEventListener('DOMContentLoaded', function() {
        // 1. 초기 로드 시 정렬 및 '전체' 필터 적용
        // sortReservations 내부에서 filterReservations('all')을 호출함
        sortReservations(); 

        // 필터링 버튼 이벤트 리스너 설정
        document.querySelectorAll('.filter-btn').forEach(button => {
            button.addEventListener('click', (e) => {
                const buttonElement = e.target;
                const filterValue = buttonElement.dataset.filter;
                
                // 버튼 active 클래스 업데이트
                document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
                buttonElement.classList.add('active');
                
                // 필터링 실행
                filterReservations(filterValue);
            });
        });

        // 취소 버튼 이벤트 리스너 설정
        document.querySelectorAll('.cancel-btn').forEach(button => {
            button.addEventListener('click', (e) => {
                const buttonElement = e.target;
                const reservationId = buttonElement.dataset.reservationId;
                
                if (buttonElement.disabled) return;

                if (confirm(`예매를 취소하시겠습니까?`)) {
                    j.ajax({
                        url: '<c:url value="/mypage/reservations/cancel" />',
                        type: 'POST',
                        data: { reservationId: reservationId },
                        dataType: 'json',
                        success: function(response) {
                            if (response.isSuccess) {
                                alert(response.message);
                                
                                const item = buttonElement.closest('.reservation-item');
                                
                                // 데이터 상태를 'cancelled'로 변경
                                item.dataset.status = 'cancelled'; 
                                item.classList.add('canceled-item');
                                
                                // 상태 태그 및 버튼 업데이트
                                const statusTag = item.querySelector('.status-tag');
                                if (statusTag) {
                                    statusTag.textContent = '예매 취소'; 
                                    statusTag.style.backgroundColor = '#888';
                                    statusTag.classList.add('canceled');
                                }
                                
                                buttonElement.textContent = '취소 완료';
                                buttonElement.disabled = true;
                                
                                // 취소 후 정렬 및 현재 필터 다시 적용
                                sortReservations(); 

                            } else {
                                alert('취소 실패: ' + response.message);
                            }
                        },
                        error: function() {
                            alert('서버 통신 오류가 발생했습니다.');
                        }
                    });
                }
            });
        });
    });
</script>
</body>
</html>