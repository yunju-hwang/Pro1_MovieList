// 1. Context Path를 전역 변수로 설정 (DOM이 로드될 때만 접근 가능하도록)
// 주의: showRequestDetail 함수가 전역으로 선언되어 있으므로, 이 변수도 전역에서 접근 가능해야 합니다.
const contextPathElement = document.getElementById('contextPath');
const contextPath = contextPathElement ? contextPathElement.value : '/';

document.addEventListener('DOMContentLoaded', function() {
    const checkAll = document.getElementById('checkAll');
    const rowCheckboxes = document.querySelectorAll('.row-checkbox');
const approveBtn = document.getElementById('ApproveBtn'); 
    const deleteBtn = document.getElementById('DeleteBtn');
    
    // 선택된 ID를 문자열로 가져오는 함수
    function getCheckedIds() {
        return Array.from(document.querySelectorAll('.row-checkbox:checked'))
                            .map(cb => cb.value);
    }

    // 버튼 활성화/비활성화 및 ID 업데이트
function updateBatchControls() {
        const checkedIds = getCheckedIds();
        const hasChecked = checked = checkedIds.length > 0;
        
        // 버튼 변수명에 맞게 수정
        approveBtn.disabled = !hasChecked;
        deleteBtn.disabled = !hasChecked;
        
        // 전체 체크박스 상태 업데이트
        const allChecked = Array.from(rowCheckboxes).every(cb => cb.checked || cb.disabled);
        checkAll.checked = allChecked && rowCheckboxes.length > 0;
    }

    // 이벤트 리스너 설정
    checkAll.addEventListener('change', function() {
        rowCheckboxes.forEach(checkbox => {
            if (!checkbox.disabled) {
                checkbox.checked = checkAll.checked;
            }
        });
        updateBatchControls();
    });

    rowCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', updateBatchControls);
    });
    
    // 페이지 로드 시 초기 상태 업데이트
    updateBatchControls();
});


// 전역 함수: 상세 정보 모달 표시 (Context Path를 사용하도록 수정)
function showRequestDetail(id) {
    const modal = document.getElementById('requestDetailModal');
    const modalBody = document.getElementById('modalBodyContent');
    modalBody.innerHTML = '<p>상세 정보를 불러오는 중...</p>';
    modal.style.display = 'block'; // 모달 열기

    // 2. Ajax 요청 URL을 Context Path와 결합하여 수정
    const fetchUrl = contextPath + 'admin/movie_requests/detail?id=' + id; // <--- 이 부분이 수정됨
    
    // 1. Ajax 요청을 통해 서버에서 상세 데이터 가져오기
    fetch(fetchUrl) // <--- 수정된 URL 사용
        .then(response => {
            if (!response.ok) {
                 // 200 OK가 아니면 에러를 던져서 .catch()로 이동
                 throw new Error('HTTP status ' + response.status);
             }
            return response.json(); // JSON 형태로 응답 받기
        })
        .then(data => {
            // 1. 날짜 필드를 배열에서 읽기 쉽도록 문자열로 포맷팅하는 함수 (YYYY-MM-DD HH:MM)
            function formatDateTime(arr) {
                if (!arr || arr.length < 5) return '-';
                const year = arr[0];
                const month = String(arr[1]).padStart(2, '0');
                const day = String(arr[2]).padStart(2, '0');
                const hour = String(arr[3]).padStart(2, '0');
                const minute = String(arr[4]).padStart(2, '0');
                return `${year}-${month}-${day} ${hour}:${minute}`;
            }

            const formattedCreatedAt = formatDateTime(data.createdAt);
            const formattedProcessedAt = data.processedAt ? formatDateTime(data.processedAt) : '-'; // 처리일은 null일 수 있으니 체크

// DB 상태 코드를 한글로 변환하는 함수
    function statusToKorean(status) {
        if (status === 'pending') return '검토 대기';
        if (status === 'approved') return '처리 완료';
        // 추가 상태가 있다면 여기에 계속 if문을 추가
        return status; // 정의되지 않은 상태는 그대로 반환
    }

    const koreanStatus = statusToKorean(data.status); // <--- 변환된 한글 상태

            // 2. 받은 데이터를 모달 내용에 채우기 (JSP 오류를 유발했던 코드는 이미 JS 문법으로 안전하게 유지됨)
            modalBody.innerHTML = `<p><strong>번호:</strong> ${data.id}</p>
                <p><strong>요청자:</strong> ${data.userId}</p>
                <p><strong>제목:</strong> ${data.title}</p>
                <p><strong>내용:</strong> <textarea readonly>${data.content}</textarea></p>
                <p><strong>상태:</strong> <span class="status-badge ${data.status}">${koreanStatus}</span></p>
                <p><strong>요청일:</strong> ${formattedCreatedAt}</p>${data.status === 'approved' ? `
                <p><strong>처리일:</strong> ${formattedProcessedAt}</p>` : ''}`;
                
            // 모달 내부의 처리 버튼에도 ID를 저장해두거나 처리 함수를 연결합니다.
            document.querySelector('.modal-actions .approve-btn').setAttribute('data-id', data.id);
            document.querySelector('.modal-actions .delete-btn').setAttribute('data-id', data.id);
            
            // 이미 처리된 경우 모달 내 버튼 비활성화 (선택 사항)
            if (data.status === 'approved') {
                 document.querySelector('.modal-actions .approve-btn').disabled = true;
            } else {
                 document.querySelector('.modal-actions .approve-btn').disabled = false;
            }
        })
        .catch(error => {
            // 통신(404, 500) 또는 데이터 처리 시 오류 발생 시 실행
            modalBody.innerHTML = '<p style="color: red;">데이터를 불러오지 못했습니다. (통신 또는 데이터 처리 오류)</p>';
            console.error('Fetch/Processing Error:', error); // 콘솔에 자세한 에러 출력
        });
}

