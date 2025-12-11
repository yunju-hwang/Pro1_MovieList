document.addEventListener("DOMContentLoaded", () => {
    const detailDiv = document.getElementById("movie-detail");
    const urlParams = new URLSearchParams(window.location.search);
    const tmdbId = urlParams.get("tmdbId");

    if (!tmdbId) {
        detailDiv.innerHTML = "<p>영화 정보를 불러올 수 없습니다.</p>";
        return;
    }

    // 안전한 JSON 파싱
    function fetchJson(url, options) {
        return fetch(url, options).then(async res => {
            const ct = res.headers.get("content-type") || "";
            const text = await res.text();
            if (!res.ok) {
                console.error("fetch error:", res.status, text);
                throw new Error(`fetch error ${res.status}`);
            }
            if (!ct.includes("application/json")) {
                console.error("응답이 JSON이 아님:", url, text);
                throw new Error("서버 응답이 JSON이 아닙니다.");
            }
            try {
                return JSON.parse(text);
            } catch (e) {
                console.error("JSON 파싱 실패:", text);
                throw e;
            }
        });
    }

    // 영화 상세 정보 가져오기
    fetchJson(`${ctx}/movies/detail?tmdbId=${tmdbId}`)
        .then(movie => {
            const posterUrl = movie.posterPath
                ? `https://image.tmdb.org/t/p/w400${movie.posterPath}`
                : `${ctx}/resources/images/default_poster.png`;

            const genreHtml = movie.genres && movie.genres.length > 0
                ? movie.genres.join(', ')
                : '정보 없음';

            const runtime = movie.runtime !== null ? `${movie.runtime}분` : "정보 없음";

            // 감독/출연진 가져오기
            fetchJson(`${ctx}/movies/${tmdbId}/credits`)
                .then(credits => {
                    let directorName = "정보 없음";
                    let castList = [];

                    if (credits) {
                        if (credits.crew && Array.isArray(credits.crew)) {
                            const director = credits.crew.find(member => member.job === "Director");
                            if (director) directorName = director.name;
                        }
                        if (credits.cast && Array.isArray(credits.cast)) {
                            castList = credits.cast;
                        }
                    }

                    // 영화 상세 HTML
                    detailDiv.innerHTML = `
                        <div class="detail-container" data-favorite="${movie.favorite ? 'true' : 'false'}">
                            <div class="left-box">
                                <div class="poster-wrapper">
                                    <img class="poster" src="${posterUrl}" alt="${escapeHtml(movie.title)}">
                                    <button class="wish-btn" id="wishBtn">
                                        <span class="heart-icon" id="heartIcon">${movie.favorite ? '❤️' : '♡'}</span>
                                    </button>
                                </div>
                            </div>
                            <div class="right-box">
                                <h1 class="movie-title">${escapeHtml(movie.title)}</h1>
                                <div class="meta">
                                    <span><strong>상영시간:</strong> ${runtime}</span>
                                </div>
                                <p><strong>개봉일:</strong> ${movie.releaseDate || '정보 없음'}</p>
                                <p><strong>장르:</strong> ${genreHtml}</p>
                                <p class="overview">${escapeHtml(movie.overview || '정보 없음')}</p>
                                <button class="wish-btn-reserve" id="reserveBtn">🎬 예매하기</button>
                            </div>
                        </div>
                        
                        <div class="credit-section">
                            <h2>🎬 감독 & 출연진</h2>
                            <p><strong>감독:</strong> ${escapeHtml(directorName)}</p>
                            <strong>출연:</strong>
                            <div class="cast-list">
                                ${castList.map(actor => `
                                    <div class="cast-card">
                                        <img src="${actor.profile_path 
                                            ? `https://image.tmdb.org/t/p/w500${actor.profile_path}`
                                            : `${ctx}/resources/img/no_img_people.png`}" 
                                             alt="${escapeHtml(actor.name || '')}">
                                        <p>${escapeHtml(actor.name || "이름 없음")}</p>
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

                    bindDetailEvents(movie, tmdbId);
                    loadReviewList(1, tmdbId);
                })
                .catch(err => {
                    console.error("credits 불러오기 실패:", err);
                    detailDiv.innerHTML = "<p>영화 정보를 불러올 수 없습니다.(credits)</p>";
                });
        })
        .catch(err => {
            console.error("detail 불러오기 실패:", err);
            detailDiv.innerHTML = "<p>영화 정보를 불러올 수 없습니다.(detail)</p>";
        });

    // 안전한 텍스트 이스케이프
    function escapeHtml(str) {
        if (!str && str !== 0) return '';
        return String(str)
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

    // 이벤트 바인딩 함수
    function bindDetailEvents(movie, tmdbId) {
        const heartIcon = document.getElementById("heartIcon");
        const wishBtn = document.getElementById("wishBtn");
        const detailContainer = document.querySelector(".detail-container");

        // 찜 버튼
        wishBtn.addEventListener("click", e => {
            e.stopPropagation();
            if (!isLogin) { alert("로그인이 필요한 서비스입니다."); return; }

            fetch(`${ctx}/movies/favorite/${tmdbId}`, { method: "POST" })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        const current = detailContainer.dataset.favorite === 'true';
                        const next = data.isFavorite !== undefined ? data.isFavorite : !current;
                        heartIcon.textContent = next ? '❤️' : '♡';
                        detailContainer.dataset.favorite = next;
                    }
                })
                .catch(err => console.error("favorite 실패:", err));
        });

        // 예매 버튼
        document.getElementById("reserveBtn").addEventListener("click", () => {
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
        document.getElementById("submitReview").addEventListener("click", () => {
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
                    document.querySelector(".my-review textarea").value = "";
                    selectedRating = 0;
                    fillStars(selectedRating);
                    loadReviewList(1, tmdbId);
                } else {
                    console.error("리뷰 등록 실패:", data);
                }
            })
            .catch(err => console.error("리뷰 등록 에러:", err));
        });
    } // [수정됨] bindDetailEvents 함수의 닫는 괄호가 누락되었던 곳입니다.

    // ⭐ 리뷰 목록 불러오기
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

                // 사용자 리뷰 우선 정렬
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

                    let createdAtStr = "";
                    if (review.createdAt) {
                        const d = new Date(review.createdAt);
                        if (!isNaN(d.getTime())) {
                            createdAtStr =
                                `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')} `
                                + `${String(d.getHours()).padStart(2,'0')}:${String(d.getMinutes()).padStart(2,'0')}`;
                        }
                    }

                    reviewItem.innerHTML = `
                        <strong>${review.nickname}</strong>
                        <span>⭐ ${review.rating}</span>
                        <p class="review-content">${review.content}</p>
                        <small>${createdAtStr}</small>

                        ${review.userId === userId ? `
                            <button class="edit-review-btn">수정</button>
                            <button class="delete-review-btn">삭제</button>
                        ` : ''}
                    `;

                    reviewListDiv.appendChild(reviewItem);

                    /* ------------------------------
                       🔥 삭제
                    -------------------------------- */
                    const deleteBtn = reviewItem.querySelector(".delete-review-btn");
                    if (deleteBtn) {
                        deleteBtn.addEventListener("click", () => {
                            if (!confirm("리뷰를 삭제하시겠습니까?")) return;

                            const reviewId = reviewItem.dataset.reviewId;
                            const userIdVal = reviewItem.dataset.userId;

                            fetch(`${ctx}/movies/review_delete`, {
                                method: "POST",
                                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                                body: new URLSearchParams({
                                    reviewId,
                                    userId: userIdVal
                                })
                            })
                            .then(res => res.json())
                            .then(data => {
                                if (data.success) {
                                    alert("리뷰가 삭제되었습니다!");
                                    loadReviewList(page, tmdbId);
                                } else {
                                    alert("리뷰 삭제 실패");
                                }
                            });
                        });
                    }

                    /* ------------------------------
                       ✏ 수정
                    -------------------------------- */
                    const editBtn = reviewItem.querySelector(".edit-review-btn");
                    if (editBtn) {
                        editBtn.addEventListener("click", () => {
                            const currentContent = review.content;
                            const currentRating = review.rating;
                            const reviewId = reviewItem.dataset.reviewId;

                            reviewItem.innerHTML = `
                                <div class="edit-review">
                                    <textarea class="edit-content" rows="3">${currentContent}</textarea>
                                    <div class="edit-star-rating"></div>
                                    <div class="edit-buttons">
                                        <button class="save-review-btn">저장</button>
                                        <button class="cancel-review-btn">취소</button>
                                    </div>
                                </div>
                            `;

                            // 별점 UI
                            const starWrap = reviewItem.querySelector(".edit-star-rating");
                            const editStars = [];
                            let selectedEditRating = currentRating;

                            for (let i = 1; i <= 5; i++) {
                                const star = document.createElement("span");
                                star.textContent = i <= selectedEditRating ? "★" : "☆";
                                star.dataset.value = i;
                                star.classList.add("star");
                                star.style.fontSize = "20px";
                                star.style.cursor = "pointer";
                                star.style.marginRight = "3px";
                                starWrap.appendChild(star);
                                editStars.push(star);

                                star.addEventListener("click", () => {
                                    selectedEditRating = i;
                                    editStars.forEach((s, idx) =>
                                        s.textContent = idx < i ? "★" : "☆"
                                    );
                                });
                            }

                            // 저장
                            reviewItem.querySelector(".save-review-btn").addEventListener("click", () => {
                                const newContent = reviewItem.querySelector(".edit-content").value.trim();

                                if (!newContent || selectedEditRating === 0) {
                                    alert("내용과 별점을 모두 입력해주세요.");
                                    return;
                                }

                                fetch(`${ctx}/movies/review_update`, {
                                    method: "POST",
                                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                                    body: new URLSearchParams({
                                        reviewId,
                                        content: newContent,
                                        rating: selectedEditRating
                                    })
                                })
                                .then(res => res.json())
                                .then(data => {
                                    if (data.success) {
                                        alert("리뷰가 수정되었습니다!");
                                        loadReviewList(page, tmdbId);
                                    }
                                });
                            });

                            // 취소
                            reviewItem.querySelector(".cancel-review-btn").addEventListener("click", () => {
                                loadReviewList(page, tmdbId);
                            });
                        });
                    }
                });

                renderPagination(totalReviews, page, tmdbId);
            });
    }

    // 페이징 처리
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