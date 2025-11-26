// DOMContentLoaded: HTML 문서가 완전히 로드된 후에 JavaScript를 실행합니다.
document.addEventListener('DOMContentLoaded', function() {
    // 1. 필요한 요소들을 변수에 저장
    const modal = document.getElementById('findIdModal');
    const closeButton = document.querySelector('.btn-close');
    const openButton = document.getElementById('openModalButton'); // JSP에 추가한 테스트용 버튼
    const findIdForm = document.getElementById('findIdForm');

    // 모달을 여는 함수
    function openModal() {
        // modal-overlay에 CSS의 display: flex;를 적용하여 보이게 합니다.
        modal.style.display = 'flex';
    }

    // 모달을 닫는 함수
    function closeModal() {
        // modal-overlay에 CSS의 display: none;을 적용하여 숨깁니다.
        modal.style.display = 'none';
    }

    // 2. 이벤트 리스너 등록

    // (테스트용) "아이디 찾기 팝업 열기" 버튼 클릭 시 모달 열기
    if (openButton) {
        openButton.addEventListener('click', openModal);
    }
    
    // 닫기 버튼 클릭 시 모달 닫기
    closeButton.addEventListener('click', closeModal);

    // 모달 배경 클릭 시 모달 닫기 (팝업창 본체 제외)
    modal.addEventListener('click', function(e) {
        // 클릭된 요소가 modal-overlay 자신인지 확인 (팝업창 내부 요소가 아닌지 확인)
        if (e.target === modal) {
            closeModal();
        }
    });

    // ESC 키를 눌렀을 때 모달 닫기
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && modal.style.display === 'flex') {
            closeModal();
        }
    });

    /* -------------------------------------------
       아이디 찾기 폼 제출 처리 (AJAX 예시)
       ------------------------------------------- */
    findIdForm.addEventListener('submit', function(e) {
        // 기본 폼 제출 동작을 막습니다 (페이지 새로고침 방지)
        e.preventDefault(); 
        
        const userName = document.getElementById('userName').value;
        const userEmail = document.getElementById('userEmail').value;

        // 실제로는 이 부분에서 AJAX 통신을 통해 서버(Controller)로 데이터를 전송해야 합니다.
        console.log('아이디 찾기 요청:', { name: userName, email: userEmail });
        
        // **임시 테스트 코드:**
        alert('아이디 찾기 요청 전송 (서버 연동 필요)');
        // closeModal(); 
    });

});