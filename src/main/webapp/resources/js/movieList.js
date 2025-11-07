document.addEventListener("DOMContentLoaded", () => {
    loadMovies();
});

function loadMovies() {
    fetch("/movielist/movies/list")
        .then(res => res.json())
        .then(movies => {
            const container = document.getElementById("movie-list");
            let html = "";

            movies.forEach(movie => {
            
            	// ✅ 줄거리 100자만 표시
                const shortOverview = movie.overview 
                    ? movie.overview.substring(0, 100) + "..."
                    : "";
                    
                html += `
                <div class="movie-card">
                    <img class="poster" 
                        src="https://image.tmdb.org/t/p/w300${movie.posterPath}" 
                        alt="${movie.title}">
                    
                    <div class="title">${movie.title}</div>
                    <div class="date">${movie.releaseDate}</div>

                    <div class="genres">
                        ${(movie.genres || []).map(g => `<span class="genre-tag">${g}</span>`).join("")}
                    </div>

                    <div class="overview">
    					${shortOverview}
					</div>
					
					<div class="movie-card-buttons">
       				 	<a href="${ctx}/reservation/info">예약하기</a>
        				<a href="${ctx}/movies/detail">리뷰 작성</a>
    				</div>
    				
                </div>
                `;
            });
            
            // 카드 클릭 시 상세 페이지 이동
			container.addEventListener("click", function(e) {
    		const card = e.target.closest(".movie-card");
    		if(card && !e.target.closest(".movie-card-buttons a")) {
        	const movieId = card.dataset.id;
        	window.location.href = `${ctx}/movies/detail/`;
    }
});

            container.innerHTML = html;
        });
}