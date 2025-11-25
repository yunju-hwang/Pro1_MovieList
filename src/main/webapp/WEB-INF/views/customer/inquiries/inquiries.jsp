<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의내역</title>
<link rel="stylesheet" href="<c:url value='/resources/css/inquiries.css' />">
</head>
<body>
	<h1 class="inquery">문의 내역</h1>
	<h4 class="many">총 ${count }건의 문의 내역</h4>
	
	<div class="container">
	
   <c:choose>
        <c:when test="${count == 0}">
            <p class="ma">문의 내역이 없습니다</p>
        </c:when>
        <c:otherwise>
            <div class="inquiry_head">
            	<span class="sp_num">글번호</span>
                <span class="sp_title">제목</span>
                <span class="sp_date">작성일</span>
                <span class="sp_ans">답변 여부</span>

            </div>



            <div class="inquiry_list">
                <c:forEach var="inquiriesVO" items="${inquiry_list}">
                    <div class="inquiry_item">
                    	<span class="item_num">${inquiriesVO.id}</span>
                        <span class="item_title">${inquiriesVO.title}</span>
                        <span class="item_date">
    						 ${inquiriesVO.createdAt.toString().substring(0,10)}
						</span>
						<c:if test="${inquiriesVO.status eq 'pending' }">
						
                        <span class="item_status_pen">답변대기</span>
                        </c:if>
                        <c:if test="${inquiriesVO.status ne 'pending' }">

						<a href="/movielist/customer/inquiries/inquiry_detail?id=${inquiriesVO.id }" class="inq_detail">
                        <span class="item_status_com">답변완료</span>
                         </a>
                        </c:if>


                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
 
</div>







<a href="/movielist/customer/write_inquiry" class="inq">
	<div class="inq-con">
		<p>1:1 문의하기</p>
	</div>
	</a>
</body>
</html>