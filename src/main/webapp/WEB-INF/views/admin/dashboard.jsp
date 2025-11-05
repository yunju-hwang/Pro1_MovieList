<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
/* 기본 설정 */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f4f7f6;
    margin: 20px;
    padding: 0;
}

.dashboard-container {
    max-width: 1200px;
    margin: 0 auto;
    background-color: #fff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

/* 1번 영역: 상단 통계 카드 스타일 */
.stats-bar {
    display: flex;
    justify-content: space-between;
    gap: 10px;
    padding: 10px 0;
    border: 3px solid #add8e6; /* 전체 바깥 테두리 (파란색) */
    border-radius: 8px;
    margin-bottom: 25px;
}

.stat-card {
    flex: 1; 
    display: flex;
    justify-content: space-between; /* 텍스트와 아이콘을 양 끝으로 */
    align-items: center;
    padding: 10px 15px;
    border-right: 1px solid #eee; /* 카드 사이 구분선 */
    cursor: pointer;
    transition: background-color 0.2s;
}

.stat-card:last-child {
    border-right: none;
}

.stat-content {
    display: flex;
    flex-direction: column;
    text-align: left;
}

.stat-card .label {
    font-size: 14px;
    color: #555;
}

.stat-card .value {
    font-size: 20px;
    font-weight: bold;
    margin-top: 2px;
}

/* 이미지 들어갈 영역 스타일 */
.stat-icon-area {
    width: 30px; 
    height: 30px;
    background-color: transparent;
    font-size: 12px; 
    color: #999;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* 색상별 스타일 */
.stat-card.blue .value { color: #007bff; }
.stat-card.red .value { color: #dc3545; }
.stat-card.green .value { color: #28a745; }
.stat-card.orange .value { color: #ffc107; }
.stat-card.gray .value { color: #6c757d; }


/* --- */

/* 2번 영역: 메뉴 탭 스타일 */
.menu-tabs {
    display: flex;
    gap: 5px;
    margin-bottom: 30px;
}

.tab {
    background-color: #f8f9fa;
    border: 1px solid #dee2e6;
    padding: 8px 15px;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s, color 0.2s;
    border-radius: 5px;
    white-space: nowrap;
    border-bottom: none; /* 탭 밑줄 제거 */
}

.tab.active {
    background-color: #dc3545; /* 활성화된 탭은 빨간색 배경 */
    color: #fff;
    border-color: #dc3545;
}

/* --- */

/* 3번 영역: 테이블 섹션 스타일 */
.table-section {
    border: 1px solid #dc3545; /* 테이블 주변에 빨간 테두리 */
    border-radius: 8px;
    overflow: hidden;
    padding: 1px;
}

.movie-table {
    width: 100%;
    border-collapse: collapse;
    text-align: left;
}

.movie-table th, .movie-table td {
    padding: 12px 15px;
    border-bottom: 1px solid #f0f0f0;
}

.movie-table thead th {
    background-color: #f8f9fa;
    font-weight: bold;
    color: #333;
}

/* 테이블 데이터가 들어갈 부분 스타일 */
.movie-table tbody tr {
    /* DB 데이터가 없을 때도 최소 높이 유지 */
    min-height: 50px; 
}
.movie-table tbody td {
    text-align: center; /* 데이터가 비어있을 때 가운데 정렬 */
    color: #ccc;
    height: 50px; /* 행 높이 고정 */
}


/* 관리 버튼 스타일 */
.delete-btn {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 18px;
    padding: 0;
    line-height: 1;
    transition: transform 0.1s;
}

.delete-btn:hover {
    transform: scale(1.1);
}</style>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 관리 대시보드</title>
    <link rel="stylesheet" href="style.css"> </head>
<body>

    <div class="dashboard-container">

        <div class="stats-bar">
            <div class="stat-card blue">
                <div class="stat-content">
                    <span class="label">전체 사용자</span>
                    <span class="value">10</span>
                </div>
                <div class="stat-icon-area">*이미지넣을부분*</div>
            </div>
            
            <div class="stat-card red">
                 <div class="stat-content">
                    <span class="label">전체 리뷰</span>
                    <span class="value">10</span>
                </div>
                <div class="stat-icon-area">*이미지넣을부분*</div>
            </div>
            
            <div class="stat-card green">
                 <div class="stat-content">
                    <span class="label">전체 예매</span>
                    <span class="value">5</span>
                </div>
                <div class="stat-icon-area">*이미지넣을부분*</div>
            </div>
            
            <div class="stat-card orange">
                 <div class="stat-content">
                    <span class="label">답변 문의</span>
                    <span class="value">1</span>
                </div>
                <div class="stat-icon-area" >
                <img src="${pageContext.request.contextPath}/resources/img/question.png"
                alt="문의 아이콘" style="width: 100%; height: 100%;">
                </div>
            </div>
            
            <div class="stat-card gray">
                 <div class="stat-content">
                    <span class="label">대기 요청</span>
                    <span class="value">8</span>
                </div>
                <div class="stat-icon-area">*이미지넣을부분*</div>
            </div>
        </div>
        
        <div class="menu-tabs">
            <button class="tab active">영화관리</button>
            <button class="tab">사용자 관리</button>
            <button class="tab">1:1문의</button>
            <button class="tab">영화 요청</button>
            <button class="tab">리뷰 관리</button>
            <button class="tab">예매 관리</button>
        </div>

        <div class="table-section">
            <table class="movie-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>제목</th>
                        <th>장르</th>
                        <th>평점</th>
                        <th>상영시간</th>
                        <th>긍정리뷰</th>
                        <th>부정리뷰</th>
                        <th>개봉일</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                        <td><button class="delete-btn">🗑️</button></td>
                    </tr>
                    <tr>
                        <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                        <td><button class="delete-btn">🗑️</button></td>
                    </tr>
                </tbody>
            </table>
        </div>

    </div>

</body>
</html>