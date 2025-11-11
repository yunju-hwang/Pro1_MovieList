<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 | 예매 내역</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        
    <style>
        /* 💡 기존 CSS 스타일 유지 및 필요한 부분만 수정 */
        
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f7f7;
            min-height: 100vh;
        }

        /* 1. NAV BAR 스타일 */
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
        
        /* 🚨 예매 내역 메뉴를 활성화합니다. (CSS 수정 필요) */
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

        .header-nav li.active {
            color: #ff4d4d; 
            border-bottom: 3px solid #ff4d4d; 
            font-weight: bold;
        }

        .header-nav li i {
            margin-right: 5px;
        }
        
        /* 2. 메인 컨텐츠 스타일 */
        .container {
            padding: 40px 20px;
            width: 100%;
            max-width: 900px; /* 예매 목록에 맞게 너비 확장 */
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
        /* 3. 예매 내역 목록 전용 스타일 */
        /* ========================================================== */
        .reservation-item {
            display: flex;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 20px;
            overflow: hidden;
            transition: box-shadow 0.2s;
        }

        .reservation-item:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .movie-poster {
            width: 150px;
            flex-shrink: 0;
            background-color: #333; /* 포스터 대체 색상 */
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 14px;
        }

        .movie-poster img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .reservation-info {
            flex-grow: 1;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .reservation-info h2 {
            margin-top: 0;
            font-size: 20px;
            color: #333;
            margin-bottom: 5px;
        }

        .info-row {
            font-size: 14px;
            color: #555;
            margin-bottom: 5px;
        }

        .info-row strong {
            color: #000;
            font-weight: bold;
            margin-right: 5px;
        }

        .reservation-actions {
            display: flex;
            gap: 10px;
            padding-top: 15px;
            border-top: 1px solid #eee;
            margin-top: 15px;
        }

        .action-button {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.2s;
        }

        .detail-btn {
            background-color: #ff4d4d;
            color: white;
        }

        .detail-btn:hover {
            background-color: #e63939;
        }

        .cancel-btn {
            background-color: #f0ad4e;
            color: white;
        }

        .cancel-btn:hover {
            background-color: #ec971f;
        }

    </style>
</head>
<body>
    
    <div class="header-nav">
        <ul>
            <li class="active"><a href="/movielist/mypage/reservations"><i class="fa-solid fa-calendar-check"></i> 예매 내역</a></li>
            <li><a href="/movielist/mypage/favorites"><i class="fa-regular fa-heart"></i> 관심 목록</a></li>
            <li><a href="/movielist/mypage/profile"><i class="fa-regular fa-user"></i> 회원 정보</a></li>
            <li><a href="/movielist/mypage/theaters"><i class="fa-solid fa-map-pin"></i> 선호 영화관</a></li>
            <li><a href="/movielist/mypage/paymentmethod"><i class="fa-solid fa-credit-card"></i> 결제 수단</a></li>
            <li><a href="/movielist/mypage/inquiries"><i class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
            <li><a href="/movielist/mypage/movierequest"><i class="fa-solid fa-film"></i> 영화 요청</a></li>
        </ul>
    </div>

    <div class="container">
    <div class="content-box">
        <h1>예매 내역 관리</h1>
        
        <div id="reservation-list">
            
            <%--
            <c:choose>
                <c:when test="${not empty reservationList}">
                    <c:forEach var="reservation" items="${reservationList}">
                        <div class="reservation-item">
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
            --%>
            
            <div class="no-reservations">
<!--                 <i class="fa-solid fa-ticket fa-2x" style="margin-bottom: 10px;"></i> -->
                <p>예매 내역이 없습니다.</p>
            </div>
            
        </div>
    </div>
</div>

    <script>
        function showDetail(reservationId) {
            alert(`예매 번호 ${reservationId}의 상세 정보를 표시합니다.`);
            // 실제 구현: /mypage/reservation/detail?id=R1234567 로 이동
        }

        // 취소 버튼 클릭 시 경고 메시지
        document.querySelectorAll('.cancel-btn:not([disabled])').forEach(button => {
            button.addEventListener('click', (e) => {
                const item = e.target.closest('.reservation-item');
                const title = item.querySelector('h2').textContent;
                if (confirm(`'${title}' 예매를 정말로 취소하시겠습니까?`)) {
                    // 실제 구현: 서버로 취소 요청(AJAX 또는 폼 제출)
                    alert("취소 요청이 접수되었습니다. (실제 기능은 서버에서 처리됩니다.)");
                }
            });
        });
    </script>
</body>
</html>