document.addEventListener("DOMContentLoaded", () => {
    // 폼 요소들을 가져옵니다.
    const searchForm = document.getElementById("searchForm");
    const sortSelect = document.getElementById("sortCriteria");
    
    if (!searchForm || !sortSelect) {
        // 검색 폼이나 정렬 select가 없는 페이지에서는 아무것도 하지 않습니다.
        return;
    }

    // ⭐ 폼의 모든 파라미터를 읽어와 URL을 만들고 페이지를 이동하는 공통 함수
    window.updateList = function() {
        const actionUrl = searchForm.action;
        const params = new URLSearchParams();
        
        // 폼 내의 모든 input, select 요소를 찾아서 파라미터로 추가
        const elements = searchForm.querySelectorAll('input, select');
        
        elements.forEach(element => {
            if (element.name && element.value) {
                // keyword, searchType, sortCriteria 등의 파라미터가 모두 추가됩니다.
                params.append(element.name, element.value.trim());
            }
        });

        // 페이지 이동
        window.location.href = actionUrl + "?" + params.toString();
    };

    // ⭐ 정렬 드롭다운 변경 시 공통 함수 호출
    sortSelect.addEventListener('change', () => {
        window.updateList();
    });
    
    // ⭐ 검색 버튼 클릭 시 폼 제출 방지 및 공통 함수 호출 (선택 사항: 폼 제출 대신 JS로 처리)
    searchForm.addEventListener('submit', (event) => {
        event.preventDefault(); // 기본 폼 제출 막기
        window.updateList(); // JS 함수로 파라미터 조합 후 이동
    });
});