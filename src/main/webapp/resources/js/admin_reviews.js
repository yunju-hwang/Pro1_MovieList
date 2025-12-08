const contextPathElement = document.getElementById('contextPath');
const contextPath = contextPathElement ? contextPathElement.value : '';

function formatDateTime(arr) { 
    if (!arr || arr.length < 5) return '-';
    const year = arr[0];
    const month = String(arr[1]).padStart(2, '0');
    const day = String(arr[2]).padStart(2, '0');
    const hour = String(arr[3]).padStart(2, '0');
    const minute = String(arr[4]).padStart(2, '0');
    return `${year}-${month}-${day} ${hour}:${minute}`;
}
// -----------------------------------------------------------


function openReviewDetail(id) {
    const modal = document.getElementById('reviewDetailModal'); 
    const modalBody = document.getElementById('modalBodyContent');
    const deleteBtn = document.querySelector('#reviewDetailModal .delete-btn');

    modalBody.innerHTML = '<p>상세 정보를 불러오는 중...</p>';
    deleteBtn.disabled = true;
    deleteBtn.textContent = '삭제하기';
    
    modal.style.display = 'block';

	const fetchUrl = contextPath + '/admin/reviews/detail/' + id;
   
  fetch(fetchUrl)
        .then(response => {
            if (!response.ok) {
                 throw new Error('HTTP status ' + response.status);
             }
            return response.json();
        })
        .then(data => {
            const modalBody = document.getElementById('modalBodyContent'); 
            modalBody.innerHTML = createReviewDetailInfo(data); 

            const deleteBtn = document.querySelector('#reviewDetailModal .delete-btn');
            deleteBtn.setAttribute('data-id', data.id);
            deleteBtn.disabled = false;
            deleteBtn.textContent = '삭제하기';
        })
        .catch(error => {
            modalBody.innerHTML = '<p style="color: red;">데이터를 불러오지 못했습니다.</p>';
            console.error('Fetch/Processing Error:', error);
        });
}

function closeReviewModal() {
    // 💡 리뷰 모달 ID에 맞게 수정
    document.getElementById('reviewDetailModal').style.display = 'none';
}

window.onclick = function(event) {
    const modal = document.getElementById('reviewDetailModal');
    if (event.target == modal) {
        closeReviewModal();
    }
}


// **상세 정보 HTML 생성 함수** (네가 작성한 그대로)
function createReviewDetailInfo(data) {
    // 💡 formatDateTime 함수 호출을 제거하고, 문자열을 직접 사용
    let formattedDate = data.createdAt; 
    
    // 만약 "YYYY-MM-DDTHH:MM:SS" 형태면 'T'를 공백으로 바꾸기
    if (formattedDate && typeof formattedDate === 'string' && formattedDate.includes('T')) {
        formattedDate = formattedDate.replace('T', ' ');
    }
    // 초 제거 (선택 사항)
    if (formattedDate && formattedDate.length > 16) {
        formattedDate = formattedDate.substring(0, 16);
    }
  return `
        <p class="detail-section-header"><strong>리뷰 번호:</strong> ${data.id}</p>
                
        <div class="top-info-row">
            <p><strong>작성자 ID:</strong> ${data.userId}</p>
            <p class="align-right"><strong>작성일:</strong> ${formattedDate}</p>
        </div>
        <hr class="detail-separator">
        <div class="main-details-group">
            <p><strong>영화 제목:</strong> ${data.movieTitle}</p>
            <p><strong>평점:</strong> ${data.rating}점</p>
        </div>
        <div class="review-content-section">
            <p><strong>리뷰 내용:</strong></p>
            <textarea readonly>${data.content}</textarea> 
        </div>
    `;
}


// 3. 삭제 액션 실행 함수 (Controller 호출)
function fetchReviewDeleteAction(id) {
    const url = contextPath + '/admin/reviews/delete';
    
    if (!confirm(`리뷰 ${id}번을 정말로 삭제하시겠습니까?`)) {
        return;
    }

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `id=${id}`
    })
    .then(response => {
        if (response.ok) {
            alert('리뷰 삭제 처리가 완료되었습니다.');
            location.reload(); // 페이지 새로고침
        } else {
            alert('삭제 요청에 실패했습니다. 서버 응답을 확인하세요.');
        }
    })
    .catch(error => {
        console.error('Fetch Error:', error);
        alert('서버 통신 오류가 발생했습니다.');
    });
}


// 4. 모달 내 삭제 버튼 클릭 연결
function deleteFromReviewModal() {
    const deleteBtn = document.querySelector('#reviewDetailModal .delete-btn');
    const id = deleteBtn.getAttribute('data-id');
    
    if (id && !deleteBtn.disabled) {
        fetchReviewDeleteAction(id);
    }
}