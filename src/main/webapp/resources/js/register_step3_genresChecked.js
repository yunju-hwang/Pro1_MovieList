document.addEventListener('DOMContentLoaded', function() {
    const genreCheckboxes = document.querySelectorAll('.genre-grid input[type="checkbox"]');
    const submitButton = document.querySelector('.next-btn'); 
    const MIN_GENRES = 3;
    let selectedGenresCount = 0;

    // 체크박스 초기 상태 반영 + 클릭 이벤트
    genreCheckboxes.forEach(input => {
        // 초기 선택 상태
        if (input.checked) {
            input.parentElement.classList.add('checked-label');
            selectedGenresCount++;
            input.setAttribute("checked", "checked");
        }

        // 클릭 이벤트
        input.addEventListener('click', function() {
            if (this.checked) {
                this.parentElement.classList.add('checked-label');
                this.setAttribute("checked", "checked");
                selectedGenresCount++;
            } else {
                this.parentElement.classList.remove('checked-label');
                this.removeAttribute("checked");
                selectedGenresCount--;
            }
        });
    });

    // 제출 버튼 클릭 시 최소 선택 체크
    submitButton.addEventListener('click', function(event) {
        if (selectedGenresCount < MIN_GENRES) {
            event.preventDefault(); // 제출 막기
            alert(`최소 ${MIN_GENRES}개 이상의 장르를 선택해주세요.`);
        }
    });
});


// 회원가입 완료 모달 띄우기
window.addEventListener('DOMContentLoaded', () => {
    const body = document.body;
    
    // ✅ 여기서 값 확인
    console.log("signupSuccess:", body.dataset.signupSuccess);

    const signupSuccess = body.dataset.signupSuccess === 'true'; // body 속성 확인

    if(signupSuccess) {
        const modal = document.getElementById('successModal');
        const confirmBtn = document.getElementById('modalConfirmBtn');

		// 1. split 사용하는 방법
		const pathArray = window.location.pathname.split('/');
		const contextPath = pathArray[1];
		console.log(contextPath);

        if(modal && confirmBtn){
            modal.style.display = 'flex'; // 모달 보이기

            // 확인 버튼 클릭 시 로그인 페이지로 이동
            
            confirmBtn.addEventListener('click', () => {
            //alert('${pageContext.request.contextPath}');
                window.location.href = '/' + contextPath + '/login'; // 필요시 contextPath 추가
            });
        }
    }
});
