<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 내역</title>
<link rel="stylesheet" href="<c:url value='/resources/css/inquiries.css'/>">
</head>
<body>

<h1 class="inquery">
    <img src="<c:url value='/resources/img/message.png' />" class="title_icon">
    문의 내역
</h1>

<h4 class="many">총 ${count}건의 문의 내역</h4>

<div class="container">

<c:choose>
    <c:when test="${count == 0}">
        <p class="no-data">
            <img src="https://cdn-icons-png.flaticon.com/512/4076/4076549.png" class="no_icon">
            문의 내역이 없습니다
        </p>
    </c:when>
    <c:otherwise>

        <!-- 헤더 -->
        <div class="inquiry_head grid-row">
            <span class="sp_num">글번호</span>
            <span class="sp_title">제목</span>
            <span class="sp_content">내용</span>
            <span class="sp_date">작성일</span>
            <span class="sp_status">답변 여부</span>
            <div class="sort-container">
                <form method="get" action="/movielist/customer/inquiries">
                    <select name="sort" onchange="this.form.submit()">
                        <option value="date_rec" ${param.sort == 'date_rec' ? 'selected' : '' }>최신순</option>
                        <option value="date_asc" ${param.sort == 'date_asc' ? 'selected' : ''}>오래된순</option>
                        <option value="pending" ${param.sort == 'pending' ? 'selected' : ''}>답변 대기</option>
                        <option value="completed" ${param.sort == 'completed' ? 'selected' : ''}>답변 완료</option>
                    </select>
                </form>
            </div>
        </div>

        <!-- 리스트 -->
        <c:forEach var="inquiriesVO" items="${inquiry_list}" varStatus="status">
            <div class="inquiry_item grid-row" onclick="location.href='${pageContext.request.contextPath}/customer/inquiries/inquiry_detail?id=${inquiriesVO.id}'">
                
                <span class="item_num">${status.index + 1}</span>
                <span class="item_title">
                    <c:choose>
                        <c:when test="${fn:length(inquiriesVO.title) > 15}">
                            ${fn:substring(inquiriesVO.title, 0, 15)}...
                        </c:when>
                        <c:otherwise>${inquiriesVO.title}</c:otherwise>
                    </c:choose>
                </span>
                <span class="item_content">
                    <c:choose>
                        <c:when test="${fn:length(inquiriesVO.content) > 15}">
                            ${fn:substring(inquiriesVO.content, 0, 15)}...
                        </c:when>
                        <c:otherwise>${inquiriesVO.content}</c:otherwise>
                    </c:choose>
                </span>
                <span class="item_date">${inquiriesVO.createdAt.toString().substring(0,10)}</span>

                <span class="item_status">
                    <c:choose>
                        <c:when test="${inquiriesVO.status eq 'pending'}">
                            <img src="https://cdn-icons-png.flaticon.com/512/595/595067.png" class="status_icon">
                            답변대기
                        </c:when>
                        <c:otherwise>
                            <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" class="status_icon">
                            답변완료
                        </c:otherwise>
                    </c:choose>
                </span>

                <!-- 버튼 그룹: 답변대기일 때만 표시 -->
<c:if test="${inquiriesVO.status eq 'pending'}">
    <div class="button-group">
        <span class="item_edit" onclick="event.stopPropagation(); location.href='/movielist/customer/inquiry_update?id=${inquiriesVO.id}'">
            <img src="https://cdn-icons-png.flaticon.com/512/1827/1827933.png" class="edit_icon">수정
        </span>
        <span class="item_delete" onclick="event.stopPropagation(); if(confirm('정말 삭제하시겠습니까?')) location.href='/movielist/customer/inquiry_delete?id=${inquiriesVO.id}'">
            <img src="https://cdn-icons-png.flaticon.com/512/3405/3405244.png" class="delete_icon">삭제
        </span>
    </div>
</c:if>


            </div>
        </c:forEach>

    </c:otherwise>
</c:choose>

</div>

<div class="inq-con" onclick="location.href='${pageContext.request.contextPath}/customer/write_inquiry'">
    <img src="https://cdn-icons-png.flaticon.com/512/992/992651.png" class="write_icon">
    <p>1:1 문의하기</p>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
