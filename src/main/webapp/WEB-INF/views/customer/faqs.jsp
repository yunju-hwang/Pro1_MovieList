<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
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
	<h1 class="faq">자주 묻는 질문</h1>
	<h4 class="led">MovieList 이용 중 궁금한 점을 빠르게 해결하세요</h4>

<div class="reserve">
    <c:forEach var="faq" items="${list}">
        <div class="faq-item">
            <p class="book">Q. ${faq.question}</p>
            <div class="answer">
                <p>${faq.answer}</p>
            </div>
            <hr class="line">
        </div>
    </c:forEach>
</div>



<div class="inquirey">
    <p class="want">원하는 답변을 찾지 못하셨나요?</p>

   <c:choose>
    <c:when test="${not empty sessionScope.userId}">
        <a href="/movielist/customer/write_inquiry" class="inq">1:1 문의하기 -></a>
    </c:when>

    <c:otherwise>
        <a href="#" class="inq" onclick="alert('로그인이 필요한 서비스입니다.');  return false;">
            1:1 문의하기 ->
        </a>
    </c:otherwise>
</c:choose>
</div>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>