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


	// 결제 버튼 클릭 시
    payBtn.addEventListener("click", () => {
    
    	 // 1. 아임포트 객체 초기화
	    const IMP = window.IMP;
	    IMP.init("imp35667677"); // 본인 아임포트 가맹점 식별코드로 변경
	    
	    // 2. 결제 요청(데이터)
        IMP.request_pay({
            pg: "kakaopay", // 또는 html5_inicis, toss 등
            pay_method: "card",
            merchant_uid: "order_" + new Date().getTime(), // 고유 주문번호
            name: movieTitle,
            amount: totalPrice,  //금액 
            buyer_email: "user@example.com",
            buyer_name: "홍길동",
            buyer_tel: "010-1234-5678",
        }, function (rsp) { // callback
        	
        	// 3. 결제 성공 (백엔드 검증 요청)
            if (rsp.success) {
                alert("결제 성공! 결제번호: " + rsp.imp_uid);
                
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
			            paymentMethodId: 1 // 결제 수단 ID
                	}
                
                
                };

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
                        alert("서버 검증 완료 및 예매 성공!");
                        window.location.href = "/booking/success";
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
