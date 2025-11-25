<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/write_movie_request.css'/>">
<script>
  function changePlaceholder(value) {
    const input = document.getElementById("textInput");
    if (value === "direct") {
      // 직접 입력 선택 → input 활성화
      input.value = "";
      input.placeholder = "직접 입력하세요";
      input.readOnly = false;
      input.focus();
    } else {
      // 일반 장르 선택 → input 값 변경 + 비활성화
      input.value = value;
      input.readOnly = true;
    }
  }
</script>

</head>
<body>
	<h1 class="title">영화 등록 요청</h1>
	<h4 class="sub-title">보고 싶으신 영화를 요청해주시면 검토 후 등록해 드립니다</h4>
	<form action="${pageContext.request.contextPath }/customer/write_movie_request_pro" method="post">
	<div class="container">
		<p class="unity">영화 제목 *</p>
		<div class="text-con">
			<input type="text" placeholder="영화 제목을 입력하세요" class="text" required name="title">
		</div>
<!-- 		<p class="unity">장르*</p> -->

<div class="input-row">
  <!-- 장르 선택 -->
<!--   <div class="input-dropdown"> -->
<!--     <input type="text" id="textInput" placeholder="액션" readonly required> -->
<!--     <select id="selectBox" onchange="changePlaceholder(this.value)"> -->
<!--       <option value="">액션</option> -->
<!--       <option value="코미디">코미디</option> -->
<!--       <option value="드라마">드라마</option> -->
<!--       <option value="로맨스">로맨스</option> -->
<!--       <option value="스릴러">스릴러</option> -->
<!--       <option value="공포">공포</option> -->
<!--       <option value="SF(공상과학)">SF(공상과학)</option> -->
<!--       <option value="판타지">판타지</option> -->
<!--       <option value="미스터리">미스터리</option> -->
<!--       <option value="느와르">느와르</option> -->
<!--       <option value="역사">역사</option> -->
<!--       <option value="재난">재난</option> -->
<!--       <option value="애니메이션">애니메이션</option> -->
<!--       <option value="직접입력">직접입력</option> -->
<!--     </select> -->
<!--   </div> -->

  <!-- 날짜 선택 -->
<!--   <div class="date-picker"> -->
<!--     <label for="dateInput">날짜</label> -->
<!--     <input type="date" id="dateInput" max="" required> -->
<!--   </div> -->
</div>
  <p class="unity">요청 사항 *</p>
		<div class="text-con">
			<textarea rows="5" cols="40" placeholder="이 영화를 등록하길 요청하시는 사유를 작성해 주세요" class="textarea" name="content"></textarea>
		</div>

	<div class="notification">
		<p class="not-title">안내사항</p>
		<ul class="ul">
			<li class="not">요청하신 영화는 검토 후 등록 여부를 알려드립니다</li>
			<li class="not">이미 등록된 영화는 중복 등록되지 않습니다</li>
			<li class="not">영화등록 요청 결과는 마이페이지에서 확인 가능합니다</li>
		</ul>
	</div>

	<div class="standard">
		<p class="sta-title">영화 등록 기준</p>
<div class="standard-con">
  <div class="standard-group">
    <h1>등록 가능</h1>
    <ul>
      <li class="sta">정식 개봉한 극장 영화</li>
      <li class="sta">OTT 오리지널 영화</li>
    </ul>
  </div>

  <div class="standard-group">
    <h1>등록 불가</h1>
    <ul>
      <li class="sta">비공식 루트 영화</li>
      <li class="sta">청소년 관람불가 영화</li>
    </ul>
  </div>
</div>
	</div>

<div class="btn-form">
  <input type="submit" value="취소하기" class="no-sub">
  <input type="submit" value="요청하기" class="sub">
</div>
</form>






	</div>
</body>
</html>