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
</head>
<body>
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

<div class="inq-con" onclick="location.href='/movielist/customer/write_inquiry'">
    <img src="https://cdn-icons-png.flaticon.com/512/992/992651.png" class="write_icon">
    <p>1:1 문의하기</p>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
