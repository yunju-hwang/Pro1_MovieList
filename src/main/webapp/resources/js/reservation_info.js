document.addEventListener("DOMContentLoaded", () => {
    const regions = document.querySelectorAll(".region-list li");
    const theaters = document.querySelectorAll(".theater-card");
    const selectedInput = document.getElementById("selectedTheater");
    const selectedDate = document.getElementById("selectedDate");
    const selectedTime = document.getElementById("selectedTime");

    // 선택 요약 영역
    const summaryTheater = document.getElementById("summaryTheater");
    const summaryDate = document.getElementById("summaryDate");
    const summaryTime = document.getElementById("summaryTime");

    // 초기: 모든 영화관 숨김
    theaters.forEach(t => t.style.display = "none");

    // 지역 선택 시 해당 영화관 표시
    regions.forEach(region => {
        region.addEventListener("click", () => {
            regions.forEach(r => r.classList.remove("active"));
            region.classList.add("active");

            const activeRegion = region.dataset.location;
            theaters.forEach(t => {
                t.style.display = (t.dataset.location === activeRegion) ? "block" : "none";
            });
        });
    });

    // 영화관 클릭 시 선택
    theaters.forEach(t => {
        t.addEventListener("click", () => {
            selectedInput.value = t.dataset.id;
            summaryTheater.textContent = t.textContent; // 선택 요약 업데이트
            theaters.forEach(tc => tc.classList.remove("active"));
            t.classList.add("active");

            // 날짜 선택 영역 표시
            const wrapper = document.getElementById("datePickerWrapper");
            const dateButtons = document.getElementById("dateButtons");
            wrapper.style.display = "block";
            dateButtons.innerHTML = "";

            // 오늘부터 7일 버튼 생성
            const today = new Date();
            const weekdays = ["일", "월", "화", "수", "목", "금", "토"];

            for (let i = 0; i < 7; i++) {
                const d = new Date();
                d.setDate(today.getDate() + i);

                const month = String(d.getMonth() + 1).padStart(2, '0');
                const date = String(d.getDate()).padStart(2, '0');
                const day = weekdays[d.getDay()];

                const btn = document.createElement("button");
                btn.type = "button";
                btn.classList.add("date-btn");
                btn.textContent = `${month}/${date} (${day})`;

                const yyyymmdd = d.toISOString().split("T")[0];
                btn.setAttribute("data-value", yyyymmdd);

                btn.addEventListener("click", function() {
                    // 날짜 버튼 active 처리
                    document.querySelectorAll(".date-btn").forEach(b => b.classList.remove("active"));
                    this.classList.add("active");

                    // hidden input 설정
                    selectedDate.value = this.getAttribute("data-value");
                    summaryDate.textContent = this.textContent; // 선택 요약 업데이트
                    console.log("선택된 날짜:", selectedDate.value);

                    // 시간 버튼 영역 표시
                    const timeWrapper = document.getElementById("timePickerWrapper");
                    const timeButtons = document.getElementById("timeButtons");
                    timeWrapper.style.display = "block";
                    timeButtons.innerHTML = "";

                    // 임의 시간 배열
                    const times = ["10:30", "12:00", "13:30", "15:00", "16:30", "18:00", "20:30"];
                    times.forEach(time => {
                        const timeBtn = document.createElement("button");
                        timeBtn.type = "button";
                        timeBtn.classList.add("time-btn");
                        timeBtn.textContent = time;
                        timeBtn.setAttribute("data-value", time);

                        timeBtn.addEventListener("click", function() {
                            document.querySelectorAll(".time-btn").forEach(b => b.classList.remove("active"));
                            this.classList.add("active");
                            selectedTime.value = this.getAttribute("data-value");
                            summaryTime.textContent = this.textContent; // 선택 요약 업데이트
                            console.log("선택된 시간:", selectedTime.value);
                        });

                        timeButtons.appendChild(timeBtn);
                    });
                });

                dateButtons.appendChild(btn);
            }
        });
    });

    // 선택된 첫 번째 지역 자동 클릭
    const defaultRegion = Array.from(regions).find(r => r.dataset.location === "서울");
    if(defaultRegion) defaultRegion.click();
});
