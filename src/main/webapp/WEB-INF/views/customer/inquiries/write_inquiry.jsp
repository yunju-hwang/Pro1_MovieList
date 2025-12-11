<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터/문의 작성하기</title>
<link rel="stylesheet" href="<c:url value='/resources/css/write_inquiry.css?after'/>">
</head>
<body>
	<c:choose>
    <c:when test="${mode == 'update'}">
        <h1 class="title">1:1 문의 수정</h1>
        <h4 class="title1">문의 내용을 수정할 수 있습니다</h4>
    </c:when>
    <c:otherwise>
        <h1 class="title">1:1 문의</h1>
        <h4 class="title1">궁금한 사항을 남겨주시면 빠르게 답변 드리겠습니다</h4>
    </c:otherwise>
</c:choose>
<form action="<c:choose>
                <c:when test='${mode == "update"}'>
                    ${pageContext.request.contextPath}/customer/inquiry_update_pro
                </c:when>
                <c:otherwise>
                    ${pageContext.request.contextPath}/customer/write_inquiry_pro
                </c:otherwise>
              </c:choose>"
      method="post">

<!-- 수정 시 id hidden 전달 -->
<c:if test="${mode == 'update'}">
    <input type="hidden" name="id" value="${inq.id}">
</c:if>

<p class="unity">문의 제목 *</p>
<div class="text-con">
    <input type="text"
           placeholder="문의 제목을 입력하세요"
           class="text"
           required
           name="title"
           value="${inq.title}">
</div>

<p class="unity">문의 내용 *</p>
<div class="text-con">
    <textarea cols="40" rows="10"
              placeholder="문의 내용을 입력하세요"
              class="text"
              required
              name="content">${inq.content}</textarea>
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

<div class="btn-form">
    <input type="button" value="취소하기" class="no-sub"
           onclick="location.href='/movielist/customer/inquiries';">

    <c:choose>
        <c:when test="${mode == 'update'}">
            <input type="submit" value="수정하기" class="sub">
        </c:when>
        <c:otherwise>
            <input type="submit" value="문의하기" class="sub">
        </c:otherwise>
    </c:choose>
</div>

</form>



	<div class="faq-con">
		<p>자주 묻는 질문을 확인해보셨나요?</p>
		<a href="/movielist/customer/faqs" class="faq">faq 바로가기 -></a>
	</div>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>