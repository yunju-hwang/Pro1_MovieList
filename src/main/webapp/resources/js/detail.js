document.addEventListener("DOMContentLoaded", () => {
    const detailDiv = document.getElementById("movie-detail");
    const urlParams = new URLSearchParams(window.location.search);
    const tmdbId = urlParams.get("tmdbId");

    if (!tmdbId) {
        detailDiv.innerHTML = "<p>영화 정보를 불러올 수 없습니다.</p>";
        return;
    }

    // 영화 상세 정보 가져오기
    fetch(`${ctx}/movies/detail?tmdbId=${tmdbId}`)
        .then(res => res.json())
        .then(movie => {
            const posterUrl = movie.posterPath
                ? `https://image.tmdb.org/t/p/w400${movie.posterPath}`
                : `${ctx}/resources/images/default_poster.png`;

            const genreHtml = movie.genres && movie.genres.length > 0
                ? movie.genres.join(', ')
                : '정보 없음';

            const runtime = movie.runtime !== null ? `${movie.runtime}분` : "정보 없음";

            // 감독/출연진 가져오기
            fetch(`${ctx}/movies/${tmdbId}/credits`)
                .then(res => res.json())
                .then(credits => {
                    let directorName = "정보 없음";
                    let castList = [];

                    if (credits) {
                        // 감독 찾기
                        if (credits.crew && Array.isArray(credits.crew)) {
                            const director = credits.crew.find(member => member.job === "Director");
                            if (director) directorName = director.name;
                        }

                        // 출연진
                        if (credits.cast && Array.isArray(credits.cast)) {
                            castList = credits.cast; // 배열 그대로 사용
                        }
                    }

                    // 영화 상세 및 크레딧 HTML
                    detailDiv.innerHTML = `
                        <div class="detail-container">
                            <div class="left-box">
                                <div class="poster-wrapper">
                                    <img class="poster" src="${posterUrl}" alt="${movie.title}">
                                    <button class="wish-btn" id="wishBtn">
                                        <span class="heart-icon" id="heartIcon">${movie.favorite ? '❤️' : '♡'}</span>
                                    </button>
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
                        
                        <div class="credit-section">
                            <h2>🎬 감독 & 출연진</h2>
                            <p><strong>감독:</strong> ${directorName}</p>
                            <strong>출연:</strong>
                            <div class="cast-list">
						    ${castList.map(actor => `
						        <div class="cast-card">
						            <img src="${actor.profile_path 
						                         ? `https://image.tmdb.org/t/p/w500${actor.profile_path }` 
						                         : `${ctx}/resources/img/no_img_people.png`}" 
						                 alt="${actor.name}" 
						                 >
						            <p>${actor.name || "이름 없음"}</p>
						            ${actor.role ? `<p class="role">(${actor.role})</p>` : ""}
						        </div>
						    `).join("")}
						</div>
                        </div>

                        <div class="review-section">
                            <h2>리뷰</h2>
                            <div class="my-review">
                                <div class="star-rating" id="starRating"></div>
                                <textarea placeholder="리뷰를 작성해주세요"></textarea>
                                <button class="submit-review" id="submitReview">등록</button>
                            </div>
                            <div class="review-list">
                                <p>리뷰 불러오는 중...</p>
                            </div>
                            <div class="pagination"></div>
                        </div>
                    `;

                    // 찜, 예매, 별점, 리뷰 관련 이벤트 바인딩
                    bindDetailEvents(movie, tmdbId);
                    loadReviewList(1, tmdbId);
                });
        })
        .catch(err => { 
            console.error(err); 
            detailDiv.innerHTML = "<p>영화 정보를 불러올 수 없습니다.</p>"; 
        });

    // 이벤트 바인딩 함수
    function bindDetailEvents(movie, tmdbId) {
        const heartIcon = document.getElementById("heartIcon");
        const wishBtn = document.getElementById("wishBtn");
        const detailContainer = document.querySelector(".detail-container");

        // 찜 버튼
        wishBtn.addEventListener("click", e => {
            e.stopPropagation();
            if (!isLogin) { alert("로그인이 필요한 서비스입니다."); return; }

            fetch(`${ctx}/movies/favorite/${tmdbId}`, { method: "POST", headers: { "Content-Type": "application/json" } })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        const current = detailContainer.dataset.favorite === 'true';
                        const next = data.isFavorite !== undefined ? data.isFavorite : !current;
                        heartIcon.textContent = next ? '❤️' : '♡';
                        detailContainer.dataset.favorite = next;
                    } else alert("찜 기능을 사용할 수 없습니다.");
                });
        });

        // 예매 버튼
        const reserveBtn = document.getElementById("reserveBtn");
        reserveBtn.addEventListener("click", () => {
            if (!isLogin) { alert("로그인이 필요한 서비스입니다"); return; }
            const url = `${ctx}/reservation/info?tmdbId=${tmdbId}&title=${encodeURIComponent(movie.title)}`;
            window.location.href = url;
        });

        // 별점
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
            star.addEventListener("click", () => { selectedRating = i; fillStars(selectedRating); });
        }

        function fillStars(rating) {
            stars.forEach((star, idx) => {
                star.textContent = idx < rating ? '★' : '☆';
                star.style.color = idx < rating ? '#FFD700' : '#ccc';
            });
        }

        // 리뷰 등록
        const submitBtn = document.getElementById("submitReview");
        submitBtn.addEventListener("click", () => {
            const reviewText = document.querySelector(".my-review textarea").value.trim();
            const userId = localStorage.getItem("userId");

            if (!isLogin) { alert("로그인이 필요한 서비스입니다"); return; }
            if (!reviewText || selectedRating === 0) { alert("내용과 별점을 모두 입력해주세요"); return; }

            fetch(`${ctx}/movies/review_write`, {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: new URLSearchParams({
                    tmdbId,
                    userId,
                    content: reviewText,
                    rating: selectedRating
                })
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    alert("리뷰가 등록되었습니다!");
                    document.querySelector(".my-review textarea").value = "";
                    selectedRating = 0;
                    fillStars(selectedRating);
                    loadReviewList(1, tmdbId);
                } else alert(data.message);
            });
        });
    }

    // 리뷰 리스트 로딩
    function loadReviewList(page = 1, tmdbId) {
        const pageSize = 10;
        const reviewListDiv = document.querySelector(".review-list");
        reviewListDiv.innerHTML = "리뷰 불러오는 중...";

        const userId = localStorage.getItem("userId");

        fetch(`${ctx}/movies/review_list?tmdbId=${tmdbId}&userId=${userId}&page=${page}&size=${pageSize}`)
            .then(res => res.json())
            .then(data => {
                const reviews = data.reviews || [];
                const totalReviews = data.total || reviews.length;
                reviewListDiv.innerHTML = "";

                if (reviews.length === 0) {
                    reviewListDiv.innerHTML = "<p>등록된 리뷰가 없습니다.</p>";
                    renderPagination(0, 1, tmdbId);
                    return;
                }

                reviews.sort((a, b) => {
                    if (a.userId === userId) return -1;
                    if (b.userId === userId) return 1;
                    return 0;
                });

                reviews.forEach(review => {
                    const reviewItem = document.createElement("div");
                    reviewItem.classList.add("review-item");
                    reviewItem.dataset.reviewId = review.id;
                    reviewItem.dataset.userId = review.userId;

                    let createdAtStr = '';
                    if (review.createdAt) {
                        const dateObj = new Date(review.createdAt);
                        if (!isNaN(dateObj.getTime())) {
                            const year = dateObj.getFullYear();
                            const month = String(dateObj.getMonth() + 1).padStart(2, '0');
                            const day = String(dateObj.getDate()).padStart(2, '0');
                            const hours = String(dateObj.getHours()).padStart(2, '0');
                            const minutes = String(dateObj.getMinutes()).padStart(2, '0');
                            createdAtStr = `${year}-${month}-${day} ${hours}:${minutes}`;
                        }
                    }

                    reviewItem.innerHTML = `
                        <strong>${review.nickname}</strong>
                        <span>⭐ ${review.rating}</span>
                        <p>${review.content}</p>
                        <small>${createdAtStr}</small>
                        ${review.userId === userId ? '<button class="edit-review-btn">수정</button><button class="delete-review-btn">🗑️</button>' : ''}
                    `;
                    reviewListDiv.appendChild(reviewItem);

                    // 삭제, 수정 버튼 이벤트는 이전 코드 그대로 적용 가능
                });

                renderPagination(totalReviews, page, tmdbId);
            })
            .catch(err => { console.error(err); reviewListDiv.innerHTML = "<p>리뷰를 불러올 수 없습니다.</p>"; });
    }

    function renderPagination(totalReviews, currentPage, tmdbId) {
        const pageSize = 10;
        const paginationDiv = document.querySelector(".pagination");
        paginationDiv.innerHTML = "";

        const totalPages = Math.ceil(totalReviews / pageSize);
        if (totalPages <= 1) return;

        let startPage = Math.floor((currentPage - 1) / 5) * 5 + 1;
        let endPage = Math.min(startPage + 4, totalPages);

        if (startPage > 1) {
            const prevBtn = document.createElement("button");
            prevBtn.textContent = "«";
            prevBtn.addEventListener("click", () => loadReviewList(startPage - 1, tmdbId));
            paginationDiv.appendChild(prevBtn);
        }

        for (let i = startPage; i <= endPage; i++) {
            const pageBtn = document.createElement("button");
            pageBtn.textContent = i;
            pageBtn.disabled = i === currentPage;
            pageBtn.addEventListener("click", () => loadReviewList(i, tmdbId));
            paginationDiv.appendChild(pageBtn);
        }

        if (endPage < totalPages) {
            const nextBtn = document.createElement("button");
            nextBtn.textContent = "»";
            nextBtn.addEventListener("click", () => loadReviewList(endPage + 1, tmdbId));
            paginationDiv.appendChild(nextBtn);
        }
    }
});
