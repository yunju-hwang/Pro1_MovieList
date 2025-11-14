<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 페이지</title>
<link rel="stylesheet" href="${ctx}/resources/css/payment.css">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

</head>
<body>

	<h1>예매 정보 확인</h1>
	<div class="payment-info">
	    <p>영화: <span id="movieTitle">불러오는 중...</span></p>
	    <p>상영관: <span id="theater">불러오는 중...</span></p>
	    <p>날짜: <span id="date">불러오는 중...</span></p>
	    <p>시간: <span id="time">불러오는 중...</span></p>
	    <p>좌석: <span id="seats">불러오는 중...</span></p>
	    <p>어른: <span id="adultCount">0</span>명 / 어린이: <span id="childCount">0</span>명</p>
	    <p>총 금액: <span id="amount">0</span>원</p>
	    
	    <button id="payBtn">결제하기</button>
	</div>
    
   
<script>
    // JSP에서 context path를 JS 변수로 전달
    const contextPath = '<c:out value="${ctx}" />';
</script>	
	
<script src="${ctx}/resources/js/payment.js"></script>
</body>
</html>