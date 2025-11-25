document.addEventListener("DOMContentLoaded", () => {
    const detailDiv = document.getElementById("movie-detail");
    const urlParams = new URLSearchParams(window.location.search);
    const tmdbId = urlParams.get("tmdbId");

    if (!tmdbId) {
        detailDiv.innerHTML = "<p>영화 정보를 불러올 수 없습니다.</p>";
        return;
    }

    // 🎬 영화 상세 정보 가져오기
    fetch(`${ctx}/movies/detail?tmdbId=${tmdbId}`)
        .then(res => {
            if (!res.ok) throw new Error(`HTTP error! status: ${res.status}`);
            return res.json();
        })
        .then(movie => {
            console.log("🎬 movie 객체:", movie);
            localStorage.setItem("screeningTime", movie.runtime);

            const posterUrl = movie.posterPath
                ? `https://image.tmdb.org/t/p/w400${movie.posterPath}`
                : `${ctx}/resources/images/default_poster.png`;

            const genreHtml = movie.genres && movie.genres.length > 0
                ? movie.genres.join(', ')
                : '정보 없음';

            const runtime = movie.runtime !== null ? `${movie.runtime}분` : "정보 없음";

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
                        <div class="popularity-box"></div>
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
                    <div class="my-review">
                        <div class="star-rating" id="starRating"></div>
                        <textarea placeholder="리뷰를 작성해주세요"></textarea>
                        <button class="submit-review" id="submitReview">등록</button>
                    </div>
                    <div class="review-list">
                        <p>리뷰 불러오는 중...</p>
                    </div>
                </div>
            `;

            const heartIcon = document.getElementById("heartIcon");
            const wishBtn = document.getElementById("wishBtn");
            const detailContainer = detailDiv.querySelector(".detail-container");

            // 찜 버튼 이벤트
            wishBtn.addEventListener("click", e => {
                e.stopPropagation();
                if (!isLogin) {
                    alert("로그인이 필요한 서비스입니다.");
                    return;
                }

                fetch(`${ctx}/movies/favorite/${tmdbId}`, {
                    method: "POST",
                    headers: { "Content-Type": "application/json" }
                })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        const current = detailContainer.dataset.favorite === 'true';
                        const next = data.isFavorite !== undefined ? data.isFavorite : !current;
                        heartIcon.textContent = next ? '❤️' : '♡';
                        detailContainer.dataset.favorite = next;
                    } else alert("찜 기능을 사용할 수 없습니다.");
                })
                .catch(err => console.error(err));
            });

            // 예매 버튼
            const reserveBtn = document.getElementById("reserveBtn");
            reserveBtn.addEventListener("click", () => {
                if (!isLogin) { alert("로그인이 필요한 서비스입니다"); return; }
                const url = `${ctx}/reservation/info?tmdbId=${tmdbId}&title=${encodeURIComponent(movie.title)}`;
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

            // ✅ 리뷰 리스트 불러오기
            function loadReviewList() {
                const reviewListDiv = document.querySelector(".review-list");
                reviewListDiv.innerHTML = "리뷰 불러오는 중...";
                fetch(`${ctx}/movies/review_list?tmdbId=${tmdbId}`)
                    .then(res => res.json())
                    .then(reviews => {
                        reviewListDiv.innerHTML = "";
                        if (reviews.length === 0) {
                            reviewListDiv.innerHTML = "<p>등록된 리뷰가 없습니다.</p>";
                            return;
                        }
                        reviews.forEach(review => {
                            const reviewItem = document.createElement("div");
                            reviewItem.classList.add("review-item");
                            reviewItem.dataset.reviewId = review.id; // DOM에 reviewId 저장
                            
                            let createdAtStr = '';
						    if (review.createdAt) {
						        const dateObj = new Date(review.createdAt);
						        if (!isNaN(dateObj.getTime())) { // 유효한 날짜인지 확인
						            const year = dateObj.getFullYear();
						            const month = String(dateObj.getMonth() + 1).padStart(2, '0');
						            const day = String(dateObj.getDate()).padStart(2, '0');
						            const hours = String(dateObj.getHours()).padStart(2, '0');
						            const minutes = String(dateObj.getMinutes()).padStart(2, '0');
						            createdAtStr = `${year}-${month}-${day} ${hours}:${minutes}`;
						        }
						    }
                            
                            
                            reviewItem.innerHTML = `
                                <strong>${review.userId}</strong>
                                <span>⭐ ${review.rating}</span>
                                <p>${review.content}</p>
                                <small>${createdAtStr}</small>
                                ${review.userId === localStorage.getItem("userId") ? '<button class="edit-review-btn">수정</button><button class="delete-review-btn">🗑️</button>' : ''}
          
                            `;
                            reviewListDiv.appendChild(reviewItem);
                            
                            // 🔥 삭제 버튼 이벤트
						const deleteBtn = reviewItem.querySelector(".delete-review-btn");
						if (deleteBtn) {
						    deleteBtn.addEventListener("click", () => {
						        if (!confirm("리뷰를 삭제하시겠습니까?")) return;
						
						        const reviewId = reviewItem.dataset.reviewId;
								const userId = reviewItem.dataset.userId;  // ★ 추가
								
						        fetch(`${ctx}/movies/review_delete`, {
						            method: "POST",
						            headers: { "Content-Type": "application/x-www-form-urlencoded" },
						            body: new URLSearchParams({
						                reviewId: reviewId,
						                userId: userId
						            })
						        })
						        .then(res => res.json())
						        .then(data => {
						            if (data.success) {
						                alert("리뷰가 삭제되었습니다!");
						                loadReviewList(); // 삭제 후 목록 새로 로드
						            } else {
						                alert("리뷰 삭제에 실패했습니다.");
						            }
						        })
						        .catch(err => console.error(err));
						    });
						}
                            
                            
                            
                             // ✅ 수정 버튼 이벤트
		                const editBtn = reviewItem.querySelector(".edit-review-btn");
						if (editBtn) {
						    editBtn.addEventListener("click", () => {
						        const currentContent = review.content;
						        const currentRating = review.rating;
								const reviewId = reviewItem.dataset.reviewId;
						        // reviewItem 전체를 수정 UI로 교체 (outerHTML 제거)
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
											
						
						        // ⭐ 별점 UI
						        const editStarsContainer = reviewItem.querySelector(".edit-star-rating");
						        const editStars = [];
						        let selectedEditRating = currentRating;
						        for (let i = 1; i <= 5; i++) {
						            const star = document.createElement("span");
						            star.classList.add("star");
						            star.dataset.value = i;
						            star.textContent = i <= selectedEditRating ? '★' : '☆';
						            star.style.fontSize = "20px";
						            star.style.cursor = "pointer";
						            star.style.marginRight = "3px";
						            editStarsContainer.appendChild(star);
						            editStars.push(star);
						
						            star.addEventListener("click", () => {
						                selectedEditRating = i;
						                editStars.forEach((s, idx) => s.textContent = idx < i ? '★' : '☆');
						            });
						        }
						
						
                        // 저장 버튼
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
                                    reviewId: reviewId,
                                    content: newContent,
                                    rating: selectedEditRating
                                })
                            })
                            .then(res => res.json())
                            .then(data => {
                                if (data.success) {
                                    alert("리뷰가 수정되었습니다!");
                                    loadReviewList(); // 수정 후 리뷰 목록 갱신
                                } else {
                                    alert(data.message);
                                }
                            })
                            .catch(err => console.error(err));
                        });

		                        // 취소 버튼
		                        reviewItem.querySelector(".cancel-review-btn").addEventListener("click", () => {
		                            loadReviewList(); // 원래 목록으로 복원
		                        });
		                    });
		                }
		                            
		                            
                        });
                    })
                    .catch(err => {
                        console.error(err);
                        reviewListDiv.innerHTML = "<p>리뷰를 불러올 수 없습니다.</p>";
                    });
            }

            loadReviewList(); // 페이지 로드 시 리뷰 불러오기

            // 리뷰 등록 버튼
            const submitBtn = document.getElementById("submitReview");
            submitBtn.addEventListener("click", () => {
                const reviewText = document.querySelector(".my-review textarea").value.trim();
                const userId = localStorage.getItem("userId");

                if (!isLogin) { alert("로그인이 필요한 서비스입니다"); return; }
                if (!reviewText || selectedRating === 0) { alert("리뷰 내용과 별점을 모두 입력해주세요"); return; }

                fetch(`${ctx}/movies/review_write`, {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body: new URLSearchParams({
                        tmdbId: tmdbId,
                        userId: userId,
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
                        loadReviewList(); // 등록 후 리뷰 갱신
                    } else {
                        alert(data.message);
                    }
                })
                .catch(err => console.error(err));
            });

        })
        .catch(err => {
            console.error(err);
            detailDiv.innerHTML = "<p>영화 정보를 불러올 수 없습니다.</p>";
        });
});
