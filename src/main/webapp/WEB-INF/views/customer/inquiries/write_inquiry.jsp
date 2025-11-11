<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터/문의 작성하기</title>
<link rel="stylesheet" href="<c:url value='/resources/css/write_inquiry.css'/>">
<script>
function changePlaceholder(value) {
  const select = document.getElementById('selectBox');
  const input = document.getElementById('textInput');

  const selectedOption = select.options[select.selectedIndex];
  const newPlaceholder = selectedOption.getAttribute('data-placeholder');

  input.placeholder = newPlaceholder || '예매/결제';

  // 입력 가능 여부 조정
  if (value === "4") {
    input.removeAttribute('readonly');
    input.classList.add('editable');
    input.focus();
  } else {
    input.setAttribute('readonly', true);
    input.classList.remove('editable');
    input.value = "";
  }
}
</script>
</head>
<body>
	<h1 class="title">1:1 문의</h1>
	<h4 class="title1">궁금한 사항을 남겨주시면 빠르게 답변 드리겠습니다</h4>
	<div class="container">
		<p class="unity">문의 유형 *</p>
<div class="input-dropdown">
  <input type="text" id="textInput" placeholder="예매/결제" readonly>
  <select id="selectBox" onchange="changePlaceholder(this.value)">
    <option value="">예매/결제</option>
    <option value="1" data-placeholder="회원정보">회원정보</option>
    <option value="2" data-placeholder="영화정보">영화정보</option>
    <option value="3" data-placeholder="기술지원">기술지원</option>
    <option value="4" data-placeholder="직접입력">직접입력</option>
  </select>
</div>
	<p class="unity">문의 제목 *</p>
	<div class="text-con">
	<input type="text" placeholder="문의 제목을 입력하세요" class="text">
</div>

<p class="unity">이메일 주소 *</p>
<div class="text-con">
<input type="email" placeholder="답변 받으실 이메일 주소를 입력하세요" class="text">
</div>
<p class="under">답변은 입력하신 이메일및 마이페이지에서 확인 가능합니다</p>

<p class="unity">문의 내용 *</p>

<div class="text-con">
	<input type="text" placeholder="문의 내용을 입력하세요" class="text">
</div>

<p class="under">최소 10자 이상 작성해주세요</p>

<div class="notification">
	<h1 class="not-title">안내사항</h1>
	<ul class="listcon">
		<li class="list">영업일 기준 24시간 이내 답변 드립니다</li>
		<li class="list">주말/공휴일 문의는 다음 영업일에 순차적으로 답변드립니다</li>
		<li class="list">긴급한 사항은 고객센터(1588-0000)로 연락바랍니다</li>
	</ul>
</div>
	</div>
	
	<div class="faq-con">
		<p>자주 묻는 질문을 확인해보셨나요?</p>
		<a href="/movielist/customer/faqs" class="faq">faq 바로가기 -></a>
	</div>
	
</body>
</html>