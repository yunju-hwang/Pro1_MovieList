<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매 완료</title>
<link rel="stylesheet" href="${ctx}/resources/css/complete.css">
</head>
<body>

<div class="complete-container">
    <h1>예매 완료!</h1>

    <div class="reservation-details">
        <h2>예매 상세 내역</h2>
        <p>영화: <span id="movieTitle"></span></p>
        <p>상영관: <span id="theater"></span></p>
        <p>날짜/시간: <span id="dateTime"></span></p>
        <p>좌석: <span id="seats"></span></p>
        <p>어른: <span id="adultCount"></span>명 / 어린이: <span id="childCount"></span>명</p>
        <p>총 금액: <span id="totalPrice"></span>원</p>
    </div>

    <div class="buttons">
        <button onclick="window.location.href='${ctx}/'">메인으로</button>
        <button onclick="window.location.href='${ctx}/mypage/reservations'">마이페이지</button>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", () => {
    // localStorage / sessionStorage에서 데이터 가져오기
    const movieTitle  = localStorage.getItem("title");
    const theater = localStorage.getItem("selectedTheater");
    const date = localStorage.getItem("selectedDate");
    const time = localStorage.getItem("selectedTime");
    const seats = JSON.parse(sessionStorage.getItem("selectedSeats") || "[]");
    const adultCount = parseInt(sessionStorage.getItem("adultCount") || 0);
    const childCount = parseInt(sessionStorage.getItem("childCount") || 0);
    const totalPrice = parseInt(sessionStorage.getItem("totalPrice") || 0);


    // 화면에 표시
    document.getElementById("movieTitle").textContent = movieTitle;
    document.getElementById("theater").textContent = theater;
    document.getElementById("dateTime").textContent = date + " " + time;
    document.getElementById("seats").textContent = seats.join(", ");
    document.getElementById("adultCount").textContent = adultCount;
    document.getElementById("childCount").textContent = childCount;
    document.getElementById("totalPrice").textContent = totalPrice;

});
</script>

</body>
</html>