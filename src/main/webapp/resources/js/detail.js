document.addEventListener("DOMContentLoaded", () => {
    const detailDiv = document.getElementById("movie-detail");

    if (!tmdbId) {
        detailDiv.innerHTML = "<p>영화 정보를 불러올 수 없습니다.</p>";
        return;
    }

    fetch(`${ctx}/movies/detail?tmdbId=${tmdbId}`)
        .then(res => {
            if (!res.ok) throw new Error(`HTTP error! status: ${res.status}`);
            return res.json();
        })
        .then(movie => {
        	console.log("🎬 movie 객체:", movie);
            const posterUrl = movie.posterPath
                ? `https://image.tmdb.org/t/p/w400${movie.posterPath}`
                : `${ctx}/resources/images/default_poster.png`;

            const genreHtml = movie.genres && movie.genres.length > 0
                ? movie.genres.join(', ')
                : '정보 없음';

            const runtime = movie.runtime !== null ? `${movie.runtime}분` : "정보 없음";
            const popularity = movie.popularity ? `❤️ ${Math.round(movie.popularity)}` : "❤️ 0";

            // HTML 구성
            detailDiv.innerHTML = `
                <div class="detail-container">
                    <div class="left-box">
                        <div class="poster-wrapper">
                            <img class="poster" src="${posterUrl}" alt="${movie.title}">
                            <button class="wish-btn" id="wishBtn">
                                <span class="heart-icon" id="heartIcon">${movie.favorite ? '❤️' : '♡'}</span>
                            </button>
                        </div>
                        <div class="popularity-box">
                            
                        </div>
                    </div>
                    <div class="right-box">
                        <h1 class="movie-title">${movie.title}</h1>
                        <div class="meta">
                            <span><strong>상영시간:</strong> ${runtime}</span>
                        </div>
                        <p><strong>개봉일:</strong> ${movie.releaseDate || '정보 없음'}</p>
                        <p><strong>장르:</strong> ${genreHtml}</p>
                        <p class="overview">${movie.overview || '정보 없음'}</p>
                        <button class="wish-btn-reserve" id="reserveBtn">🎬 예매하기</button>
                    </div>
                </div>

                <div class="review-section">
                    <h2>리뷰</h2>
                    <div class="review-list">
                        <div class="review-item">
                            <strong>테스트 사용자</strong>
                            <p>영화 너무 좋았습니다!</p>
                        </div>
                    </div>
                    <div class="my-review">
                        <div class="star-rating" id="starRating"></div>
                        <textarea placeholder="리뷰를 작성해주세요"></textarea>
                        <button class="submit-review" id="submitReview">등록</button>
                    </div>
                </div>
            `;

            // ✅ 찜 버튼 서버 연동
            const heartIcon = document.getElementById("heartIcon");
            const wishBtn = document.getElementById("wishBtn");
            const detailContainer = detailDiv.querySelector(".detail-container");
           

            wishBtn.addEventListener("click", (e) => {
            	e.stopPropagation();
              
                

                if (!isLogin) {
                    alert("로그인이 필요한 서비스입니다.");
                    return;
                }
                
               

                fetch(`${ctx}/movies/favorite/${tmdbId}`, {
                    method: "POST",
                    headers: { "Content-Type": "application/json" }
                })
                .then(res => {
                    if (!res.ok) throw new Error("찜 업데이트 실패");
                    return res.json();
                })
                .then(data => {
                    if (data.success) {
                        // 서버에서 받은 favorite 상태 사용
                        const current = detailContainer.dataset.favorite === 'true';
                        const next = data.isFavorite !== undefined ? data.isFavorite : !current;
            
                        console.log(next);
                        heartIcon.textContent = next  ? '❤️' : '♡';
                        detailContainer.dataset.favorite = next;
                        
                        const popularityBox = detailContainer.querySelector(".left-box .popularity-box strong");
                        popularityBox.textContent = `❤️ ${Math.round(data.popularity)}`;
                    } else {
                        alert("찜 기능을 사용할 수 없습니다.");
                    }
                })
                .catch(err => console.error(err));
            });

            // ✅ 예매하기 버튼
            const reserveBtn = document.getElementById("reserveBtn");
            reserveBtn.addEventListener("click", () => {
                if (!isLogin) {
                    alert("로그인이 필요한 서비스입니다");
                    return;
                }
                const tmdbId = movie.tmdbId;
                const title = movie.title;
                const url = `${ctx}/reservation/info?tmdbId=${tmdbId}&title=${encodeURIComponent(title)}`;
                console.log("➡ 이동 URL:", url); // ✅ 실제 URL 출력
    			window.location.href = url;
            });

            // ⭐ 별점 기능
            const starContainer = document.getElementById("starRating");
            const stars = [];
            let selectedRating = 0;

            for (let i = 1; i <= 5; i++) {
                const star = document.createElement("span");
                star.classList.add("star");
                star.dataset.value = i;
                star.textContent = '☆';
                star.style.fontSize = "24px";
                star.style.cursor = "pointer";
                star.style.marginRight = "5px";
                starContainer.appendChild(star);
                stars.push(star);

                star.addEventListener("mouseover", () => fillStars(i));
                star.addEventListener("mouseout", () => fillStars(selectedRating));
                star.addEventListener("click", () => {
                    selectedRating = i;
                    fillStars(selectedRating);
                });
            }

            function fillStars(rating) {
                stars.forEach((star, index) => {
                    star.textContent = index < rating ? '★' : '☆';
                    star.style.color = index < rating ? '#FFD700' : '#ccc';
                });
            }

            // ✅ 리뷰 등록 버튼
            const submitBtn = document.getElementById("submitReview");
            submitBtn.addEventListener("click", () => {
                const reviewText = document.querySelector(".my-review textarea").value.trim();
                if (!sessionUser) {
                    alert("로그인이 필요한 서비스입니다");
                    return;
                }
                if (!reviewText || selectedRating === 0) {
                    alert("리뷰 내용과 별점을 모두 입력해주세요");
                    return;
                }
                // TODO: AJAX로 서버에 리뷰 등록
                alert(`별점: ${selectedRating}, 리뷰: ${reviewText}`);
            });

        })
        .catch(err => {
            console.error(err);
            detailDiv.innerHTML = "<p>영화 정보를 불러올 수 없습니다.</p>";
        });
});
