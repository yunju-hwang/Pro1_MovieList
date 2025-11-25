<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 상세 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/detail.css">
</head>
<body>
<div id="movie-detail">
    <div class="detail-container">
        <!-- 왼쪽 박스: 포스터 + 찜하기 버튼 -->
        <div class="left-box">
            <div class="poster-wrapper">
                <img class="poster" src="https://image.tmdb.org/t/p/w400${posterPath}" alt="${title}">
                <button class="wish-btn" id="wishBtn">
                    <span class="heart-icon" id="heartIcon">♡</span>
                </button>
            </div>
           
        </div>

        <!-- 오른쪽 박스: 영화 정보 -->
        <div class="right-box">
            <h1 class="movie-title">${title}</h1>
            <div class="meta">
                <span><strong>상영시간:</strong> ${runtimeText}</span>
            </div>
            <p><strong>개봉일:</strong> ${releaseDate}</p>
            <p><strong>장르:</strong> ${genresText}</p>
            <p class="overview"><strong>개요:</strong> ${overview}</p>
        </div>
    </div>

    <!-- 리뷰 영역 -->
    <div class="review-section">
        <h2>리뷰</h2>
        <div class="review-list">
            
        </div>

        <div class="my-review">
            <div class="star-rating" id="starRating">
               
            </div>
            <textarea placeholder="리뷰를 작성해주세요"></textarea>
            <button class="submit-review" id="submitReview">등록</button>
        </div>
    </div>
</div>

<!-- 필요한 JS는 별도 파일로 -->
<script>
    // 찜하기 버튼
    const heartIcon = document.getElementById("heartIcon");
    document.getElementById("wishBtn").addEventListener("click", () => {
        heartIcon.classList.toggle("active");
        heartIcon.textContent = heartIcon.classList.contains("active") ? '❤️' : '♡';
    });


    // 별점 JS (기본)
    const starContainer = document.getElementById("starRating");
    starContainer.innerHTML = "";
    const stars = [];
    let selectedRating = 0;

    for(let i=1; i<=5; i++){
        const star = document.createElement("span");
        star.textContent = '☆';
        star.style.fontSize = '24px';
        star.style.color = '#ccc';
        star.style.cursor = 'pointer';
        star.style.transition = 'color 0.2s';
        star.dataset.value = i;
        starContainer.appendChild(star);
        stars.push(star);

        // hover
        star.addEventListener("mouseover", () => fillStarsHover(i));
        star.addEventListener("mouseout", () => fillStars(selectedRating));

        // click
        star.addEventListener("click", () => {
            selectedRating = i;
            fillStars(selectedRating);
        });
    }

    function fillStars(rating){
        stars.forEach((star, idx) => {
            star.style.color = idx < rating ? '#FFD700' : '#ccc';
            star.textContent = idx < rating ? '★' : '☆';
        });
    }

    function fillStarsHover(rating){
        stars.forEach((star, idx) => {
            star.style.color = idx < rating ? '#FFD700' : '#ccc';
            star.textContent = idx < rating ? '★' : '☆';
        });
    }

    // 리뷰 등록 버튼
    document.getElementById("submitReview").addEventListener("click", () => {
        const reviewText = document.querySelector(".my-review textarea").value.trim();
        const sessionUser = ${sessionScope.user != null};
        if (!sessionUser) { alert("로그인이 필요한 서비스입니다"); return; }
        if (!reviewText || selectedRating === 0) { alert("리뷰 내용과 별점을 모두 입력해주세요"); return; }
        alert(`별점: ${selectedRating}, 리뷰: ${reviewText}`);
        // TODO: AJAX로 서버에 리뷰 등록
    });
</script>

</body>
</html>