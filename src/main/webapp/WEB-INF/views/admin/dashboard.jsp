<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ include file="/WEB-INF/views/admin/admin_navbar.jsp" %>
    
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 관리 대시보드</title>
       <link rel="stylesheet" href="<c:url value='/resources/css/base.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/stats_card.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/tabs_buttons.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/tables.css' />">
    </head>
<body>

    <div class="dashboard-container">

        <div class="stats-bar">
            <div class="stat-card blue">
                <div class="stat-content">
                    <span class="label">전체 사용자</span>
                    <span class="value">*db 값 받아올곳*</span>
                </div>
                <div class="stat-icon-area">
<img src="${pageContext.request.contextPath}/resources/img/peoples_red.png"
                alt="사용자 아이콘" >
</div>
            </div>
            
            <div class="stat-card red">
                 <div class="stat-content">
                    <span class="label">전체 리뷰</span>
                    <span class="value">*db 값 받아올곳*</span>
                </div>
                <div class="stat-icon-area">
<img src="${pageContext.request.contextPath}/resources/img/message.png"
                alt="리뷰 아이콘" >
</div>
            </div>
            
            <div class="stat-card green">
                 <div class="stat-content">
                    <span class="label">전체 예매</span>
                    <span class="value">*db 값 받아올곳*</span>
                </div>
                <div class="stat-icon-area">
                <img src="${pageContext.request.contextPath}/resources/img/rise.png"
                alt="예매 아이콘" >
</div>
            </div>
            
            <div class="stat-card orange">
                 <div class="stat-content">
                    <span class="label">답변 문의</span>
                    <span class="value">*db 값 받아올곳*</span>
                </div>
                <div class="stat-icon-area" >
                <img src="${pageContext.request.contextPath}/resources/img/question.png"
                alt="문의 아이콘">
                </div>
            </div>
            
            <div class="stat-card gray">
                 <div class="stat-content">
                    <span class="label">대기 요청</span>
                    <span class="value">*db 값 받아올곳*</span>
                </div>
                <div class="stat-icon-area">
                    <img src="${pageContext.request.contextPath}/resources/img/film_red.png"
                alt="대기 아이콘">
                </div>
                
            </div>
        </div>
        
       <div class="menu-tabs">
    <button class="tab active" data-tab="movie">영화관리</button>
    <button class="tab" data-tab="user">사용자 관리</button>
    <button class="tab" data-tab="qna">1:1문의</button>
    <button class="tab" data-tab="request">영화 요청</button>
    <button class="tab" data-tab="review">리뷰 관리</button>
    <button class="tab" data-tab="reservation">예매 관리</button>
</div>

       
<div class="table-content-container">

    <div id="tab-movie" class="tab-content active">
        <%-- 기존 dashboard.jsp의 영화관리 테이블 내용이 여기에 들어갑니다 --%>
         <div class="table-section">
            <table class="movie-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>장르</th>
                        <th>평점</th>
                        <th>상영시간</th>
                        <th>긍정리뷰</th>
                        <th>부정리뷰</th>
                        <th>개봉일</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
               			<th>1</th>
                        <th>서울의 봄</th>
                        <th>드라마, 액션</th>
                        <th>9.1</th>
                        <th>141분</th>
                        <th>1,234</th>
                        <th>56</th>
                        <th>2023.11.22</th>
                        <td><button class="action-icon-btn">
 <img src="${pageContext.request.contextPath}/resources/img/trash_red.png"
                alt="삭제 아이콘">
</button></td>
                    </tr>
                    <tr>
                        <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                        <td><button class="action-icon-btn">
 <img src="${pageContext.request.contextPath}/resources/img/trash_red.png"
                alt="삭제 아이콘">
</button></td>
                    </tr>
                </tbody>
            </table>
        </div>

    </div>
    </div>

    <div id="tab-user" class="tab-content">
        <%-- **경로 확인:** 현재 dashboard.jsp와 users.jsp는 같은 폴더(/WEB-INF/views/admin/)에 있으니 파일 이름만 적으면 돼! --%>
        <%@ include file="users.jsp" %>
    </div>

    <div id="tab-qna" class="tab-content">
        <%@ include file="inquiries.jsp" %>
    </div>
    
    <div id="tab-request" class="tab-content">
        <%@ include file="movie_requests.jsp" %>
    </div>

    <div id="tab-review" class="tab-content">
        <%@ include file="reviews.jsp" %>
    </div>
    
    <div id="tab-reservation" class="tab-content">
        <%@ include file="reservations.jsp" %>
    </div>
    <script>
        const tabs = document.querySelectorAll('.tab');
        const contents = document.querySelectorAll('.tab-content');

        tabs.forEach(tab => {
            tab.addEventListener('click', function() {
                // 1. 활성 탭 스타일 초기화 및 클릭한 탭 활성화
                tabs.forEach(t => t.classList.remove('active'));
                this.classList.add('active');
                
                // 2. 보여줘야 할 콘텐츠의 ID를 data-tab 속성에서 가져옴
                const targetTabName = this.dataset.tab; 
                const targetContentId = 'tab-' + targetTabName;

                // 3. 모든 콘텐츠 숨김 처리
                contents.forEach(content => content.classList.remove('active'));
                
                // 4. 타겟 콘텐츠만 보여주기
                const targetContent = document.getElementById(targetContentId);
                if (targetContent) {
                    targetContent.classList.add('active');
                }
            });
        });
    </script>
</div>

</body>
</html>