<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 요청 내역</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<style>

html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    background-color: #f5f7fb;
    font-family: "Noto Sans KR", sans-serif;
    display: flex;
    flex-direction: column;
}

.container {
    flex: 1;
    width: 80%;
    margin: 0 auto;
    align-items: center; /* 중앙 정렬 */
}

/* 제목 */
.request {
    text-align: center;
    margin-top: 40px;
    font-size: 32px;
    font-weight: 700;
    color: #333;
}

.title_icon {
    width: 30px;
    vertical-align: middle;
    margin-right: 6px;
}

/* 총 개수 */
.many {
    text-align: center;
    color: #555;
    margin-bottom: 40px;
}

/* 데이터 없을 때 */
.no-data {
    text-align: center;
    font-size: 22px;
    padding: 40px;
    background: white;
    border-radius: 15px;
    color: #777;
    box-shadow: 0 8px 15px rgba(0,0,0,0.08);
}

.no_icon {
    width: 50px;
    display: block;
    margin: 0 auto 10px;
}

/* 그리드 */
.grid-row {
    display: grid;
    grid-template-columns: 1fr 1fr 2fr 1fr 1fr; /* 마지막 열 자동으로 공간 확보 */
    align-items: center;
    width: 100%;
    gap: 10px;
}

/* 헤더 */
.request_head {
    padding: 15px;
    background: #e9eef7;
    font-weight: 700;
    border-radius: 10px;
    color: #333;
    text-align: center;
    width: 100%;
}

/* 리스트 아이템 */
.request_item {
    padding: 18px;
    margin-top: 8px;
    background: white;
    border-radius: 10px;
    transition: 0.2s;
    box-shadow: 0 5px 14px rgba(0,0,0,0.05);
    text-align: center;
    width: 100%;
    cursor: pointer;
    text-decoration: none; /* 밑줄 제거 */
    color: inherit;
}

.request_item:hover {
    background-color: #f0f4f9;
    transform: translateY(-1px);
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
}

/* 번호, 제목, 내용, 날짜, 상태 */
.item_num, .item_date {
    text-align: center;
}

.item_title {
    font-weight: 600;
    color: #333;
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
    overflow: hidden; /* 영역을 벗어난 텍스트 숨김 */
    text-overflow: ellipsis; /* 숨겨진 텍스트 대신 말줄임표 표시 */
    display: block;
}

.item_content {
    color: #666;
}

/* 상태 아이콘 */
.status_icon {
    width: 16px;
    margin-right: 5px;
    vertical-align: middle;
}

.item_status_pen {
    color: #d9534f;
    font-weight: 700;
}

.item_status_com {
    color: #28a745;
    font-weight: 700;
}

/* 수정/삭제 버튼 */
.item_edit, .item_delete {
    margin: 0 8px;
    cursor: pointer;
    padding: 6px 10px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 700;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    transition: 0.2s;
}

.item_edit {
    background: #ffe082;
    color: #8d6e63;
}

.item_edit:hover {
    background: #ffca28;
}

.item_delete {
    background: #ef9a9a;
    color: #b71c1c;
}

.item_delete:hover {
    background: #e57373;
}

.edit_icon, .delete_icon {
    width: 16px;
    margin-right: 4px;
}

/* 영화 요청 버튼 */
.req-con {
    width: 140px;
    margin: 30px auto;
    background: #4a69bd;
    color: white;
    text-align: center;
    padding: 10px 0;
    border-radius: 30px;
    font-size: 14px;
    font-weight: 700;
    box-shadow: 0 4px 10px rgba(74,105,189,0.3);
    transition: 0.25s;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
}

.req-con:hover {
    background: #3b4f8f;
    transform: translateY(-2px);
}

.write_icon {
    width: 16px;
    margin-right: 6px;
}



/* select 박스 */
.sort-container {
    width: 100%;
    display: flex;
    justify-content: flex-end;
}

.sort-container select {
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    padding: 6px 30px 6px 12px;
    border-radius: 8px;
    border: 1px solid #ccc;
    background-color: #fff;
    font-size: 14px;
    cursor: pointer;
    background-image: url('https://cdn-icons-png.flaticon.com/512/271/271228.png');
    background-repeat: no-repeat;
    background-position: right 8px center;
    background-size: 16px 16px;
    transition: all 0.2s;
}

.sort-container select:hover {
    border-color: #888;
    background-color: #f9f9f9;
}

.sort-container select:focus {
    outline: none;
    border-color: #555;
    box-shadow: 0 0 5px rgba(0,0,0,0.2);
}

.header-nav {
	width: 100%;
	background-color: #ffffff;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
	padding: 3px 0;
}

.header-nav ul {
	list-style: none;
	padding: 0;
	margin: 0;
	display: flex;
	justify-content: center;
}

.header-nav li {
	padding: 12px 20px;
	font-size: 14px;
	color: #555;
	cursor: pointer;
	transition: color 0.3s, background-color 0.3s; /* 배경색 전환 효과 추가 */
	border-bottom: none; /* 기존 밑줄 효과 제거 */
	border-radius: 4px; /* 버튼처럼 보이도록 모서리 둥글게 처리 */
	margin: 0 7px; /* 버튼 간격 추가 */
}

