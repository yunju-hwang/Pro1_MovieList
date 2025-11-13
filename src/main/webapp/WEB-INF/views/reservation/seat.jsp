<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매하기(좌석선택)</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/seat.css">
</head>
<body>

 
 <h1><span id="titleDisplay">불러오는 중...</span></h1>
 <h2><span id="theaterDisplay">불러오는 중...</span> / 
     <span id="dateDisplay">불러오는 중...</span> / 
     <span id="timeDisplay">불러오는 중...</span>
 </h2>

<!-- 관람 인원 입력 -->
<div class="audience-input">
    <label>어른: <input type="number" id="adultCount" min="0" value="1"></label>
    <label>어린이: <input type="number" id="childCount" min="0" value="0"></label>
    <button id="confirmAudience">확인</button>
</div>

<div class="screen">스크린</div>

<div class="seat-container">
    <%-- 좌석 예시: A1 ~ A10, B1 ~ B10 --%>
    <% for(int row=0; row<8; row++) { %>
        <div class="seat-row">
            <% for(int col=1; col<=10; col++) { 
                String seatId = (char)('A'+row) + String.valueOf(col);
            %>
                <div class="seat" data-seat="<%=seatId%>">
                <%=seatId%>
               
                </div>
            <% } %>
        </div>
    <% } %>
</div>

<div class="selected-info">
    선택한 좌석: <span id="selectedSeats">없음</span>
    총 금액: <span id="totalPrice">0</span>원
</div>



<button id="confirmSeats">확인</button>

<!-- 서버 세션값을 JS 변수로 전달 -->
<script>
    const theater = '<%= session.getAttribute("selectedTheater") %>';
    const date = '<%= session.getAttribute("selectedDate") %>';
    const time = '<%= session.getAttribute("selectedTime") %>';
    const tmdbId = '<%= session.getAttribute("tmdbId") %>';
    const title = '<%= session.getAttribute("title") %>';
</script>

<script>
    const ctx = '<%= request.getContextPath() %>';
</script>

<script src="${pageContext.request.contextPath}/resources/js/seat.js"></script>
</body>
</html>