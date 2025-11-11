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
    <title>마이페이지 | 영화 요청</title>
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

        /* 🚨 영화 요청 메뉴를 활성화합니다. */
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
            max-width: 600px; /* 폼에 맞게 너비 조정 */
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
        /* 3. 영화 요청 폼 전용 스타일 */
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

        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 15px;
            box-sizing: border-box; /* 패딩이 너비에 포함되도록 설정 */
            transition: border-color 0.2s;
        }
        
        .form-group input[type="text"]:focus,
        .form-group textarea:focus {
            border-color: #ff4d4d;
            outline: none;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }
        
        /* 요청 버튼 */
        .submit-button {
            width: 100%;
            background-color: #ff4d4d;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 4px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.2s;
        }

        .submit-button:hover {
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
            <li><a href="/movielist/mypage/paymentmethod"><i class="fa-solid fa-credit-card"></i> 결제 수단</a></li>
            <li><a href="/movielist/mypage/inquiries"><i class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
            <li class="active"><a href="/movielist/mypage/movierequest"><i class="fa-solid fa-film"></i> 영화 요청</a></li>
        </ul>
    </div>

    <div class="container">
        <div class="content-box">
            <h1>영화 상영 요청</h1>
            
            <form action="#" method="POST">
                
                <div class="form-group">
                    <label for="movie-title">영화 제목 <span style="color: #ff4d4d;">*</span></label>
                    <input type="text" id="movie-title" name="movieTitle" placeholder="정확한 영화 제목을 입력해주세요" required>
                </div>
                
                <div class="form-group">
                    <label for="director">감독 (선택)</label>
                    <input type="text" id="director" name="director" placeholder="감독명을 입력해주세요">
                </div>

                <div class="form-group">
                    <label for="release-year">개봉 연도 (선택)</label>
                    <input type="text" id="release-year" name="releaseYear" placeholder="개봉 연도를 YYYY 형식으로 입력해주세요">
                </div>
                
                <div class="form-group">
                    <label for="request-reason">요청 사유 및 상세 내용 (선택)</label>
                    <textarea id="request-reason" name="requestReason" placeholder="이 영화를 요청하는 이유나 추가 정보를 입력해주세요."></textarea>
                </div>
                
                <button type="submit" class="submit-button">
                    <i class="fa-solid fa-paper-plane"></i> 영화 상영 요청하기
                </button>
            </form>

        </div>
    </div>
</body>
</html>