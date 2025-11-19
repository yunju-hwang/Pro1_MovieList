function loadUserReviews() {
    const reviewListDiv = document.querySelector(".review-list");
    reviewListDiv.innerHTML = "리뷰 불러오는 중...";

    const userId = localStorage.getItem("userId");
    if (!userId) {
        reviewListDiv.innerHTML = "<p>사용자 정보가 없어 리뷰를 불러올 수 없습니다.</p>";
        return;
    }

    fetch(`${ctx}/movies/reviews_by_user?userId=${userId}`)
        .then(res => res.json())
        .then(reviews => {
            reviewListDiv.innerHTML = "";
            if (reviews.length === 0) {
                reviewListDiv.innerHTML = "<p>등록된 리뷰가 없습니다.</p>";
                return;
            }

            reviews.forEach(review => {
                let createdAtStr = '';
                if (review.createdAt) {
                    const dateObj = new Date(review.createdAt);
                    const year = dateObj.getFullYear();
                    const month = String(dateObj.getMonth() + 1).padStart(2, '0');
                    const day = String(dateObj.getDate()).padStart(2, '0');
                    const hours = String(dateObj.getHours()).padStart(2, '0');
                    const minutes = String(dateObj.getMinutes()).padStart(2, '0');
                    createdAtStr = `${year}-${month}-${day} ${hours}:${minutes}`;
                }

                const reviewItem = document.createElement("div");
                reviewItem.classList.add("review-item");
                reviewItem.innerHTML = `
                    <strong>${review.userId}</strong>
                    <span>⭐ ${review.rating}</span>
                    <p>${review.content}</p>
                    <small>${createdAtStr}</small>
                `;
                reviewListDiv.appendChild(reviewItem);
            });
        })
        .catch(err => {
            console.error(err);
            reviewListDiv.innerHTML = "<p>리뷰를 불러올 수 없습니다.</p>";
        });
}
