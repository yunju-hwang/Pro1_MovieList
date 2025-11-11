// movieList.js

// JSP에서 ctx와 isLogin 전달
// const ctx = '<c:out value="${pageContext.request.contextPath}"/>';
// const isLogin = <c:out value="${not empty sessionScope.loginUser}" default="false"/>;

document.addEventListener("DOMContentLoaded", () => {
    console.log("Context Path:", ctx);
    console.log("Is Login:", isLogin);

    // 초기 영화 목록 로드
    loadMovies(ctx, 'latest');

    // AI Review 버튼 클릭 시 로그인 확인
    const aiBtn = document.getElementById("aiReviewBtn");
    if (aiBtn) {
        aiBtn.addEventListener("click", (event) => {
            if (!isLogin) {
                event.preventDefault();
                alert("로그인이 필요한 서비스입니다.");
                window.location.href = `${ctx}/main`;
            }
        });
    }

    // 정렬 select 이벤트
    const sortSelect = document.getElementById("sort-select");
    if (sortSelect) {
        sortSelect.addEventListener("change", () => {
            loadMovies(ctx, sortSelect.value);
        });
    }
});

// 영화 목록 불러오기
function loadMovies(ctx, sort = 'latest') {
    fetch(`${ctx}/movies/list?sort=${encodeURIComponent(sort)}`)
        .then(res => {
            if (!res.ok) throw new Error("서버에서 영화 데이터를 불러올 수 없습니다.");
            return res.json();
        })
        .then(movies => {
	        console.log(movies); // <- 여기서 genres와 posterPath가 있는지 확인
	        renderMovies(movies, ctx);
    	})
        .catch(err => {
            console.error(err);
            document.getElementById("movie-list").innerHTML = "<p>영화 정보를 불러올 수 없습니다.</p>";
        });
}

// 영화 카드 렌더링
function renderMovies(movies, ctx) {
    const container = document.getElementById("movie-list");
    container.innerHTML = "";

    if (!movies || movies.length === 0) {
        container.innerHTML = "<p>영화 정보가 없습니다.</p>";
        return;
    }

    movies.forEach(movie => {
        const shortOverview = movie.overview ? movie.overview.substring(0, 100) + "..." : "정보 없음";
        const genreHtml = movie.genres && movie.genres.length > 0
            ? movie.genres.map(g => `<span class="genre-tag">${g}</span>`).join("")
            : "장르 정보 없음";
        const posterUrl = movie.posterPath 
            ? `https://image.tmdb.org/t/p/w300${movie.posterPath}`
            : `${ctx}/resources/images/default_poster.png`;

        const html = `
            <div class="movie-card" data-id="${movie.tmdbId}">
                <img class="poster" src="${posterUrl}" alt="${movie.title}">
                <div class="title">
                    ${movie.title}
                    <button class="favorite-btn">${movie.isFavorite ? '♥' : '♡'}</button>
                </div>
                <div class="date">${movie.releaseDate || '정보 없음'}</div>
                <div class="genres">${genreHtml}</div>
                <div class="overview">${shortOverview}</div>
                <div class="movie-card-buttons">
                    <a href="${ctx}/reservation/info">예약하기</a>
                    <a href="${ctx}/movies/detailPage?tmdbId=${movie.tmdbId}">리뷰 작성</a>
                </div>
            </div>
        `;

        container.insertAdjacentHTML("beforeend", html);
    });

    // 카드 이벤트 등록
    addEventListeners(ctx);
}

// 카드 클릭 및 버튼 이벤트 등록
function addEventListeners(ctx) {
    const container = document.getElementById("movie-list");

    // 카드 클릭 -> 상세페이지 이동
    container.querySelectorAll(".movie-card").forEach(card => {
        card.addEventListener("click", (e) => {
            if (!e.target.closest(".movie-card-buttons a") && !e.target.classList.contains("favorite-btn")) {
                const movieId = card.dataset.id;
                window.location.href = `${ctx}/movies/detailPage?tmdbId=${movieId}`;
            }
        });
    });

    // a 태그 클릭 시 JS 이동
    container.querySelectorAll(".movie-card-buttons a").forEach(a => {
        a.addEventListener("click", (e) => {
            e.preventDefault();
            const movieId = a.closest(".movie-card").dataset.id;
            window.location.href = `${ctx}/movies/detailPage?tmdbId=${movieId}`;
        });
    });

    // 찜 버튼 이벤트
    container.querySelectorAll(".favorite-btn").forEach(btn => {
        btn.addEventListener("click", (e) => {
            e.stopPropagation();
            const card = btn.closest(".movie-card");
            const movieId = card.dataset.id;

            fetch(`${ctx}/movies/favorite/${movieId}`, {
                method: "POST",
                headers: { "Content-Type": "application/json" }
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    btn.textContent = data.isFavorite ? '♥' : '♡';
                } else {
                    alert("찜 기능을 사용할 수 없습니다.");
                }
            })
            .catch(err => console.error(err));
        });
    });
}
