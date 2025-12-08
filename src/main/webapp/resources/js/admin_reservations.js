// 1. Context Path를 전역 변수로 설정 (JSP에 정의된 변수를 사용한다고 가정)
const contextPathElement = document.getElementById('contextPath');
const contextPath = contextPathElement ? contextPathElement.value : '';

// -----------------------------------------------------------
// 보조 함수 (날짜 포맷, 상태 변환)

function formatDateTime(arr) {
    // 기존 배열 포맷팅 함수 (결제 일시 등에 사용)
    if (!arr || arr.length < 5) return '-';
    const year = arr[0];
    const month = String(arr[1]).padStart(2, '0');
    const day = String(arr[2]).padStart(2, '0');
    const hour = String(arr[3]).padStart(2, '0');
    const minute = String(arr[4]).padStart(2, '0');
    return `${year}-${month}-${day} ${hour}:${minute}`;
}

// 💡 새로 추가: ISO 문자열을 포맷팅하는 함수 (상영 시간에 사용)
function formatISOString(isoString) {
    if (!isoString) return '-';
    // "2025-12-06T15:00:00" -> "2025-12-06 15:00"
    const [date, timeWithSec] = isoString.split('T');
    const [hour, minute] = timeWithSec.split(':');
    return `${date} ${hour}:${minute}`;
}

// DB 상태 코드를 한글로 변환하는 함수 (예매 상태에 맞게 수정)
function statusToKorean(status) {
    if (status === 'reserved') return '예매 완료';
    if (status === 'cancelled') return '사용자 취소';
    if (status === 'refunded') return '관리자 환불';
    return status;
}
// -----------------------------------------------------------
// 2. 모달 제어 함수 (핵심)

function openReservationDetail(id) {
    const modal = document.getElementById('reservationDetailModal');
    const modalBody = document.getElementById('modalBodyContent');
    const refundBtn = document.querySelector('#reservationDetailModal .approve-btn'); // 버튼 미리 찾기
    
    // 모달 초기화
    modalBody.innerHTML = '<p>상세 정보를 불러오는 중...</p>';
    // 버튼 초기 상태 설정 (데이터 로드 전까지 비활성화)
    refundBtn.disabled = true;
    refundBtn.textContent = '환불하기';
    
    modal.style.display = 'block';

    const fetchUrl = contextPath + '/admin/reservations/detail/' + id;
    
    fetch(fetchUrl)
        .then(response => {
             if (!response.ok) {
                 throw new Error('HTTP status ' + response.status);
             }
             return response.json();
        })
        .then(data => {
            // 상세 정보 HTML 생성 및 채우기
            const modalBody = document.getElementById('modalBodyContent'); 
            // **** Request 모달과 동일하게 <p> 태그 구조로 변경된 함수를 사용 ****
            modalBody.innerHTML = createDetailInfo(data); 

            const refundBtn = document.querySelector('#reservationDetailModal .approve-btn');
            // **1. 버튼에 ID 저장**
            refundBtn.setAttribute('data-id', data.id);
            
            // **2. 환불 상태에 따른 버튼 활성화/비활성화 제어**
            if (data.status === 'reserved') {
                refundBtn.disabled = false;
                refundBtn.textContent = '환불하기';
            } else {
                refundBtn.disabled = true;
                refundBtn.textContent = statusToKorean(data.status) + ' 완료';
            }
        })
        .catch(error => {
            modalBody.innerHTML = '<p style="color: red;">데이터를 불러오지 못했습니다. (통신 또는 데이터 처리 오류)</p>';
            console.error('Fetch/Processing Error:', error);
        });
}

function closeReservationModal() {
    document.getElementById('reservationDetailModal').style.display = 'none';
}

window.onclick = function(event) {
    const modal = document.getElementById('reservationDetailModal');
    if (event.target == modal) {
        closeReservationModal();
    }
}

// **상세 정보 HTML 생성 함수** (테이블 대신 <p> 태그를 사용하도록 수정)
function createDetailInfo(data) {
    // 💡 상영 시간은 formatISOString 사용
    const formattedScreenTime = formatISOString(data.screeningTime); 
    // 결제 일시는 기존 formatDateTime 사용
    const formattedDate = formatDateTime(data.reservationDate);      
    const koreanStatus = statusToKorean(data.status);
    const finalAmount = data.finalAmount ? data.finalAmount.toLocaleString('ko-KR') : 0;
    
    return `
        <p class="detail-section-header"><strong>예매 번호:</strong> ${data.id}</p>
        
        <div class="top-info-row">
            <p><strong>예매자 ID:</strong> ${data.userId}</p>
            <p class="align-right"><strong>결제 일시:</strong> ${formattedDate}</p>
        </div>
        
        <hr class="detail-separator">

        <div class="main-details-group">
            <p><strong>영화 제목:</strong> ${data.movieTitle}</p>
            <p><strong>상영관:</strong> ${data.theaterName}</p>
            <p><strong>상영 시간:</strong> ${formattedScreenTime}</p>
            <p><strong>관람 인원:</strong> 총 ${data.adultPeople + data.childPeople}명 (성인 ${data.adultPeople}명, 아동 ${data.childPeople}명)</p>
            <p><strong>좌석 정보:</strong> ${data.seat}</p>
        </div>
        
        <hr class="detail-separator">

        <p class="detail-section-footer"><strong>최종 금액:</strong> ${finalAmount}원</p>
        <p class="detail-section-footer"><strong>상태:</strong> <span class="status-${data.status}">${koreanStatus}</span></p> 
    `;
}

// -----------------------------------------------------------
// 3. 환불 액션 실행 함수

function fetchReservationRefundAction(id) {
    const url = contextPath + '/admin/reservations/refund';
    
    // NOTE: alert()와 confirm() 대신 커스텀 모달 UI를 사용해야 하지만, 현재 코드를 유지하기 위해 임시로 사용
    if (!confirm(`예매 ${id}번을 환불 처리하시겠습니까?`)) {
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
        // Controller가 리다이렉트를 반환할 때의 처리
        if (response.ok) {
            alert('환불 처리가 완료되었습니다.');
            location.reload();
        } else {
             alert('환불 요청에 실패했습니다. 서버 응답을 확인하세요.');
        }
    })
    .catch(error => {
        console.error('Fetch Error:', error);
        alert('서버 통신 오류가 발생했습니다.');
    });
}


// 4. 모달 내 환불 버튼 클릭 연결
function refundFromModal() {
    const refundBtn = document.querySelector('#reservationDetailModal .approve-btn');
    const id = refundBtn.getAttribute('data-id');
    
    if (id && !refundBtn.disabled) {
        fetchReservationRefundAction(id);
    }
}
// NOTE: window.onload 또는 DOMContentLoaded 이벤트 리스너를 추가하여 openReservationDetail 함수가 사용 가능하도록 해야 합니다.