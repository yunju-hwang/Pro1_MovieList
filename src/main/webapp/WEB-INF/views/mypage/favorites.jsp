<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 | 관심 영화 목록</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
	padding: 12px 20px;
	font-size: 14px;
	color: #555;
	cursor: pointer;
	transition: color 0.3s, background-color 0.3s; /* 배경색 전환 효과 추가 */
	border-bottom: none; /* 기존 밑줄 효과 제거 */
	border-radius: 4px; /* 버튼처럼 보이도록 모서리 둥글게 처리 */
	margin: 0 7px; /* 버튼 간격 추가 */
}

.header-nav li:hover {
	color: white; /* 글자색을 흰색으로 변경 */
	background-color: #cd0000; /* 배경색을 빨간색으로 변경 */
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
	color: white; /* 활성 메뉴의 글자색을 흰색으로 변경 */
	background-color: #cd0000; /* 활성 메뉴의 배경색을 빨간색으로 변경 */
	border-bottom: none; /* 기존 밑줄 효과 제거 */
	font-weight: bold;
}

/* 🚨 활성화된 메뉴에 마우스를 올릴 때 (미묘한 색상 차이로 구분) */
.header-nav li.active:hover {
	background-color: #a00000; /* 활성 버튼 위에 hover 시 더 어두운 빨간색으로 변경 */
	color: white;
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
	max-width: 1690px; /* 영화 카드 4개 배치를 위해 너비 확장 */
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

#movie-list {
	display: flex;
	flex-wrap: wrap; /* ✅ 줄바꿈 발생 */
	gap: 20px; /* 카드 사이 간격 */
	justify-content: center;
	padding: 20px;
}

/* 🚨 영화 목록 컨테이너 (Flexbox를 사용하여 4열 배치) */
.movie-list-container {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	/* 	justify-content: flex-start; */
	/* 	padding-top: 20px; */
}

/* 🚨 영화 카드 스타일 */
.movie-card {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	width: 230px;
	background: white;
	padding: 10px;
	border-radius: 10px;
	box-shadow: 0 3px 8px rgba(0, 0, 0, 0.2);
	cursor: pointer;
}

/* 임시 이미지 플레이스홀더 */
.poster {
	width: 100%; /* 카드 너비에 맞춤 */
	border-radius: 8px;
	/* 	overflow: hidden; */
	/* 	position: relative; */
}

.favorite-btn {
	background: none;
	border: none;
	font-size: 18px; /* 🚨 이전에 20px였는데 18px로 변경됨 */
	cursor: pointer;
	color: #cd0000;
	margin-left: 5px;
	transition: transform 0.2s;
}

.favorite-btn:hover {
	transform: scale(1.2);
}

.title {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 5px;
}

.date {
	font-size: 14px;
	color: #555;
}

.overview {
	font-size: 13px;
	margin-top: 8px;
	color: #333;
}

.genres {
	display: flex; /* 태그를 가로로 나열 */
	flex-wrap: wrap; /* 여러 줄 가능 */
	justify-content: flex-start; /* 왼쪽 정렬 */
	margin-top: 5px;
}

.genre-tag {
	display: inline-block;
	background: #ffdddd;
	color: #333;
	padding: 4px 8px;
	margin: 2px;
	border-radius: 8px;
	font-size: 12px;
}

/* 🚨 포스터 이미지 스타일 */
.movie-poster {
	width: 100%;
	height: auto; /* 부모 div.poster의 높이에 꽉 차도록 설정 */
	display: block;
	object-fit: cover; /* 이미지가 잘리지 않게 채우도록 설정 (중요) */
	border-radius: 8px;
}

.card-content {
	padding: 10px 0 0 0;
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
	height: 90px; /* 2줄 정도의 높이 */
	overflow: hidden;
	display: -webkit-box;
	-webkit-line-clamp: 5; /* 5줄까지만 표시 */
	-webkit-box-orient: vertical;
}

.action-button {
	/* 새로운 디자인 스타일 적용 */
	flex: 1; /* 버튼 동일 너비 */
	text-align: center;
	background-color: #cd0000;
	color: #fff;
	text-decoration: none;
	padding: 8px 0;
	border-radius: 12px; /* 둥근 모양 */
	font-weight: bold;
	font-size: 14px;
	border: none; /* button의 기본 테두리 제거 */
	cursor: pointer;
	transition: background 0.3s, transform 0.2s;
}

.action-button:hover {
	background-color: #a80000; /* hover 시 진한 빨강 */
	transform: translateY(-2px); /* 살짝 뜨는 느낌 */
}

.action-button-group {
	display: flex;
	gap: 10px; /* 버튼 간격 */
	margin-top: 10px; /* 카드 콘텐츠와의 간격 확보 */
	padding-top: 10px;
	border-top: 1px solid #eee;
}
</style>
</head>
<body>

	<div id="movie-list" data-ctx="${ctx}"
		data-islogin="<c:out value='${not empty sessionScope.loginUser}' default='false'/>"></div>

	<div class="header-nav">
		<ul>
			<li><a href="/movielist/mypage/reservations"><i
					class="fa-solid fa-calendar-check"></i> 예매 내역</a></li>
			<li class="active"><a href="/movielist/mypage/favorites"><i
					class="fa-regular fa-heart"></i> 관심 목록</a></li>
			<li><a href="/movielist/mypage/profile"><i
					class="fa-regular fa-user"></i> 회원 정보</a></li>
			<li><a href="/movielist/mypage/theaters"><i
					class="fa-solid fa-map-pin"></i> 선호 영화관</a></li>
			<li><a href="/movielist/mypage/paymentmethod"><i
					class="fa-solid fa-credit-card"></i> 결제 수단</a></li>
			<li><a href="/movielist/mypage/inquiries"><i
					class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
			<li><a href="/movielist/mypage/movierequest"><i
					class="fa-solid fa-film"></i> 영화 요청</a></li>
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
									<img class="movie-poster"
										src="https://image.tmdb.org/t/p/w300${movie.poster_path}"
										alt="${movie.movie_title} 포스터" />

								</div>
								<div class="card-content">
									<div class="title">
										<h3>${movie.movie_title}</h3>
										<button class="favorite-btn btn-unfavorite"
											data-tmdb-id="${movie.tmdbId}">
											<i class="fa-solid fa-heart"></i>
										</button>
									</div>

									<div class="movie-info">${movie.runtime}분</div>

									<div class="movie-description">${movie.overview}</div>
<!-- 									<div class="genres"> -->
<%-- 										<c:forEach var="genre" items="${movie.genres}"> --%>
<%-- 											<span class="genre-tag">${genre.name}</span> --%>
<%-- 										</c:forEach> --%>
<!-- 									</div> -->
									<div class="action-button-group">
										<button class="action-button">예매하기</button>
										<button class="action-button">리뷰 작성</button>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div
							style="width: 100%; text-align: center; padding: 50px; color: #888; border: 1px dashed #ddd; border-radius: 4px;">
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