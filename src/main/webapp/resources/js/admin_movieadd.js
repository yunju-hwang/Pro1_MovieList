document.addEventListener("DOMContentLoaded", () => {
    const openModalBtn = document.getElementById("openAddModalBtn");
    const modal = document.getElementById("addMovieModal");
    const closeModal = document.getElementById("closeModal");
    const modalSearchInput = document.getElementById("modalSearchQuery");
    const modalSearchBtn = document.getElementById("modalSearchBtn");
    const modalResultBody = document.getElementById("modalResultBody");

    // 모달 열기
    openModalBtn.addEventListener("click", () => {
        modal.style.display = "block";
    });

    // 모달 닫기
    closeModal.addEventListener("click", () => {
        modal.style.display = "none";
        modalResultBody.innerHTML = "";
        modalSearchInput.value = "";
    });

    // 외부 클릭 시 닫기
    window.addEventListener("click", (e) => {
        if (e.target === modal) {
            modal.style.display = "none";
            modalResultBody.innerHTML = "";
            modalSearchInput.value = "";
        }
    });

    // 영화 검색 함수
    const searchMovies = () => {
        const query = modalSearchInput.value.trim();
        if (!query) return;

        fetch(`${ctx}/movies/search?query=${encodeURIComponent(query)}&language=ko-KR`)
            .then(res => res.json())
            .then(data => {
                modalResultBody.innerHTML = "";
                if (data.results && data.results.length > 0) {
                    const resultContainer = document.createElement("div");
                    resultContainer.className = "modal-result-cards";

                    data.results.forEach(movie => {
                        const card = document.createElement("div");
                        card.className = "movie-card";
                        card.innerHTML = `
                            <img src="${movie.poster_path ? 'https://image.tmdb.org/t/p/w200' + movie.poster_path : ctx + '/resources/img/no_img_people.png'}" alt="${movie.title}">
                            <p>${movie.title}</p>
                            <p>개봉: ${movie.release_date || '-'}</p>
                            <p>평점: ${movie.vote_average || '-'}</p>
                            <button class="addMovieBtn">추가</button>
                        `;

                        // 클릭하면 tmdbId만 서버로 전송
                        card.querySelector(".addMovieBtn").addEventListener("click", () => {
                            fetch(`${ctx}/movies/add/tmdb/${movie.id}`, { // 서버에서 상세정보 받아 DB 저장
                                method: 'POST'
                            })
                            .then(res => res.json())
                            .then(resp => {
                                if(resp.success){
                                    alert(`${movie.title} 영화가 추가되었습니다!`);
                                } else {
                                    alert(`영화 추가 실패: ${resp.message}`);
                                }
                            })
                            .catch(err => console.error(err));
                        });

                        resultContainer.appendChild(card);
                    });

                    modalResultBody.appendChild(resultContainer);

                } else {
                    modalResultBody.innerHTML = "<p>검색 결과가 없습니다.</p>";
                }
            })
            .catch(err => {
                console.error(err);
                modalResultBody.innerHTML = "<p>검색 중 오류가 발생했습니다.</p>";
            });
    };

    modalSearchBtn.addEventListener("click", searchMovies);
    modalSearchInput.addEventListener("keypress", (e) => {
        if (e.key === "Enter") {
            e.preventDefault();
            searchMovies();
        }
    });
});
