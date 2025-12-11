// movieList.js

let currentPage = 1;           // 현재 페이지
let currentSort = "latest";    // 현재 정렬 방식
const pageSize = 20;           // 페이지 크기

document.addEventListener("DOMContentLoaded", () => {
    console.log("Context Path:", ctx);
    console.log("Is Login:", isLogin);

    // 초기 영화 목록 로드
    loadMovies(ctx, currentSort, currentPage);

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
            currentSort = sortSelect.value;
            currentPage = 1; // 정렬 바꾸면 첫 페이지로
            loadMovies(ctx, currentSort, currentPage);
        });
    }
});

// 영화 목록 불러오기 + 페이징
function loadMovies(ctx, sort = 'latest', page = 1) {
    fetch(`${ctx}/movies/list?sort=${sort}&page=${page}`)
        .then(res => {
            if (!res.ok) throw new Error("영화 데이터를 불러올 수 없습니다.");
            return res.json();
        })
        .then(data => {
            console.log("응답 데이터:", data);

            let movies = data.movies;

            // 혹시라도 객체로 내려오는 경우 대비
            if (!Array.isArray(movies)) {
                console.warn("movies 값이 배열이 아님. 강제로 배열 변환.");
                movies = Object.values(movies);
            }

            renderMovies(movies, ctx);
            renderPagination(data.totalCount, page);
        })
        .catch(err => console.error(err));
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
        const shortOverview = movie.overview
            ? movie.overview.substring(0, 100) + "..."
            : "정보 없음";

        const genreHtml = movie.genres && movie.genres.length > 0
            ? movie.genres.map(g => `<span class="genre-tag">${g}</span>`).join("")
            : "장르 정보 없음";

        const posterUrl = movie.posterPath
            ? `https://image.tmdb.org/t/p/w300${movie.posterPath}`
            : `${ctx}/resources/images/default_poster.png`;

        const favoriteIcon = movie.favorite ? '♥' : '♡';

        const html = `
            <div class="movie-card" 
                 data-id="${movie.tmdbId}" 
                 data-favorite="${movie.favorite}">
                 
                <img class="poster" src="${posterUrl}" alt="${movie.title}">
                
                <div class="title">
                    ${movie.title}
                    <button class="favorite-btn">${favoriteIcon}</button>
                </div>

                <div class="date">${movie.releaseDate || '정보 없음'}</div>
                <div class="genres">${genreHtml}</div>
                <div class="overview">${shortOverview}</div>
            </div>
        `;

        container.insertAdjacentHTML("beforeend", html);
    });

    addEventListeners(ctx);
}


// ⭐ 페이지네이션 렌더링
function renderPagination(totalCount, currentPage) {
    const totalPages = Math.ceil(totalCount / pageSize);
    const container = document.getElementById("pagination");
    
    
    // ⭐ 검색 페이지에서는 페이징 숨기기
    if (window.location.pathname.includes("/movies/search")) {
        container.innerHTML = "";
        container.style.display = "none";
        return;
    }
    
    
    
    
    container.innerHTML = "";

    if (totalPages <= 1) return;

    // 이전
    if (currentPage > 1) {
        container.innerHTML += `<button class="page-btn" data-page="${currentPage - 1}">이전</button>`;
    }

    // 페이지 번호
    for (let i = 1; i <= totalPages; i++) {
        container.innerHTML += `
            <button class="page-btn ${i === currentPage ? "active" : ""}" data-page="${i}">
                ${i}
            </button>
        `;
    }

    // 다음
    if (currentPage < totalPages) {
        container.innerHTML += `<button class="page-btn" data-page="${currentPage + 1}">다음</button>`;
    }

    // 클릭 이벤트
    container.querySelectorAll(".page-btn").forEach(btn => {
        btn.addEventListener("click", () => {
            const selectedPage = Number(btn.dataset.page);
            currentPage = selectedPage;
            loadMovies(ctx, currentSort, selectedPage);
        });
    });
}

// 카드 클릭 + 찜 버튼 이벤트
function addEventListeners(ctx) {
    const container = document.getElementById("movie-list");

    // 카드 클릭 → 상세 페이지
    container.querySelectorAll(".movie-card").forEach(card => {
        card.addEventListener("click", (e) => {
            if (!e.target.classList.contains("favorite-btn")) {
                const movieId = card.dataset.id;
                window.location.href = `${ctx}/movies/detailPage?tmdbId=${movieId}`;
            }
        });
    });

    // 찜 버튼
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
                        const current = card.dataset.favorite === 'true';
                        const next = data.favorite !== undefined ? data.favorite : !current;

                        btn.textContent = next ? '♥' : '♡';
                        card.dataset.favorite = next;
                    } else {
                        alert("찜 기능은 로그인 후 이용 가능합니다.");
                    }
                })
                .catch(err => console.error(err));
        });
    });
}




