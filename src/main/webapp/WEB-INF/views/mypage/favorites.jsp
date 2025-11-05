<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
  font-family: 'Pretendard', sans-serif;
  background-color: #ffeef0;
  margin: 0;
  padding: 0;
  color: #333;
}

/* (1) 상단 네비게이션 */
.nav-bar {
  background: #fff;
  display: flex;
  justify-content: center;
  border-bottom: 1px solid #ddd;
}

.nav-bar ul {
  display: flex;
  list-style: none;
  padding: 0;
  margin: 0;
}

.nav-bar li a {
  display: block;
  padding: 14px 20px;
  color: #333;
  text-decoration: none;
  border-radius: 5px;
  font-weight: 500;
}

.nav-bar li a.active {
  background-color: #e60023;
  color: #fff;
}

/* (2) 관심영화 섹션 */
.favorite-section {
  text-align: center;
  margin: 40px auto;
  width: 90%;
  max-width: 1200px;
}

.favorite-section h2 {
  font-size: 24px;
  margin-bottom: 5px;
}

.movie-count {
  color: #777;
  margin-bottom: 30px;
}

/* (3) 영화 카드 레이아웃 */
.movie-list {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 20px;
}

.movie-card {
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  width: 250px;
  overflow: hidden;
  transition: transform 0.2s;
}

.movie-card:hover {
  transform: translateY(-5px);
}

.movie-card img {
  width: 100%;
  height: 150px;
  object-fit: cover;
}

.movie-info {
  padding: 15px;
}

.movie-info h3 {
  margin: 0 0 5px;
  font-size: 18px;
}

.movie-info .movie-desc {
  font-size: 14px;
  color: #555;
  margin-bottom: 10px;
}

.rating {
  font-size: 13px;
  color: #888;
}

.movie-actions {
  display: flex;
  justify-content: space-around;
  padding: 10px 0 15px;
}

.review-btn,
.book-btn {
  border: none;
  padding: 8px 12px;
  border-radius: 5px;
  cursor: pointer;
  font-weight: bold;
}

.review-btn {
  background: #eee;
  color: #333;
}

.book-btn {
  background: #e60023;
  color: #fff;
}

.book-btn:hover {
  background: #c5001f;
}

</style>
</head>
<body>
	<h1>마이페이지/관심영화</h1>
	<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>관심 영화 목록</title>
  <link rel="stylesheet" href="style.css" />
</head>
<body>

  <!-- (1) 상단 메뉴 -->
  <nav class="nav-bar">
    <ul>
      <li><a href="#">예매 내역</a></li>
      <li><a href="#" class="active">관심 목록</a></li>
      <li><a href="#">회원 정보</a></li>
      <li><a href="#">선호 영화관</a></li>
      <li><a href="#">결제 수단</a></li>
      <li><a href="#">문의 내역</a></li>
      <li><a href="#">영화 요청</a></li>
    </ul>
  </nav>

  <!-- (2) 관심 영화 섹션 -->
  <section class="favorite-section">
    <h2>관심영화</h2>
    <p class="movie-count">총 4개의 영화</p>

    <!-- (3) 영화 카드 리스트 -->
    <div class="movie-list">
      <div class="movie-card">
        <img src="titanic.jpg" alt="타이타닉 포스터" />
        <div class="movie-info">
          <h3>타이타닉</h3>
          <p class="movie-desc">
            1912년, 세기의 비극적 멜로를 그린 타이타닉의 선상 이야기.
          </p>
          <p class="rating">관람평점: 95%</p>
        </div>
        <div class="movie-actions">
          <button class="review-btn">리뷰작성</button>
          <button class="book-btn">예매하기</button>
        </div>
      </div>

      <!-- 동일한 형식의 카드 복제 -->
      <div class="movie-card">
        <img src="titanic.jpg" alt="타이타닉 포스터" />
        <div class="movie-info">
          <h3>타이타닉</h3>
          <p class="movie-desc">1912년, 세기의 비극적 멜로를 그린 타이타닉의 선상 이야기.</p>
          <p class="rating">관람평점: 95%</p>
        </div>
        <div class="movie-actions">
          <button class="review-btn">리뷰작성</button>
          <button class="book-btn">예매하기</button>
        </div>
      </div>

      <div class="movie-card">
        <img src="titanic.jpg" alt="타이타닉 포스터" />
        <div class="movie-info">
          <h3>타이타닉</h3>
          <p class="movie-desc">1912년, 세기의 비극적 멜로를 그린 타이타닉의 선상 이야기.</p>
          <p class="rating">관람평점: 95%</p>
        </div>
        <div class="movie-actions">
          <button class="review-btn">리뷰작성</button>
          <button class="book-btn">예매하기</button>
        </div>
      </div>

      <div class="movie-card">
        <img src="titanic.jpg" alt="타이타닉 포스터" />
        <div class="movie-info">
          <h3>타이타닉</h3>
          <p class="movie-desc">1912년, 세기의 비극적 멜로를 그린 타이타닉의 선상 이야기.</p>
          <p class="rating">관람평점: 95%</p>
        </div>
        <div class="movie-actions">
          <button class="review-btn">리뷰작성</button>
          <button class="book-btn">예매하기</button>
        </div>
      </div>
    </div>
  </section>

</body>
</html>
	
</body>


</html>