document.addEventListener("DOMContentLoaded", () => {
    // 영화 정보 표시
    const theater = localStorage.getItem("selectedTheater") || "없음";
    const date = localStorage.getItem("selectedDate") || "없음";
    const time = localStorage.getItem("selectedTime") || "없음";
    const title = localStorage.getItem("title") || "없음";

    document.getElementById("theaterDisplay").textContent = theater;
    document.getElementById("dateDisplay").textContent = date;
    document.getElementById("timeDisplay").textContent = time;
    document.getElementById("titleDisplay").textContent = title;

    // 좌석 선택
    const seats = document.querySelectorAll(".seat");
    const selectedSeatsDisplay = document.getElementById("selectedSeats");
    const totalPriceDisplay = document.getElementById("totalPrice");
    const selectedSeats = new Set();

    let adultCount = 1;
    let childCount = 0;
    let totalSeatsToSelect = adultCount + childCount;

    const adultInput = document.getElementById("adultCount");
    const childInput = document.getElementById("childCount");
    const confirmAudienceBtn = document.getElementById("confirmAudience");

    // 관람 인원 확인 버튼
    confirmAudienceBtn.addEventListener("click", () => {
        adultCount = parseInt(adultInput.value) || 0;
        childCount = parseInt(childInput.value) || 0;
        totalSeatsToSelect = adultCount + childCount;

        if(totalSeatsToSelect === 0){
            alert("적어도 한 명 이상 선택해야 합니다!");
            return;
        }

        alert(`어른 ${adultCount}명, 어린이 ${childCount}명. 이제 좌석 선택 가능합니다.`);
    });

    // 좌석 클릭
    seats.forEach(seat => {
        const seatId = seat.dataset.seat;

        seat.addEventListener("click", () => {
            if(selectedSeats.has(seatId)){
                selectedSeats.delete(seatId);
                seat.classList.remove("selected");
            } else {
                if(selectedSeats.size >= totalSeatsToSelect){
                    alert(`좌석은 총 ${totalSeatsToSelect}개까지 선택 가능합니다.`);
                    return;
                }
                selectedSeats.add(seatId);
                seat.classList.add("selected");
            }

            selectedSeatsDisplay.textContent = selectedSeats.size > 0 
                ? Array.from(selectedSeats).join(", ") 
                : "없음";

            // 가격 계산
            let total = adultCount * 15000 + childCount * 10000;
            totalPriceDisplay.textContent = total;
        });
    });

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
