document.addEventListener("DOMContentLoaded", () => {
	// localStorage에서 값 가져오기 
	const movieTitle  = localStorage.getItem("title");
    const theater = localStorage.getItem("selectedTheater");
    const date = localStorage.getItem("selectedDate");
    const time = localStorage.getItem("selectedTime");
    const theaterId = parseInt(localStorage.getItem("selectedTheaterId"));
    
    
    
    
    // 백엔드에 전달해 주는 용도 (tmdb id)
    const tmdbId = localStorage.getItem("tmdbId");
   // screeningTime 만들기
	const screeningTime = date + "T" + time + ":00";
    
    //SessionStoarage에서 값 가져오기
	const adultCount = parseInt(sessionStorage.getItem("adultCount")||0);
	const childCount = parseInt(sessionStorage.getItem("childCount")||0); 
	const seats = JSON.parse(sessionStorage.getItem("selectedSeats")||"[]"); 
	const totalPrice = parseInt(sessionStorage.getItem("totalPrice")||0,10); 
	    

	// modal창 제어
	const showBtn = document.getElementById("showTermsBtn");
    const modal = document.getElementById("termsModal");
    const closeBtn = modal.querySelector(".close");
    
	// 받아온 세션값 화면에 표시
    document.getElementById("movieTitle").textContent = movieTitle;
    document.getElementById("theater").textContent = theater;
    document.getElementById("date").textContent = date;
    document.getElementById("time").textContent = time;
    document.getElementById("seats").textContent = seats.join(", ");
    document.getElementById("adultCount").textContent = adultCount;
    document.getElementById("childCount").textContent = childCount;
    document.getElementById("amount").textContent = totalPrice;
    
    // 결제 버튼
    const payBtn = document.getElementById("payBtn");
	
	
	// 보기 버튼 클릭 → 모달 열기
    showBtn.addEventListener("click", () => {
        modal.style.display = "block";
    });
    
    // X 버튼 클릭 → 모달 닫기
    closeBtn.addEventListener("click", () => {
        modal.style.display = "none";
    });
    
     // 모달 외부 클릭 → 닫기
    window.addEventListener("click", (e) => {
        if (e.target === modal) {
            modal.style.display = "none";
        }
    });
	

	// 결제 버튼 클릭 시
    payBtn.addEventListener("click", (e) => {
    	const agreeTerms = document.getElementById("agreeTerms");
    	
    	if (!agreeTerms || !agreeTerms.checked) {
	        alert("결제 및 개인정보 처리방침에 동의하셔야 합니다.");
	        e.preventDefault(); // 혹시 form 제출이 있으면 막음
	        return; // 결제 진행 중지
    	}
	    
    	 // 1. 아임포트 객체 초기화
	    const IMP = window.IMP;
	    IMP.init("imp35667677"); // 본인 아임포트 가맹점 식별코드로 변경
	    
	    // 사용자가 선택한 pg 가져오기
	    const pg = document.querySelector('input[name="paymentMethod"]:checked').value;
	    
	       // pg -> paymentMethodId 매핑
	    let paymentMethodId;
	    switch(pg) {
	        case "uplus": paymentMethodId = 1; break;
	        case "kakaopay": paymentMethodId = 2; break;
	        case "tosspay": paymentMethodId = 3; break;
	        case "payco": paymentMethodId = 4; break;
	        default: paymentMethodId = 1;
	    }
	    
	    
	    // 2. 결제 요청(데이터)
        IMP.request_pay({
            pg: pg, // html5_inicis, toss 등
            pay_method: "card", // 실제 결제 수단은 카드로 고정
            merchant_uid: "order_" + new Date().getTime(), // 고유 주문번호
            name: movieTitle,
            amount: totalPrice,  //금액 
            buyer_email: "user@example.com",
            buyer_name: "홍길동",
            buyer_tel: "010-1234-5678",
        }, function (rsp) { // callback
        	
        	// 3. 결제 성공 (백엔드 검증 요청)
            if (rsp.success) {
               const seats = JSON.parse(sessionStorage.getItem("selectedSeats") || "[]");
                console.log(seats);
                const payload = {
                	reservation: {
                		userId: localStorage.getItem("userId"),
                		tmdbId: parseInt(tmdbId),
                		theaterId: theaterId,
                		screeningTime: screeningTime,
                		seat: seats.join(","),
                		adultPeople: adultCount,
                		childPeople: childCount
                	},
                	payment: {
                		merchantUid: rsp.merchant_uid,
			            impUid: rsp.imp_uid,
			            amount: totalPrice,
			            paymentMethodId: paymentMethodId // 결제 수단 ID
                	},
                
                	
                
                };
				console.log(seats);
				console.log(JSON.stringify(payload));
				
                // 서버로 결제정보 전달 (검증용)
                fetch(`${contextPath}/payment/verify`, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify(payload)
                })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                      
                        setTimeout(() => {
						        window.location.href = contextPath + "/reservation/complete";
						    }, 100); // 0.1초 지연
                    } else {
                        alert("서버 검증 실패");
                    }
                });
            } else {
                alert("결제 실패: " + rsp.error_msg);
            }
        });
    });
});