function closeModal() {
    document.getElementById('requestDetailModal').style.display = 'none';
}

// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
    const modal = document.getElementById('requestDetailModal');
    if (event.target == modal) {
        closeModal();
    }
}
// 5. 핵심: 서버로 AJAX 요청을 보내는 범용 함수 (ids는 단일 ID 또는 쉼표 구분 목록)
function fetchAction(ids, actionType) {
    // ... (네가 방금 보내준 fetchAction 코드 그대로) ...
    const url = contextPath + 'admin/movie_requests/' + actionType; 
    const status = actionType === 'update' ? '&status=approved' : '';
    
    const confirmMessage = actionType === 'update' 
                         ? `요청 ${ids}번을 처리 완료 하시겠습니까?` 
                         : `요청 ${ids}번을 정말로 삭제하시겠습니까?`;

    if (!confirm(confirmMessage)) {
        return;
    }

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `id=${ids}${status}` 
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert(data.message);
            location.reload(); 
        } else {
            alert('처리 실패: ' + data.message);
        }
    })
    .catch(error => {
        console.error('Fetch Error:', error);
        alert('서버 통신 오류가 발생했습니다.');
    });
}


// 3. 일괄 처리 버튼 통합 함수 (JSP에서 handleBatchAction('update/delete')로 호출)
function handleBatchAction(actionType) {
    const ids = Array.from(document.querySelectorAll('.row-checkbox:checked'))
                             .map(cb => cb.value)
                             .join(',');

    if (!ids) {
        alert("선택된 요청이 없습니다.");
        return;
    }
    fetchAction(ids, actionType); // 쉼표 구분된 목록(일괄)을 넘깁니다.
}


// 4. 모달 내에서 처리/삭제 버튼 클릭 시 (기존 함수 대체)
function approveFromModal() {
    const id = document.querySelector('.modal-actions .approve-btn').getAttribute('data-id');
    if (id) {
        fetchAction(id, 'update'); // 단일 ID를 넘깁니다.
    }
}

function deleteFromModal() {
    const id = document.querySelector('.modal-actions .delete-btn').getAttribute('data-id');
    if (id) {
        fetchAction(id, 'delete'); // 단일 ID를 넘깁니다.
    }
}