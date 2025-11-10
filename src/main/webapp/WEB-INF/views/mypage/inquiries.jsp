<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 | 문의 내역</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
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
        }

        .header-nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
        }

        .header-nav li {
            padding: 15px 25px;
            font-size: 14px;
            color: #555;
            cursor: pointer;
            transition: color 0.3s;
            border-bottom: 3px solid transparent; 
        }

        .header-nav li:hover {
            color: #ff4d4d;
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
            color: #ff4d4d; 
            border-bottom: 3px solid #ff4d4d; 
            font-weight: bold;
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
            margin-bottom: 30px;
            font-size: 24px;
            color: #333;
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
        .col-type { width: 15%; text-align: center; }
        .col-title { width: 55%; }
        .col-date { width: 15%; text-align: center; }
        .col-status { width: 15%; text-align: center; font-weight: bold; }

        /* 상태별 색상 */
        .status-completed { color: #4CAF50; } /* 답변 완료 (녹색) */
        .status-pending { color: #ff4d4d; } /* 답변 대기 (빨간색) */

        /* 하단 액션 버튼 영역 */
        .action-bar {
            text-align: right;
            margin-top: 20px;
        }

        .inquiry-button {
            background-color: #ff4d4d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            font-size: 15px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .inquiry-button:hover {
            background-color: #e63939;
        }
        
        /* 문의 내역이 없을 때 메시지 */
        .no-inquiries {
            text-align: center;
            padding: 50px 0;
            color: #999;
            font-size: 16px;
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
            <li class="active"><a href="/movielist/mypage/inquiries"><i class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
            <li><a href="/movielist/mypage/movierequest"><i class="fa-solid fa-film"></i> 영화 요청</a></li>
        </ul>
    </div>

    <div class="container">
        <div class="content-box">
            <h1>문의 내역</h1>

            <div class="inquiry-list">
                
                <div class="inquiry-header">
                    <span class="col-type">구분</span>
                    <span class="col-title">제목</span>
                    <span class="col-date">등록일</span>
                    <span class="col-status">답변 상태</span>
                </div>

                <div class="inquiry-item">
                    <span class="col-type">결제</span>
                    <span class="col-title">결제 금액이 이중으로 청구되었습니다.</span>
                    <span class="col-date">2025.11.01</span>
                    <span class="col-status status-completed">답변 완료</span>
                </div>
                
                <div class="inquiry-item">
                    <span class="col-type">영화관</span>
                    <span class="col-title">영화관 시설 관련 문의 드립니다.</span>
                    <span class="col-date">2025.11.05</span>
                    <span class="col-status status-pending">답변 대기</span>
                </div>
                
                <div class="inquiry-item">
                    <span class="col-type">회원정보</span>
                    <span class="col-title">아이디 변경이 가능한가요?</span>
                    <span class="col-date">2025.10.20</span>
                    <span class="col-status status-completed">답변 완료</span>
                </div>
                
                </div>
            
            <div class="action-bar">
                <button class="inquiry-button">새 문의 작성</button>
            </div>
        </div>
    </div>
</body>
</html>