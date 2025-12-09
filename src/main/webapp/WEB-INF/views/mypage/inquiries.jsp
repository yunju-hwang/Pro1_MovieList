<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의내역</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<style>

html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    background-color: #f5f7fb; /* 페이지 전체 배경 */
    display: flex;
    flex-direction: column;
}

/* 컨텐츠 영역이 남은 공간을 차지하도록 */
.container {
    flex: 1; /* footer를 아래로 밀기 위해 남은 공간 차지 */
    width: 80%;
    margin: 0 auto;
}

.inquery {
    text-align: center;
    margin-top: 40px;
    font-size: 32px;
    font-weight: 700;
    color: #333;
}

.title_icon {
    width: 40px;
    vertical-align: middle;
    margin-right: 8px;
}

.many {
    text-align: center;
    color: #555;
    margin-bottom: 40px;
}

.container {
    width: 80%;
    margin: 0 auto;
}

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

.grid-row {
    display: grid;
    grid-template-columns: 1fr 2fr 3fr 1fr 1fr;
    align-items: center;
}

/* 헤더 */
.inquiry_head {
    padding: 15px;
    background: #e9eef7;
    font-weight: 700;
    border-radius: 10px;
    color: #333;
    text-align: center;
}

/* 리스트 공통 */
.inquiry_item {
    padding: 18px;
    margin-top: 8px;
    background: white;
    border-radius: 10px;
    transition: 0.2s;
    box-shadow: 0 5px 14px rgba(0,0,0,0.05);
    text-align: center;
    text-decoration: none; 
    color: inherit; /* 상위 요소 색상 상속 */
    cursor: pointer;
}

.inquiry_item:hover {
    background-color: #f0f4f9; /* 배경색을 살짝 밝게 변경 */
    box-shadow: 0 8px 20px rgba(0,0,0,0.1); /* 그림자 강조 */
    transform: translateY(-1px); /* 살짝 위로 이동하는 효과 */
}

/* span 기본 여백 제거 */
.inquiry_head span,
.inquiry_item span {
    margin: 0;
    padding: 0;
}

.item_num {
    text-align: center;
    color: #444;
    font-weight: 600;
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

.item_date {
    font-size: 14px;
    color: #777;
}

/* STATUS */
.status_icon {
    width: 18px;
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

.inq_detail {
    text-decoration: none;
}

/* 1:1 문의하기 버튼 */
.inq {
    text-decoration: none;
}

.inq-con {
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
    cursor: pointer;  /* ← 여기서 커서 모양 변경 */
	align-items: center;
	justify-content: center;
	display: flex;
}

.inq-con:hover {
    background: #3b4f8f;
    transform: translateY(-2px);
    cursor: pointer;  /* 마우스 올릴 때도 pointer 유지 */
}

.write_icon {
    width: 16px;      /* 아이콘도 더 축소 */
    margin-right: 4px;
    vertical-align: middle;
}

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
    text-decoration: none;
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
/* ================== 정렬 select 박스 꾸미기 ================== */
.sort-container {
    display: inline-block;
    margin-left: auto;
    margin-right: 0;
    text-align: right;
}

.sort-container form {
    display: inline-block;
}

.sort-container select {
    padding: 6px 12px;
    border-radius: 8px;
    border: 1px solid #ccc;
    background-color: #f8f8f8;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.2s ease;
}

.sort-container select:hover {
    border-color: #888;
    background-color: #f0f0f0;
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
			<li class="active"><a href="/movielist/mypage/inquiries"><i class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
			<li><a href="/movielist/mypage/movierequest"><i class="fa-solid fa-film"></i> 영화 요청</a></li>
		</ul>
	</div>
	
<h1 class="inquery">
    문의 내역
</h1>

<h4 class="many">
    총 ${count }건의 문의 내역
</h4>

<div class="container">

<c:choose>
    <c:when test="${count == 0}">
        <p class="ma no-data">
            <img src="https://cdn-icons-png.flaticon.com/512/4076/4076549.png" class="no_icon">
            문의 내역이 없습니다
        </p>
    </c:when>

    <c:otherwise>

<div class="inquiry_head grid-row">
            <span class="sp_num">글번호</span>
            <span class="sp_title">제목</span>
            <span class="sp_content">내용</span>
            <span class="sp_date">작성일</span>
            <span class="sp_ans">답변 여부</span>
        </div>

        <div class="inquiry_list">

            <c:forEach var="inquiriesVO" items="${inquiry_list}" varStatus="status">
                
                <a href="/movielist/customer/inquiries/inquiry_detail?id=${inquiriesVO.id}" class="inquiry_item grid-row inq_detail_link">

                    <span class="item_num">${status.index + 1}</span>
                    <span class="item_title">${inquiriesVO.title}</span>

                    <span class="item_content">
                        <c:choose>
                            <c:when test="${fn:length(inquiriesVO.content) > 15}">
                                ${fn:substring(inquiriesVO.content, 0, 15)}...
                            </c:when>
                            <c:otherwise>
                                ${inquiriesVO.content}
                            </c:otherwise>
                        </c:choose>
                    </span>

                    <span class="item_date">
                        ${inquiriesVO.createdAt.toString().substring(0,10)}
                    </span>

                    <c:if test="${inquiriesVO.status eq 'pending'}">
                        <span class="item_status_pen">
                            <img src="https://cdn-icons-png.flaticon.com/512/595/595067.png" class="status_icon">
                            답변대기
                        </span>
                    </c:if>

                    <c:if test="${inquiriesVO.status ne 'pending'}">
                            <span class="item_status_com">
                                <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" class="status_icon">
                                답변완료
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
