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
    <title>마이페이지 | 결제 수단 관리</title>
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

        /* 🚨 결제 수단 메뉴를 활성화합니다. */
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
            max-width: 600px; /* 카드 관리는 조금 좁게 설정 */
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
        /* 3. 결제 수단 리스트 전용 스타일 */
        /* ========================================================== */
        
        .payment-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        /* 개별 카드 항목 */
        .card-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fff;
            transition: box-shadow 0.2s;
        }
        
        .card-item:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card-info {
            display: flex;
            align-items: center;
        }

        .card-icon {
            font-size: 30px;
            margin-right: 20px;
            color: #444;
        }

        .card-details {
            display: flex;
            flex-direction: column;
        }

        .card-name {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }

        .card-number {
            font-size: 14px;
            color: #777;
            margin-top: 2px;
        }
        
        /* 기본 카드 (Primary) 표시 */
        .card-primary {
            background-color: #ff4d4d;
            color: white;
            font-size: 12px;
            padding: 2px 6px;
            border-radius: 3px;
            margin-left: 10px;
            font-weight: normal;
        }

        /* 버튼 */
        .delete-button {
            background: none;
            border: none;
            color: #999;
            font-size: 16px;
            cursor: pointer;
            transition: color 0.2s;
        }
        
        .delete-button:hover {
            color: #ff4d4d;
        }
        
        /* 하단 액션 버튼 영역 */
        .action-bar {
            text-align: center;
            margin-top: 30px;
        }

        .register-button {
            background-color: #ff4d4d;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .register-button:hover {
            background-color: #e63939;
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
            <li class="active"><a href="/movielist/mypage/paymentmethod"><i class="fa-solid fa-credit-card"></i> 결제 수단</a></li>
            <li><a href="/movielist/mypage/inquiries"><i class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
            <li><a href="/movielist/mypage/movierequest"><i class="fa-solid fa-film"></i> 영화 요청</a></li>
        </ul>
    </div>

    <div class="container">
        <div class="content-box">
            <h1>결제 수단 관리</h1>

            <div class="payment-list">
                
                <div class="card-item">
                    <div class="card-info">
                        <i class="fa-regular fa-credit-card card-icon"></i>
                        <div class="card-details">
                            <div class="card-name">
                                국민카드 <span class="card-primary">기본</span>
                            </div>
                            <div class="card-number">**** **** **** 1234</div>
                        </div>
                    </div>
                    <button class="delete-button"><i class="fa-solid fa-trash-can"></i></button>
                </div>
                
                <div class="card-item">
                    <div class="card-info">
                        <i class="fa-regular fa-credit-card card-icon"></i>
                        <div class="card-details">
                            <div class="card-name">신한카드</div>
                            <div class="card-number">**** **** **** 5678</div>
                        </div>
                    </div>
                    <button class="delete-button"><i class="fa-solid fa-trash-can"></i></button>
                </div>
                
            </div>
            
            <div class="action-bar">
                <button class="register-button">
                    <i class="fa-solid fa-plus"></i> 카드 등록하기
                </button>
            </div>
        </div>
    </div>
</body>
</html>