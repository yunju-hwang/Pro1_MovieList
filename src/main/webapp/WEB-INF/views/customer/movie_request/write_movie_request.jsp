<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/write_movie_request.css?after'/>">
<script>
  // ===== 장르 선택 =====
  function changePlaceholder(value) {
    const select = document.getElementById("selectBox");
    const input = document.getElementById("textInput");
    const option = select.options[select.selectedIndex];
    const placeholder = option.dataset.placeholder || "직접입력";

    input.value = placeholder;
    if (placeholder === "직접입력") {
      input.removeAttribute("readonly");
      input.classList.add("editable");
      input.focus();
    } else {
      input.setAttribute("readonly", true);
      input.classList.remove("editable");
    }
  }

  // ===== 날짜 선택 (오늘 이후 선택 불가) =====
  const dateInput = document.getElementById("dateInput");

  // 오늘 날짜 계산 (YYYY-MM-DD)
  const today = new Date();
  const yyyy = today.getFullYear();
  const mm = String(today.getMonth() + 1).padStart(2, "0");
  const dd = String(today.getDate()).padStart(2, "0");
  const todayStr = `${yyyy}-${mm}-${dd}`;

  // 오늘까지만 선택 가능
  dateInput.setAttribute("max", todayStr);
  dateInput.value = todayStr;

  // 사용자가 오늘 이후 날짜를 선택하려 하면 강제로 막기
  dateInput.addEventListener("input", function () {
    const selectedDate = new Date(this.value);
    const selectedStr = this.value;

    if (selectedDate > today) {
      alert("오늘 이후 날짜는 선택할 수 없습니다.");
      this.value = todayStr; // 다시 오늘로 돌리기
    }

    // 한국어 포맷으로 콘솔 출력
    if (selectedStr) {
      const d = new Date(this.value);
      console.log(`${d.getFullYear()}년 ${d.getMonth() + 1}월 ${d.getDate()}일`);
    }
  });

  // 수동 입력(복사/붙여넣기) 방지도 추가
  dateInput.addEventListener("change", function () {
    const selectedDate = new Date(this.value);
    if (selectedDate > today) {
      alert("오늘 이후 날짜는 선택할 수 없습니다.");
      this.value = todayStr;
    }
  });
</script>

</head>
<body>
	<h1 class="title">영화 등록 요청</h1>
	<h4 class="sub-title">보고 싶으신 영화를 요청해주시면 검토 후 등록해 드립니다</h4>
	<div class="container">
		<p class="unity">영화 제목 *</p>
		<div class="text-con">
			<input type="text" placeholder="영화 제목을 입력하세요" class="text">
		</div>
		<p class="unity">장르*</p>
		
<div class="input-row">
  <!-- 장르 선택 -->
  <div class="input-dropdown">
    <input type="text" id="textInput" placeholder="액션" readonly>
    <select id="selectBox" onchange="changePlaceholder(this.value)">
      <option value="">액션</option>
      <option value="1" data-placeholder="코미디">코미디</option>
      <option value="2" data-placeholder="드라마">드라마</option>
      <option value="3" data-placeholder="로맨스">로맨스</option>
      <option value="4" data-placeholder="스릴러">스릴러</option>
      <option value="5" data-placeholder="공포">공포</option>
      <option value="6" data-placeholder="SF(공상과학)">SF(공상과학)</option>
      <option value="7" data-placeholder="판타지">판타지</option>
      <option value="8" data-placeholder="미스터리">미스터리</option>
      <option value="9" data-placeholder="느와르">느와르</option>
      <option value="10" data-placeholder="역사">역사</option>
      <option value="11" data-placeholder="재난">재난</option>
      <option value="12" data-placeholder="애니메이션">애니메이션</option>
      <option value="13" data-placeholder="직접입력">직접입력</option>
    </select>
  </div>

  <!-- 날짜 선택 -->
  <div class="date-picker">
    <label for="dateInput">날짜</label>
    <input type="date" id="dateInput" max="">
  </div>
</div>
  <p class="unity">요청 사항 *</p>
		<div class="text-con">
			<textarea rows="5" cols="40" placeholder="이 영화를 등록하길 요청하시는 사유를 작성해 주세요" class="textarea"></textarea>
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
	
	
	
	
	
	
	
	</div>
</body>
</html>