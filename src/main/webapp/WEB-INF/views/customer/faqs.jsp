<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<link rel="stylesheet" href="<c:url value='/resources/css/faqs.css'/>">
<script>
document.addEventListener("DOMContentLoaded", () => {
  const faqItems = document.querySelectorAll('.faq-item');
  faqItems.forEach(item => {
    const question = item.querySelector('.book');
    const answer = item.querySelector('.answer');
    // 요소가 존재하는지 확인 (안전하게)
    if (!question || !answer) return;
    question.addEventListener('click', () => {
      // 다른 항목 닫기 (선택 사항)
      faqItems.forEach(i => {
        if (i !== item) i.querySelector('.answer').classList.remove('open');
      });
      // 클릭한 항목 열기/닫기
      answer.classList.toggle('open');
    });
  });
});
</script>
</head>
<body>
	<h1>FAQ페이지</h1>
	<h1 class="faq">자주 묻는 질문</h1>
	<h4 class="led">MovieList 이용 중 궁금한 점을 빠르게 해결하세요</h4>

 <div class="reserve">

    <div class="faq-item">
      <p class="book">Q. 예매 취소는 어떻게 하나요?</p>
      <div class="answer">
        <p>마이페이지 &gt; 예매내역에서 취소하실 수 있습니다.  
        단, 상영 시작 직전에는 취소가 불가할 수 있습니다.</p>
      </div>
      <hr class="line">
    </div>

    <div class="faq-item">
      <p class="book">Q. 예매 확인은 어떻게 하나요?</p>
      <div class="answer">
        <p>홈페이지 또는 앱의 ‘예매 확인’ 메뉴에서 확인하실 수 있습니다.</p>
      </div>
      <hr class="line">
    </div>

    <div class="faq-item">
      <p class="book">Q. 환불 소요시간은 얼마나 걸리나요?</p>
      <div class="answer">
        <p>결제 수단에 따라 다르며, 신용카드는 영업일 기준 3~5일 정도 소요됩니다.</p>
      </div>
      <hr class="line">
    </div>

    <div class="faq-item">
      <p class="book">Q. 결제 수단은 무엇이 있나요?</p>
      <div class="answer">
        <p>신용카드, 체크카드, 간편결제(카카오페이, 네이버페이 등)를 지원합니다.</p>
      </div>
    </div>

  </div>



	<div class="inquirey">
	<p class="want"> 원하는 답변을 찾지 못하셨나요?</p>
	<a href="/movielist/customer/write_inquiry" class="inq">1:1 문의하기 -></a>
	</div>

</body>
</html>