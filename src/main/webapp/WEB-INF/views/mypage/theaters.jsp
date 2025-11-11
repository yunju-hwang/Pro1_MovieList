<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 | 선호 영화관</title>
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

        /* 🚨 선호 영화관 메뉴를 활성화합니다. */
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
        /* 3. 선호 영화관 폼 전용 스타일 (추가/수정) */
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

        /* 영화관 검색/추가 필드용 flexbox */
        .cinema-search-group {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
        }

        .cinema-search-group input[type="text"] {
            flex-grow: 1;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 15px;
            box-sizing: border-box;
        }

        .cinema-search-group button {
            background-color: #5cb85c; /* 추가 버튼 색상 */
            color: white;
            border: none;
            padding: 12px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 15px;
            transition: background-color 0.2s;
        }
        
        .cinema-search-group button:hover {
            background-color: #4cae4c;
        }
        
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

        /* 저장 버튼 (기존 스타일 유지) */
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
            margin-top: 20px;
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
            <li class="active"><a href="/movielist/mypage/theaters"><i class="fa-solid fa-map-pin"></i> 선호 영화관</a></li>
            <li><a href="/movielist/mypage/paymentmethod"><i class="fa-solid fa-credit-card"></i> 결제 수단</a></li>
            <li><a href="/movielist/mypage/inquiries"><i class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
            <li><a href="/movielist/mypage/movierequest"><i class="fa-solid fa-film"></i> 영화 요청</a></li>
        </ul>
    </div>

    <div class="container">
        <div class="content-box">
            <h1>선호 영화관 관리</h1>
            
            <form action="#" method="POST">
                
                <div class="form-group">
                    <label for="cinema-search">영화관 검색/추가</label>
                    <p style="font-size: 12px; color: #888; margin: 0 0 10px;">선호 영화관은 최대 3개까지 설정 가능합니다.</p>
                    
                    <div class="cinema-search-group">
                        <input type="text" id="cinema-search" name="cinemaSearch" placeholder="영화관 이름이나 지역을 검색하세요">
                        <button type="button" onclick="addCinema()">
                            <i class="fa-solid fa-plus"></i> 추가
                        </button>
                    </div>
                </div>

                <div class="form-group">
                    <label>현재 설정된 선호 영화관</label>
                    <ul id="selected-cinemas" class="selected-cinemas">
                        <li>
                            <span>서울강남점</span>
                            <button type="button" class="remove-btn" onclick="removeCinema(this)"><i class="fa-solid fa-xmark"></i></button>
                            <input type="hidden" name="preferredCinemas" value="서울강남점">
                        </li>
                        <li>
                            <span>부산서면점</span>
                            <button type="button" class="remove-btn" onclick="removeCinema(this)"><i class="fa-solid fa-xmark"></i></button>
                            <input type="hidden" name="preferredCinemas" value="부산서면점">
                        </li>
                        </ul>
                </div>

                <button type="submit" class="submit-button">
                    <i class="fa-solid fa-cloud-arrow-up"></i> 선호 영화관 저장
                </button>
            </form>

        </div>
    </div>

    <script>
        const MAX_CINEMAS = 3;
        const selectedList = document.getElementById('selected-cinemas');
        const searchInput = document.getElementById('cinema-search');

        function addCinema() {
            const cinemaName = searchInput.value.trim();
            if (cinemaName === "") {
                alert("영화관 이름을 입력해주세요.");
                return;
            }

            if (selectedList.children.length >= MAX_CINEMAS) {
                alert(`선호 영화관은 최대 ${MAX_CINEMAS}개까지 설정 가능합니다.`);
                return;
            }

            // 중복 확인 로직 (프론트엔드 예시)
            let isDuplicate = false;
            selectedList.querySelectorAll('span').forEach(span => {
                if (span.textContent === cinemaName) {
                    isDuplicate = true;
                }
            });

            if (isDuplicate) {
                alert("이미 추가된 영화관입니다.");
                return;
            }

            const listItem = document.createElement('li');
            listItem.innerHTML = `
                <span>${cinemaName}</span>
                <button type="button" class="remove-btn" onclick="removeCinema(this)"><i class="fa-solid fa-xmark"></i></button>
                <input type="hidden" name="preferredCinemas" value="${cinemaName}">
            `;
            selectedList.appendChild(listItem);
            searchInput.value = '';
        }

        function removeCinema(buttonElement) {
            buttonElement.closest('li').remove();
        }
    </script>
</body>
</html>