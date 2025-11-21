<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AI리뷰</title>
<link rel="stylesheet" href="${ctx}/resources/css/ai_review.css">
</head>
<body onload="loadUserReviews()">

<div class="mnavbar">
    <a href="${ctx}/main">Home</a>
    <a href="${ctx}/movies/ai_review" id="aiReviewBtn">AI Review</a>
</div>

<div class="review-section">
    
	<!-- AI 리뷰 영역 -->
    <div class="ai-review-section">
        <h2>AI 리뷰 요약</h2>
        <div id="aiAnalysisContainer"></div> <!-- analysis 전용 -->
        <h3>추천 영화</h3>
        <div id="aiReviewContainer">AI 분석 중...</div>
    </div>
	
	<h2>나의 리뷰</h2>
    <div class="review-list">
        <p>리뷰 불러오는 중...</p>
    </div>

    
</div>




</body>


<script>
  const ctx = '${ctx}';
  console.log("ctx:", ctx);
</script>

<script src="${ctx}/resources/js/aiReivew.js"></script>
</html>