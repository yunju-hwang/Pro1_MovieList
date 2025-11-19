document.addEventListener('DOMContentLoaded', function() {
    const genreCheckboxes = document.querySelectorAll('.genre-grid input[type="checkbox"]');
    const submitButton = document.querySelector('.next-btn'); 
    const MIN_GENRES = 3;

    let selectedGenresCount = 0;

    // 체크박스 초기 상태 반영 + 클릭 이벤트
    genreCheckboxes.forEach(input => {
        if (input.checked) {
            input.parentElement.classList.add('checked-label');
            selectedGenresCount++;
        }

        input.addEventListener('click', function() {
            if (this.checked) {
                this.parentElement.classList.add('checked-label');
                selectedGenresCount++;
            } else {
                this.parentElement.classList.remove('checked-label');
                selectedGenresCount--;
            }
        });
    });

    // ❗ 제출 버튼 클릭 시 유효성 검사
    submitButton.addEventListener('click', function(event) {
        if (selectedGenresCount < MIN_GENRES) {
            event.preventDefault(); // 제출 막기
            alert(`최소 ${MIN_GENRES}개 이상의 장르를 선택해주세요.`);
        }
    });
});
