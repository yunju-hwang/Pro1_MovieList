<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 | 관심 영화 목록</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
        /* ========================================================== */
        /* 1. 전역 스타일 및 NAV BAR 스타일 */
        /* ========================================================== */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f7f7; /* 배경색을 이미지에 맞게 밝게 조정 */
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

        /* 🚨 관심 목록 메뉴를 활성화합니다. */
        .header-nav li.active {
            color: #ff4d4d; 
            border-bottom: 3px solid #ff4d4d; 
            font-weight: bold;
        }

        .header-nav li i {
            margin-right: 5px;
        }
        
        /* ========================================================== */
        /* 2. 메인 컨텐츠 스타일 */
        /* ========================================================== */

        /* 메인 컨테이너 및 콘텐츠 박스 */
        .container {
            padding: 40px 20px;
            width: 100%;
            max-width: 1200px; /* 영화 카드 4개 배치를 위해 너비 확장 */
            margin: 40px auto; 
        }

        .content-box {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); 
        }

        /* 제목 스타일 */
        .content-box h1 {
            text-align: center;
            margin-bottom: 10px;
            font-size: 28px;
            color: #333;
        }
        
        /* 총 개수 표시 부제 스타일 */
        .content-box p.count {
            text-align: center;
            margin-bottom: 30px;
            color: #777;
            font-size: 16px;
        }

        /* 🚨 영화 목록 컨테이너 (Flexbox를 사용하여 4열 배치) */
        .movie-list-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: flex-start;
        }

        /* 🚨 영화 카드 스타일 */
        .movie-card {
            width: calc(25% - 15px); /* 4열 배치 */
            min-width: 250px;
            border: 1px solid #eee;
            border-radius: 6px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            box-sizing: border-box;
            background-color: #fff;
        }
        
        /* 임시 이미지 플레이스홀더 */
        .poster {
            height: 350px; /* 포스터 높이 지정 */
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            color: #aaa;
            position: relative;
        }
        
        /* 19세 관람가 임시 마크 */
        .rate-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #ff4d4d;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }

        .card-content {
            padding: 15px;
        }
        
        .card-content h3 {
            margin: 0 0 5px 0;
            font-size: 18px;
            color: #333;
        }

        /* 평점 및 시간 정보 */
        .movie-info {
            font-size: 13px;
            color: #777;
            margin-bottom: 10px;
        }

        /* 상세 설명 */
        .movie-description {
            font-size: 13px;
            color: #555;
            margin-bottom: 15px;
            line-height: 1.4;
            height: 40px; /* 2줄 정도의 높이 */
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* 버튼 영역 */
        .card-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 10px;
            border-top: 1px solid #eee;
        }

        .action-button {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #fff;
            color: #555;
            cursor: pointer;
            transition: background-color 0.2s;
            font-size: 13px;
        }

        .action-button:hover {
            background-color: #f0f0f0;
        }

        .reservation-button {
            background-color: #ff4d4d;
            border: 1px solid #ff4d4d;
            color: white;
            font-weight: bold;
        }
        
        .reservation-button:hover {
            background-color: #e63939;
        }

        /* 리브작성/예매하기 버튼 스타일링 (이미지와 유사하게) */
        .action-button-group {
            display: flex;
            gap: 10px;
        }
        
        /* 리뷰바 스타일 */
        .review-bar-container {
            margin-bottom: 15px;
        }

        .review-bar {
            height: 10px;
            background-color: #ff4d4d;
            width: 95%; /* 95% 긍정리뷰 예시 */
            border-radius: 5px;
            margin-top: 5px;
        }
        
        .review-label {
            font-size: 12px;
            color: #ff4d4d;
            font-weight: bold;
        }

    </style>
</head>
<body>
    
    <div class="header-nav">
        <ul>
            <li><a href="/movielist/mypage/reservations"><i class="fa-solid fa-calendar-check"></i> 예매 내역</a></li>
            <li class="active"><a href="/movielist/mypage/favorites"><i class="fa-regular fa-heart"></i> 관심 목록</a></li>
            <li><a href="/movielist/mypage/profile"><i class="fa-regular fa-user"></i> 회원 정보</a></li>
            <li><a href="/movielist/mypage/theaters"><i class="fa-solid fa-map-pin"></i> 선호 영화관</a></li>
            <li><a href="/movielist/mypage/paymentmethod"><i class="fa-solid fa-credit-card"></i> 결제 수단</a></li>
            <li><a href="/movielist/mypage/inquiries"><i class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
            <li><a href="/movielist/mypage/movierequest"><i class="fa-solid fa-film"></i> 영화 요청</a></li>
        </ul>
    </div>

    <div class="container">
        <div class="content-box">
            <h1>관심 영화</h1>
            <p class="count">총 ${favoriteList.size()}개의 영화</p>

            <div class="movie-list-container">
                
            <c:choose>
                    <c:when test="${not empty favoriteList}">
                        <c:forEach var="movie" items="${favoriteList}">
                            <div class="movie-card">
                                <div class="poster">
                                    <c:if test="${movie.ageRating eq '19'}"><div class="rate-badge">19금</div></c:if>
                                </div>
                                <div class="card-content">
                                    <h3>${movie.title}</h3>
                                    <div class="movie-info">⭐ ${movie.rating} | ${movie.runningTime}분</div>
                                    <div class="movie-description">
                                        ${movie.description}
                                    </div>
                                    <div class="review-bar-container">
                                        <div class="review-label">긍정리뷰 ${movie.positiveReviewRate}%</div>
                                        <div class="review-bar" style="width: ${movie.positiveReviewRate}%;"></div>
                                    </div>
                                    <div class="action-button-group">
                                        <button class="action-button">리뷰 작성</button>
                                        <button class="action-button reservation-button">예매하기</button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="width: 100%; text-align: center; padding: 50px; color: #888; border: 1px dashed #ddd; border-radius: 4px;">
                            <i class="fa-regular fa-heart fa-2x" style="margin-bottom: 10px;"></i>
                            <p>관심 영화 목록이 비어있습니다. 좋아하는 영화를 추가해 보세요!</p>
                        </div>
                    </c:otherwise>
                </c:choose>    
                
            </div>
        </div>
    </div>
</body>
</html>