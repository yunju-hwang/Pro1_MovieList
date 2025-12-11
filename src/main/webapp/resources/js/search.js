


document.addEventListener("DOMContentLoaded", () => {
    const container = document.getElementById("search-container");
    const movieListDiv = document.getElementById("movie-list");
    const ctx = movieListDiv.dataset.ctx;

    // HTML 구조만 JS에서 생성
    container.innerHTML = `
        <div class="movie-search">
            <form id="movieSearchForm">
                <input type="text" id="searchInput" placeholder="영화 제목을 입력하세요" />
                <img src="${ctx}/resources/img/search.png" id="searchBtn" alt="검색" />
            </form>
        </div>
    `;

    const searchForm = document.getElementById("movieSearchForm");
    const searchInput = document.getElementById("searchInput");
    const searchBtn = document.getElementById("searchBtn");

    const searchMovies = () => {
        const query = searchInput.value.trim();
        if (!query) return;

		    // 🔥 검색 시 페이징 숨기기
    	const pagination = document.getElementById("pagination");
   		 if (pagination) pagination.style.display = "none";
        fetch(`${ctx}/movies/search?query=${encodeURIComponent(query)}&language=ko-KR`)
            .then(res => res.json())
            .then(data => {
                movieListDiv.innerHTML = "";
                if (data.results && data.results.length > 0) {
                    data.results.forEach(movie => {
                        const div = document.createElement("div");
                        div.className = "movie-item";
                        div.innerHTML = `
                            <img src="https://image.tmdb.org/t/p/w200${movie.poster_path}" alt="${movie.title}">
                            <p>${movie.title} (${movie.release_date})</p>
                        `;
                        div.addEventListener("click", (e) => {
                        	e.preventDefault();
                            window.location.href = `${ctx}/movies/search/detail/${movie.id}`;
                        });
                        movieListDiv.appendChild(div);
                    });
                } else {
                    movieListDiv.innerHTML = "<p>검색 결과가 없습니다.</p>";
                }
            })
            .catch(err => {
                console.error(err);
                movieListDiv.innerHTML = "<p>검색 중 오류가 발생했습니다.</p>";
            });
    };

    searchForm.addEventListener("submit", e => { e.preventDefault(); 
    searchMovies(); 
    });
    searchBtn.addEventListener("click", searchMovies);
});
