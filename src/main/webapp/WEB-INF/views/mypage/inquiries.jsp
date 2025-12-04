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
<link rel="stylesheet" href="<c:url value='/resources/css/inquiries.css?after' />">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<style>
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
			<li><a href="/movielist/mypage/favorites"><i class="fa-regular fa-heart"></i> 관심 목록</a></li>
			<li><a href="/movielist/mypage/profile"><i class="fa-regular fa-user"></i> 회원 정보</a></li>
			<li><a href="/movielist/mypage/theaters"><i class="fa-solid fa-map-pin"></i> 선호 영화관</a></li>
			<li class="active"><a href="/movielist/mypage/inquiries"><i class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
			<li><a href="/movielist/mypage/movierequest"><i class="fa-solid fa-film"></i> 영화 요청</a></li>
		</ul>
	</div>
	
<h1 class="inquery">
    <img src="<c:url value='/resources/img/message.png' />" class="title_icon">
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
                <div class="inquiry_item grid-row">

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
                        <a href="/movielist/customer/inquiries/inquiry_detail?id=${inquiriesVO.id}" class="inq_detail">
                            <span class="item_status_com">
                                <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" class="status_icon">
                                답변완료
                            </span>
                        </a>
                    </c:if>

                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
