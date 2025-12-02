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
	    <button type="button" id="showTermsBtn">보기</button>
		</div>
		
		<!-- 모달 구조 -->
		<div id="termsModal" class="modal" style="display:none;">
		    <div class="modal-content">
		        <span class="close">&times;</span>
		        <h2>[결제 및 개인정보 처리방침]</h2>
		        <p>1. 결제 정보 수집 및 이용</p>
				<p>- 예매하신 영화, 상영관, 날짜, 시간, 좌석, 결제 금액 등의 정보는 결제 처리 및 예매 확인을 위해 수집됩니다.</p>
				<p>- 수집된 정보는 결제 완료 후 예매 내역 확인, 환불 처리 등 제한된 용도로만 사용됩니다.</p>
				
				<p>2. 개인정보 수집 항목</p>
				<p>- 필수: 이름, 전화번호, 이메일</p>
				<p>- 선택: 마케팅 수신 여부</p>
				
				<p>3. 개인정보 보유 및 이용 기간</p>
				<p>- 결제 및 예매 확인 목적 달성 시까지 보유</p>
				<p>- 관련 법령에 따라 필요한 경우 별도로 보관 가능</p>
				
				<p>4. 이용자 권리</p>
				<p>- 이용자는 언제든지 개인정보 열람, 정정, 삭제를 요청할 수 있습니다.</p>
				<p>- 요청 시 고객센터 또는 개인정보관리 책임자에게 문의하시기 바랍니다.</p>
				
				<p>5. 결제 취소 및 환불</p>
				<p>- 결제 취소 및 환불은 상영 시작 전까지 가능하며, 결제 수단 및 정책에 따라 처리됩니다.</p>
				
				<p>본 약관에 동의하셔야 결제를 진행할 수 있습니다.</p>
		        
		    </div>
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