document.addEventListener("DOMContentLoaded", () => {
    // 영화 정보 표시
    const theater = localStorage.getItem("selectedTheater") || "없음";
    const date = localStorage.getItem("selectedDate") || "없음";
    const time = localStorage.getItem("selectedTime") || "없음";
    const title = localStorage.getItem("title") || "없음";
    const tmdbId = localStorage.getItem("tmdbId");
    const theaterId = localStorage.getItem("selectedTheaterId");

    document.getElementById("theaterDisplay").textContent = theater;
    document.getElementById("dateDisplay").textContent = date;
    document.getElementById("timeDisplay").textContent = time;
    document.getElementById("titleDisplay").textContent = title;
    

    // 좌석
    const seats = document.querySelectorAll(".seat");
    const selectedSeatsDisplay = document.getElementById("selectedSeats");
    const totalPriceDisplay = document.getElementById("totalPrice");
    const confirmSeatsBtn = document.getElementById("confirmSeats"); 
    
    const selectedSeats = new Set();

    // 예약된 좌석 가져오기
    const screeningTime = date + "T" + time + ":00";
    fetch(`${ctx}/reservation/seatReserved?tmdbId=${tmdbId}&theaterId=${theaterId}&screeningTime=${screeningTime}`)
        .then(res => res.json())
        .then(reservedSeats => {
            reservedSeats.forEach(seatCode => {
                const seat = document.querySelector(`.seat[data-seat="${seatCode}"]`);
                if (seat) seat.classList.add("reserved"); // 시각적 표시
            });
        })
        .catch(err => console.error("예약 좌석 가져오기 실패:", err));

    // 관람 인원 초기값
    let adultCount = 1;
    let childCount = 0;
    let totalSeatsToSelect = adultCount + childCount;

    const adultInput = document.getElementById("adultCount");
    const childInput = document.getElementById("childCount");
    const confirmAudienceBtn = document.getElementById("confirmAudience");
    const resetSeatsBtn = document.getElementById("resetSeats");

    let seatsEnabled = false;
    let autoGroupsSelected = 0; // 자동 2좌석 그룹 선택 수
    let manualSelected = false; // 남는 1좌석 수동 선택 여부

    confirmAudienceBtn.addEventListener("click", () => {
        adultCount = parseInt(adultInput.value) || 0;
        childCount = parseInt(childInput.value) || 0;
        totalSeatsToSelect = adultCount + childCount;

        if (totalSeatsToSelect === 0) {
            alert("적어도 한 명 이상 선택해야 합니다!");
            return;
        }

        alert(`어른 ${adultCount}명, 어린이 ${childCount}명. 이제 좌석 선택 가능합니다.`);
        seatsEnabled = true;
        autoGroupsSelected = 0;
        manualSelected = false;
        selectedSeats.clear();
        seats.forEach(s => s.classList.remove("selected"));
        updateSeatDisplay();
        
    });

    // 좌석 클릭 이벤트
    seats.forEach(seat => {
        seat.addEventListener("click", () => {
            if (!seatsEnabled) {
                alert("먼저 인원을 확인해주세요!");
                return;
            }
            if (seat.classList.contains("reserved")) {
                alert("이미 예약된 좌석입니다");
                return;
            }

            const seatId = seat.dataset.seat;
            const row = seatId.charAt(0);
            const num = parseInt(seatId.substring(1));

            const groupCount = Math.floor(totalSeatsToSelect / 2);
            const remainder = totalSeatsToSelect % 2;

            // 자동 2좌석 선택
            if (autoGroupsSelected < groupCount) {
                const pair1 = `${row}${num}`;
                const pair2 = `${row}${num + 1}`;
                const s1 = document.querySelector(`.seat[data-seat="${pair1}"]`);
                const s2 = document.querySelector(`.seat[data-seat="${pair2}"]`);

                if (!s1 || !s2 || s1.classList.contains("reserved") || s2.classList.contains("reserved")) {
                    alert("연속된 2개 좌석이 없습니다.");
                    return;
                }

                // 첫 자동 선택 시 기존 선택 초기화
                if (autoGroupsSelected === 0 && !manualSelected) {
                    selectedSeats.clear();
                    seats.forEach(s => s.classList.remove("selected"));
                }

                s1.classList.add("selected");
                s2.classList.add("selected");
                selectedSeats.add(pair1);
                selectedSeats.add(pair2);

                autoGroupsSelected++;
                updateSeatDisplay();
                return;
            }

            // 남는 1좌석 수동 선택
            if (remainder === 1 && !manualSelected) {
                selectedSeats.add(seatId);
                seat.classList.add("selected");
                manualSelected = true;
                updateSeatDisplay();
                return;
            }

            alert("선택 가능한 좌석 수를 모두 선택했습니다.");
            updateSeatDisplay();
		   
           
        });
    });

    resetSeatsBtn.addEventListener("click", () => {
        selectedSeats.clear();
        autoGroupsSelected = 0;
        manualSelected = false;
        seats.forEach(s => s.classList.remove("selected"));
        updateSeatDisplay();
    });

    function updateSeatDisplay() {
        selectedSeatsDisplay.textContent = Array.from(selectedSeats).join(", ");
        const total = adultCount * 15000 + childCount * 10000;
        totalPriceDisplay.textContent = total;
        // 확인 버튼 활성/비활성
	    const isEnabled = selectedSeats.size === totalSeatsToSelect;
	    confirmSeatsBtn.disabled = !isEnabled;
	 
    }
    
     // 확인 버튼 클릭
    const confirmBtn = document.getElementById("confirmSeats");
    confirmBtn.addEventListener("click", () => {
        if(selectedSeats.size !== totalSeatsToSelect){
            alert(`좌석 선택 수가 인원 수와 일치하지 않습니다. 총 ${totalSeatsToSelect}개 선택 필요.`);
            return;
        }

        sessionStorage.setItem("selectedSeats", JSON.stringify(Array.from(selectedSeats)));
        sessionStorage.setItem("adultCount", adultCount);
        sessionStorage.setItem("childCount", childCount);
        sessionStorage.setItem("totalPrice", totalPriceDisplay.textContent);

        alert(`좌석 선택 완료! 총 금액: ${totalPriceDisplay.textContent}원`);
        // 다음 페이지 이동 가능
        window.location.href = `${ctx}/reservation/payment`;
        
    });
});
