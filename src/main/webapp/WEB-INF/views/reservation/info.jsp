<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화관 선택</title>
<link rel="stylesheet" href="${ctx}/resources/css/reservation_info.css">
</head>
<body>

<h1>영화관 선택</h1>
<div class="page-layout">
	<div class="theater-wrapper">
	    <!-- 왼쪽: 지역 -->
	    <ul class="region-list">
	        <c:forEach var="loc" items="${locationsList}">
	            <li data-location="${loc}">${loc}</li>
	        </c:forEach>
	    </ul>
	
	    <!-- 오른쪽: 영화관 -->
	    <div class="theater-list">
	        <c:forEach var="t" items="${theaters}">
	            <div class="theater-card" data-location="${t.location}" data-id="${t.theaterId}">
	                ${t.name}
	            </div>
	        </c:forEach>
	    </div>
	</div>


	<!-- 날짜 버튼 영역 -->
	<div class="right-panel">
	<div id="datePickerWrapper" style="display: none;">
	    <h3 style="text-align:center; margin-top:20px;">날짜 선택</h3>
	    <div class="date-buttons" id="dateButtons"></div>
	</div>
	
	<!-- 시간 버튼 영역 -->
	<div id="timePickerWrapper" style="display: none; margin-top:20px;">
	    <h3 style="text-align:center;">시간 선택</h3>
	    <div class="time-buttons" id="timeButtons"></div>
	
	</div>
	
	<!-- 선택 내용 표시 영역 -->
	<div id="selectionSummary" class="selection-summary">
	    <span>상영관: <strong id="summaryTheater">-</strong></span>
	    <span>날짜: <strong id="summaryDate">-</strong></span>
	    <span>시간: <strong id="summaryTime">-</strong></span>
	</div>
	
</div>
</div>

<form id="theaterForm" action="<c:url value='/reservation/seat'/>" method="get">
    <input type="hidden" name="theaterId" id="selectedTheater">
    <input type="hidden" name="selectedDate" id="selectedDate">
    <input type="hidden" name="selectedTime" id="selectedTime">
    <button type="submit" class="btn-submit">다음</button>
</form>

<!-- js 외부파일 연결 -->
<script src="${ctx }/resources/js/reservation_info.js"></script>
    
</body>
</html>