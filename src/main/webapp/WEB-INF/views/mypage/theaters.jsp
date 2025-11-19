<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 | 선호 영화관</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
	transition: color 0.3s, background-color 0.3s;
	border-bottom: none;
	border-radius: 4px;
	margin: 0 7px;
}

.header-nav li:hover {
	color: white;
	background-color: #cd0000;
}

.header-nav li a {
	text-decoration: none;
	color: inherit;
	display: flex;
	align-items: center;
}

.header-nav li.active {
	color: white;
	background-color: #cd0000;
	border-bottom: none;
	font-weight: bold;
}

.header-nav li.active:hover {
	background-color: #a00000;
	color: white;
}

.header-nav li i {
	margin-right: 5px;
}

.container {
	padding: 40px 20px;
	width: 100%;
	max-width: 600px;
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

.cinema-search-group {
	display: flex;
	align-items: flex-start;
	gap: 10px;
	margin-bottom: 10px;
}

.search-input-wrapper {
	flex-grow: 1;
	position: relative;
}

.btn-search-icon {
	position: absolute;
	left: 1px;
	top: 1px;
	height: calc(100% - 2px);
	background-color: transparent;
	color: #888;
	border: none;
	padding: 0 15px;
	border-radius: 4px 0 0 4px;
	cursor: pointer;
	font-size: 15px;
	transition: color 0.2s;
	display: flex;
	align-items: center;
	justify-content: center;
	line-height: 1;
	z-index: 10;
}

.btn-search-icon:hover {
	color: #555;
}

.cinema-search-group input[type="text"] {
	width: 100%;
	padding: 12px;
	padding-left: 50px;
	padding-right: 12px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 15px;
	box-sizing: border-box;
	margin-bottom: 0;
}

.cinema-search-group button.btn-add {
	background-color: #cd0000;
	color: white;
	border: none;
	padding: 12px 15px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 15px;
	transition: background-color 0.2s;
	flex-shrink: 0;
	line-height: 1;
	margin-top: 1px;
}

.cinema-search-group button.btn-add:hover {
	background-color: #a00000;
}

.search-results {
	position: absolute;
	top: 100%;
	left: 0;
	right: 0;
	z-index: 50;
	background-color: white;
	border: 1px solid #ddd;
	border-top: none;
	border-radius: 0 0 4px 4px;
	max-height: 200px;
	overflow-y: auto;
	list-style: none;
	padding: 0;
	margin: 0;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	display: none;
}

.search-results li {
	padding: 10px 15px;
	cursor: pointer;
	border-bottom: 1px solid #eee;
	font-size: 15px;
}

.search-results li:hover {
	background-color: #f0f0f0;
}

.search-results li:last-child {
	border-bottom: none;
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
	color: #333;
}

.selected-cinemas li.empty-state-message {
	justify-content: center;
	color: #888;
	font-style: italic;
	padding: 15px;
}

.selected-cinemas li span {
	color: #333;
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

.submit-button {
	width: 100%;
	background-color: #cd0000;
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
	background-color: #a00000;
}

.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
	padding-top: 60px;
}

.modal-content {
	background-color: #fefefe;
	margin: 5% auto;
	padding: 30px;
	border: 1px solid #888;
	width: 80%;
	max-width: 500px;
	border-radius: 8px;
	position: relative;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}

.close-btn {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close-btn:hover, .close-btn:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

.modal-content h2 {
	margin-top: 0;
	margin-bottom: 20px;
	color: #333;
	text-align: center;
}

.modal-cinema-list {
	list-style: none;
	padding: 0;
	max-height: 300px;
	overflow-y: auto;
	border: 1px solid #eee;
	border-radius: 4px;
}

.modal-cinema-list li {
	padding: 10px;
	border-bottom: 1px solid #eee;
	cursor: pointer;
	transition: background-color 0.2s;
	color: #333 !important;
}

.modal-cinema-list li:hover {
	background-color: #f0f0f0;
}

.modal-cinema-list li:last-child {
	border-bottom: none;
}

.modal-confirm-btn {
	width: 100%;
	background-color: #5cb85c;
	color: white;
	border: none;
	padding: 12px;
	border-radius: 4px;
	font-size: 16px;
	margin-top: 15px;
	cursor: pointer;
}
</style>
</head>
<body>

	<div class="header-nav">
		<ul>
			<li><a href="/movielist/mypage/reservations"><i
					class="fa-solid fa-calendar-check"></i> 예매 내역</a></li>
			<li><a href="/movielist/mypage/favorites"><i
					class="fa-regular fa-heart"></i> 관심 목록</a></li>
			<li><a href="/movielist/mypage/profile"><i
					class="fa-regular fa-user"></i> 회원 정보</a></li>
			<li class="active"><a href="/movielist/mypage/theaters"><i
					class="fa-solid fa-map-pin"></i> 선호 영화관</a></li>
			<li><a href="/movielist/mypage/inquiries"><i
					class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
			<li><a href="/movielist/mypage/movierequest"><i
					class="fa-solid fa-film"></i> 영화 요청</a></li>
		</ul>
	</div>

	<div class="container">
		<div class="content-box">

			<h1>선호 영화관 관리</h1>

			<form action="#" method="POST" onsubmit="return false;">

				<div class="form-group">
					<label for="cinema-search">영화관 검색/추가</label>

					<div class="cinema-search-group">

						<div class="search-input-wrapper">

							<button type="button" class="btn-search-icon">
								<i class="fa-solid fa-magnifying-glass"></i>
							</button>

							<input type="text" id="cinema-search" name="cinemaSearch"
								placeholder="영화관을 검색하면 자동 완성됩니다" autocomplete="off">
							<ul id="search-results" class="search-results">
								</ul>

						</div>

						<button type="button" class="btn-add" id="btn-open-modal">
							<i class="fa-solid fa-plus"></i>
						</button>
					</div>
				</div>

				<div class="form-group">
					<label>현재 설정된 선호 영화관</label>
					<ul id="selected-cinemas" class="selected-cinemas">
						<li class="empty-state-message">선호 영화관이 없습니다</li>
					</ul>
				</div>

				<button type="submit" class="submit-button">
					<i class="fa-solid fa-cloud-arrow-up"></i> 선호 영화관 저장
				</button>
			</form>

		</div>
	</div>

	<div id="cinema-modal" class="modal">
		<div class="modal-content">
			<span class="close-btn" id="modal-close-btn">&times;</span>
			<h2>전체 상영관 목록</h2>

			<ul class="modal-cinema-list" id="modal-cinema-list">
				</ul>

			<button type="button" class="modal-confirm-btn" id="modal-close-footer-btn">닫기</button>
		</div>
	</div>

</body>
</html>