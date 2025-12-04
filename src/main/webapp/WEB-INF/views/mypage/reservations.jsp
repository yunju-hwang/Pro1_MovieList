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
		
		<div id="reservation-list">
			<c:choose>
				<c:when test="${not empty reservationList}">
					<c:forEach var="reservation" items="${reservationList}">
						<div class="reservation-item" data-id="${reservation.id}">

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
								<span class="status-tag">예매 완료</span>
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
								<button class="cancel-btn"
									data-reservation-id="${reservation.id}">예매 취소</button>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="no-reservations">
						<i class="fa-solid fa-ticket fa-2x" style="margin-bottom: 10px;"></i>
						<p>예매 내역이 없습니다.</p>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

	   
	<script>
    // jQuery 사용 방지 설정 (기존 코드 유지)
    const j = jQuery.noConflict(); 
    
    // --- 페이지네이션 변수 설정 ---
    const items = document.querySelectorAll('.reservation-item');
    const totalItems = items.length;
    let currentPage = 1;
    const itemsPerPage = 1; // 🚩 한 페이지에 1개의 예매 내역만 표시
    
    // --- HTML 요소 추가 ---
    const container = document.getElementById('reservation-list');
    
    // 페이지네이션 컨트롤러를 생성하는 함수
    function createPaginationControls() {
        // 이미 컨트롤이 있으면 제거
        const existingControls = document.getElementById('pagination-controls');
        if (existingControls) {
            existingControls.remove();
        }

        const totalPages = Math.ceil(totalItems / itemsPerPage);
        
        // 총 항목 수가 1개 이하일 경우 컨트롤 표시 안 함
        if (totalPages <= 1) return; 

        const controls = document.createElement('div');
        controls.id = 'pagination-controls';
        controls.style.cssText = 'text-align: center; margin-top: 20px;';

        // 이전 버튼
        const prevBtn = document.createElement('button');
        prevBtn.textContent = '이전';
        prevBtn.style.cssText = 'padding: 10px 15px; margin-right: 10px; cursor: pointer; border: 1px solid #ccc; background-color: white; border-radius: 4px;';
        prevBtn.disabled = (currentPage === 1);
        prevBtn.onclick = () => {
            if (currentPage > 1) {
                currentPage--;
                displayPage(currentPage);
            }
        };
        controls.appendChild(prevBtn);

        // 페이지 번호 표시
        const pageInfo = document.createElement('span');
        pageInfo.textContent = `${currentPage} / ${totalPages}`;
        pageInfo.style.cssText = 'font-weight: bold; font-size: 16px; color: #cd0000;';
        controls.appendChild(pageInfo);

        // 다음 버튼
        const nextBtn = document.createElement('button');
        nextBtn.textContent = '다음';
        nextBtn.style.cssText = 'padding: 10px 15px; margin-left: 10px; cursor: pointer; border: 1px solid #ccc; background-color: white; border-radius: 4px;';
        nextBtn.disabled = (currentPage === totalPages);
        nextBtn.onclick = () => {
            if (currentPage < totalPages) {
                currentPage++;
                displayPage(currentPage);
            }
        };
        controls.appendChild(nextBtn);

        // 컨트롤을 목록 컨테이너 뒤에 추가
        container.parentNode.insertBefore(controls, container.nextSibling);
    }

    // 특정 페이지의 항목만 표시하는 함수
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
        
        // 페이지 정보 및 버튼 상태 업데이트
        createPaginationControls(); 
    }
    
    // 초기 로드 시 1페이지 표시
    if (totalItems > 0) {
        displayPage(currentPage);
    }
    
    // --- 취소 버튼 이벤트 리스너 (기존 기능 유지) ---
    document.querySelectorAll('.cancel-btn').forEach(button => {
        button.addEventListener('click', (e) => {
            const reservationId = e.target.dataset.reservationId;
            const item = e.target.closest('.reservation-item');
            const title = item.querySelector('h2').textContent;
            
            if (confirm(`'${title}' 예매를 정말로 취소하시겠습니까?`)) {
                // 실제 구현: 서버로 취소 요청 (AJAX 또는 폼 제출)
                alert("취소 요청이 접수되었습니다. (실제 기능은 서버에서 처리됩니다.)");
            }
        });
    });
</script>
</body>
</html>