.header-nav li:hover {
	color: white; /* 글자색을 흰색으로 변경 */
	background-color: #cd0000; /* 배경색을 빨간색으로 변경 */
}

/* 🚨 A 태그 스타일 (링크 스타일 초기화 및 영역 확장) */
.header-nav li a {
	text-decoration: none; /* 링크 밑줄 제거 */
	color: inherit; /* 부모 li의 색상을 상속받음 */
	display: flex; /* 아이콘과 텍스트 중앙 정렬 */
	align-items: center;
}

/* 🚨 관심 목록 메뉴를 활성화합니다. */
.header-nav li.active {
	color: white; /* 활성 메뉴의 글자색을 흰색으로 변경 */
	background-color: #cd0000; /* 활성 메뉴의 배경색을 빨간색으로 변경 */
	border-bottom: none; /* 기존 밑줄 효과 제거 */
	font-weight: bold;
}

/* 🚨 활성화된 메뉴에 마우스를 올릴 때 (미묘한 색상 차이로 구분) */
.header-nav li.active:hover {
	background-color: #a00000; /* 활성 버튼 위에 hover 시 더 어두운 빨간색으로 변경 */
	color: white;
}

.header-nav li i {
	margin-right: 5px;
}
</style>
<body>

<div class="header-nav">
		<ul>
			<li><a href="/movielist/mypage/reservations"><i class="fa-solid fa-calendar-check"></i> 예매 내역</a></li>
			<li><a href="/movielist/mypage/favorites"><i class="fa-regular fa-heart"></i> 관심 영화</a></li>
			<li><a href="/movielist/mypage/profile"><i class="fa-regular fa-user"></i> 회원 정보</a></li>
			<li><a href="/movielist/mypage/theaters"><i class="fa-solid fa-map-pin"></i> 선호 영화관</a></li>
			<li><a href="/movielist/mypage/inquiries"><i class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
			<li class="active"><a href="/movielist/mypage/movierequest"><i class="fa-solid fa-film"></i> 영화 요청</a></li>
		</ul>
	</div>

<h1 class="request">
    영화 요청 내역
</h1>

<h4 class="many">총 ${count}건의 요청 내역</h4>

<div class="container">

    <c:choose>
        <c:when test="${count == 0}">
            <p class="no-data">
                <img src="https://cdn-icons-png.flaticon.com/512/4076/4076549.png" class="no_icon">
                요청 내역이 없습니다
            </p>
        </c:when>
        <c:otherwise>
            <!-- 헤더 -->
            <div class="request_head grid-row">
                <span class="sp_num">글번호</span>
                <span class="sp_title">제목</span>
                <span class="sp_content">내용</span>
                <span class="sp_date">요청일</span>
                <span class="sp_status">처리 상태</span>
            </div>

            <!-- 리스트 -->
            <div class="request_list">
                <c:forEach var="movieRequest" items="${movie_request_list}" varStatus="status">
                
                    <a href="/movielist/customer/movie_request_detail?id=${movieRequest.id}" class="request_item grid-row">
                        <span class="item_num">${status.index + 1}</span>
                        <span class="item_title">${movieRequest.title}</span>
                        <span class="item_content">
                            <c:choose>
                                <c:when test="${fn:length(movieRequest.content) > 15}">
                                    ${fn:substring(movieRequest.content, 0, 15)}...
                                </c:when>
                                <c:otherwise>
                                    ${movieRequest.content}
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <span class="item_date">
    <c:choose>
        <%-- 1. createdAt이 null이 아닌지 확인 --%>
        <c:when test="${not empty movieRequest.createdAt}">
            <%-- createdAt을 문자열로 변환 --%>
            <c:set var="dateStr" value="${movieRequest.createdAt.toString()}" />
            
            <%-- 2. 문자열의 길이가 10 이상인지 확인 (안전하게 substring 사용) --%>
            <c:if test="${fn:length(dateStr) >= 10}">
                ${fn:substring(dateStr, 0, 10)}
            </c:if>
            <%-- 3. 길이가 짧으면 전체 출력 (또는 에러 메시지) --%>
            <c:if test="${fn:length(dateStr) < 10}">
                ${dateStr} <%-- 또는 '날짜 포맷 오류'와 같은 메시지 출력 --%>
            </c:if>
        </c:when>
        <%-- 4. createdAt이 null일 경우 처리 --%>
        <c:otherwise>
            -
        </c:otherwise>
    </c:choose>
</span>

                        <c:if test="${movieRequest.status eq 'pending'}">
                            <span class="item_status_pen">
                                <img src="https://cdn-icons-png.flaticon.com/512/595/595067.png" class="status_icon">
                                대기
                            </span>
                        </c:if>
                        <c:if test="${movieRequest.status ne 'pending'}">
                            <span class="item_status_com">
                                <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" class="status_icon">
                                완료
                            </span>
                        </c:if>
                    </a>

                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
