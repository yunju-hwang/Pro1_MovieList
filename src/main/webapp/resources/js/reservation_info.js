document.addEventListener("DOMContentLoaded", () => {
    const regions = document.querySelectorAll(".region-list li");
    const theaters = document.querySelectorAll(".theater-card");
    const selectedDate = document.getElementById("selectedDate");
    const selectedTime = document.getElementById("selectedTime");
    
    // 선택 요약 영역
    const summaryTheater = document.getElementById("summaryTheater");
    const summaryDate = document.getElementById("summaryDate");
    const summaryTime = document.getElementById("summaryTime");
    
    // 다음 버튼
    const nextButton = document.querySelector(".btn-submit");

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
            const theaterName = t.textContent;
            summaryTheater.textContent = theaterName;
            theaters.forEach(tc => tc.classList.remove("active"));
            t.classList.add("active");

            // 날짜 선택 영역 표시
            const wrapper = document.getElementById("datePickerWrapper");
            const dateButtons = document.getElementById("dateButtons");
            wrapper.style.display = "block";
            dateButtons.innerHTML = "";

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
                btn.setAttribute("data-value", d.toISOString().split("T")[0]);

                btn.addEventListener("click", function() {
                    document.querySelectorAll(".date-btn").forEach(b => b.classList.remove("active"));
                    this.classList.add("active");
                    selectedDate.value = this.getAttribute("data-value");
                    summaryDate.textContent = this.textContent;

                    const timeWrapper = document.getElementById("timePickerWrapper");
                    const timeButtons = document.getElementById("timeButtons");
                    timeWrapper.style.display = "block";
                    timeButtons.innerHTML = "";

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
                            summaryTime.textContent = this.textContent;
                        });

                        timeButtons.appendChild(timeBtn);
                    });
                });

                dateButtons.appendChild(btn);
            }

            // 선택 정보를 LocalStorage에 저장 (영화관 이름)
            localStorage.setItem("selectedTheater", theaterName);
        });
    });

    // 날짜 선택 시 LocalStorage에 저장
    selectedDate.addEventListener("change", () => {
        localStorage.setItem("selectedDate", selectedDate.value);
    });

    // 시간 선택 시 LocalStorage에 저장
    selectedTime.addEventListener("change", () => {
        localStorage.setItem("selectedTime", selectedTime.value);
    });

    // '다음' 버튼 클릭
    nextButton.addEventListener("click", () => {
        const date = selectedDate.value;
        const time = selectedTime.value;
        const tmdbId = document.getElementById("tmdbId").value;
        const title = document.getElementById("title").textContent;

        if (!localStorage.getItem("selectedTheater") || !date || !time) {
            alert("상영관, 날짜, 시간을 모두 선택해주세요!");
            return;
        }

        // LocalStorage에 영화 정보 저장
        localStorage.setItem("selectedDate", date);
        localStorage.setItem("selectedTime", time);
        localStorage.setItem("tmdbId", tmdbId);
        localStorage.setItem("title", title);

        // seat.jsp로 이동 (URL에 파라미터 없이)
        window.location.href = `${ctx}/reservation/seat`;
    });
});
