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

	<div class="payment-content-container">
	<h1>예매 정보 확인</h1>
	<div class="payment-info">
	    <p>영화: <span id="movieTitle">불러오는 중...</span></p>
	    <p>상영관: <span id="theater">불러오는 중...</span></p>
	    <p>날짜: <span id="date">불러오는 중...</span></p>
	    <p>시간: <span id="time">불러오는 중...</span></p>
	    <p>좌석: <span id="seats">불러오는 중...</span></p>
	    <p>어른: <span id="adultCount">0</span>명 / 어린이: <span id="childCount">0</span>명</p>
	    <p>총 금액: <span id="amount">0</span>원</p>
	    
	    <!-- 결제 수단 선택 UI 추가 -->
	    <!-- 결제 수단 선택 UI (라디오 버튼) -->
		<div class="payment-method">
		    <p>결제 수단 선택:</p>
		       <!-- 신용/체크카드 -->
		    <div class="payment-box">
		        <label class="payment-option">
		            <input type="radio" name="paymentMethod" value="uplus" checked>
		            <span class="icon">💳</span>
		            <span>신용/체크카드</span>
		        </label>
		    </div>
		     <!-- 간편결제 -->
		     <h3 class="category-title">⚡ 간편결제</h3>
		    <div class="payment-box">
		        <label class="payment-option">
		            <input type="radio" name="paymentMethod" value="kakaopay">
		            <img src="../resources/img/kakaopay.png" class="pay-icon"/>
		            <span>카카오페이</span>
		        </label>
		    </div>

		    <div class="payment-box">
		        <label class="payment-option">
		            <input type="radio" name="paymentMethod" value="tosspay">
		            <img src="../resources/img/tosspay.png" class="pay-icon"/>
		            <span>토스페이</span>
		        </label>
		    </div>

		    <div class="payment-box">
		        <label class="payment-option">
		            <input type="radio" name="paymentMethod" value="payco">
		            <img src="../resources/img/payco.png" class="pay-icon"/>
		            <span>페이코/기타 PG</span>
		        </label>
		    </div>
		</div>
		
		<div class="terms">
	    <label>
	        <input type="checkbox" id="agreeTerms">
	        결제 및 개인정보 처리방침에 동의합니다.
	    </label>
		</div>
	    
	    <button id="payBtn">결제하기</button>
	</div>
   </div> 
   
<script>
    // JSP에서 context path를 JS 변수로 전달
    const contextPath = '<c:out value="${ctx}" />';
</script>	
	
<script src="${ctx}/resources/js/payment.js"></script>
</body>
</html>