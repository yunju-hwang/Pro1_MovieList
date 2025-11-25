// ctx는 JSP에서 선언된 전역 변수를 그대로 사용
// window.onload에서 loadUserReviews 호출은 JSP에서 이미 하고 있으므로 중복 호출 X

function fetchUserReviews(userId) {
    const reviewListDiv = document.querySelector(".review-list");
    reviewListDiv.innerHTML = "리뷰 불러오는 중...";

    return fetch(`${ctx}/movies/reviews_by_user?userId=${userId}`)
        .then(res => {
            if (!res || !res.ok) throw new Error(`리뷰 요청 실패: status ${res ? res.status : 'undefined'}`);
            return res.json();
        })
        .then(reviews => {
            reviewListDiv.innerHTML = "";
            if (!reviews || reviews.length === 0) {
                reviewListDiv.innerHTML = "<p>등록된 리뷰가 없습니다.</p>";
                return [];
            }

            reviews.forEach(review => {
                let createdAtStr = '';
                if (review.createdAt) {
                    const dateObj = new Date(review.createdAt);
                    createdAtStr = `${dateObj.getFullYear()}-${String(dateObj.getMonth()+1).padStart(2,'0')}-${String(dateObj.getDate()).padStart(2,'0')} ${String(dateObj.getHours()).padStart(2,'0')}:${String(dateObj.getMinutes()).padStart(2,'0')}`;
                }
                const reviewItem = document.createElement("div");
                reviewItem.classList.add("review-item");
                reviewItem.innerHTML = `
                    <strong>${review.title}</strong>
                    <small>${review.userId}</small>
                    <span>⭐ ${review.rating}</span>
                    <p>${review.content}</p>
                    <small>${createdAtStr}</small>
                `;
                reviewListDiv.appendChild(reviewItem);
            });

            return reviews;
        });
}

function fetchAIReviewAndMovies(userId) {
    const aiReviewDiv = document.getElementById("aiReviewContainer");
    const aiAnalysisContainer = document.getElementById("aiAnalysisContainer");
    aiReviewDiv.innerHTML = "AI 분석 중...";

    return fetch(`${ctx}/movies/ai_review`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ userId })
    })
    .then(res => {
        if (!res || !res.ok) throw new Error(`AI 분석 요청 실패: status ${res ? res.status : 'undefined'}`);
        return res.json();
    })
    .then(json => {
        console.log("AI 분석 결과:", json);

        if (!json.analysis) {
            aiReviewDiv.textContent = "AI 분석 결과를 가져올 수 없습니다.";
            return [];
        }

        aiAnalysisContainer.innerHTML = `<div class="ai-analysis"><h3>AI 분석</h3><p>${json.analysis}</p></div>`;

        // GPT가 추천 영화 JSON 배열로 준다고 가정
        if (!json.recommendations || json.recommendations.length === 0) {
            aiReviewDiv.innerHTML += "<p>추천 영화가 없습니다.</p>";
            return [];
        }

        // TMDB ID 배열 추출
        const tmdbIds = json.recommendations.map(r => r.tmdbId);
        console.log("추출된 TMDB ID:", tmdbIds);

        // 영화 상세 정보 요청
        return fetch(`${ctx}/getmovie/details`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(tmdbIds)
        });
    })
    .then(res => {
        if (!res) {
            console.warn("영화 상세 요청에서 서버 응답이 없습니다.");
            return [];
        }
        if (!res.ok) {
            console.warn(`영화 상세 요청 실패: status ${res.status}`);
            return [];
        }
        return res.json();
    })
    .then(movieList => {
        if (!movieList || movieList.length === 0) return;

        aiReviewDiv.innerHTML = ""; // AI 분석 텍스트 제거하고 카드 표시
        movieList.forEach(m => {
            if (!m) return;
            const div = document.createElement("div");
            div.classList.add("movie-card");
            div.innerHTML = `
                <img class="poster" src="${m.poster || '/resources/images/default_poster.png'}" alt="${m.title}" />
                <div class="title">${m.title}</div>
                <div class="overview">${m.overview ? (m.overview.length > 100 ? m.overview.substring(0, 100) + "..." : m.overview) : '정보 없음'}</div>
            `;
            
            // 클릭 이벤트 추가 → 상세 페이지 이동
		    div.addEventListener("click", () => {
		        if (m.tmdbId) {
		            window.location.href = `${ctx}/movies/search/detail/${m.tmdbId}`;
		        } else {
		            alert("상세 정보를 불러올 수 없습니다.");
		        }
		    });
            
            aiReviewDiv.appendChild(div);
        });
    })
    .catch(err => {
        console.error(err);
        aiReviewDiv.textContent = "AI 분석 또는 영화 정보를 불러오는 중 오류가 발생했습니다.";
    });
}

function loadUserReviews() {
    const userId = localStorage.getItem("userId");
    if (!userId) {
        document.querySelector(".review-list").innerHTML = "<p>사용자 정보가 없어 리뷰를 불러올 수 없습니다.</p>";
        return;
    }

    // 1. 리뷰 목록 먼저 불러오기
    fetchUserReviews(userId)
        .then(() => {
            // 2. AI 분석 + 영화 정보 불러오기
            return fetchAIReviewAndMovies(userId);
        });
}
