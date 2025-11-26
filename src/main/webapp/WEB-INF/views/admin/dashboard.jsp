<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    <%@ include file="/WEB-INF/views/admin/admin_navbar.jsp" %>
	<link rel="stylesheet" href="<c:url value='/resources/css/admin_base.css' />">
	<link rel="stylesheet" href="<c:url value='/resources/css/admin_form.css' />">
	<link rel="stylesheet" href="<c:url value='/resources/css/admin_table.css' />">
    <div class="dashboard-container">

        <div class="stats-bar">
            <div class="stat-card blue">
                <div class="stat-content">
                    <span class="label">전체 사용자</span>
                    <span class="value">${userCount} 명</span>
                </div>
                <div class="stat-icon-area">
<img src="${pageContext.request.contextPath}/resources/img/peoples_red.png"
                alt="사용자 아이콘" >
</div>
            </div>
            
            <div class="stat-card red">
                 <div class="stat-content">
                    <span class="label">전체 리뷰</span>
                    <span class="value">${reviewsCount } 개</span>
                </div>
                <div class="stat-icon-area">
<img src="${pageContext.request.contextPath}/resources/img/message.png"
                alt="리뷰 아이콘" >
</div>
            </div>
            
            <div class="stat-card green">
                 <div class="stat-content">
                    <span class="label">전체 예매</span>
                    <span class="value">${reservations } 개</span>
                </div>
                <div class="stat-icon-area">
                <img src="${pageContext.request.contextPath}/resources/img/rise.png"
                alt="예매 아이콘" >
</div>
            </div>
            
            <div class="stat-card orange">
                 <div class="stat-content">
                    <span class="label">답변 문의</span>
                    <span class="value">${inquiriesCount } 개</span>
                </div>
                <div class="stat-icon-area" >
                <img src="${pageContext.request.contextPath}/resources/img/question.png"
                alt="문의 아이콘">
                </div>
            </div>
            
            <div class="stat-card gray">
                 <div class="stat-content">
                    <span class="label">대기 요청</span>
                    <span class="value">${movie_RequestsCount } 개</span>
                </div>
                <div class="stat-icon-area">
                    <img src="${pageContext.request.contextPath}/resources/img/film_red.png"
                alt="대기 아이콘">
                </div>
                
            </div>
        </div>
      <c:set var="currentPath" value="${pageContext.request.requestURI}"/>
<div class="menu-tabs">
    
  <a class="tab <c:if test="${fn:contains(currentPath, '/admin/movie') and not fn:contains(currentPath, '/admin/movie_requests')}">active</c:if>" 
       href="<c:url value='/admin/movie' />">영화 관리</a>

    <a class="tab <c:if test="${fn:contains(currentPath, '/admin/users')}">active</c:if>" 
       href="<c:url value='/admin/users' />">사용자 관리</a>

    <a class="tab <c:if test="${fn:contains(currentPath, '/admin/inquiries')}">active</c:if>" 
       href="<c:url value='/admin/inquiries' />">1:1문의</a>
       
   <a class="tab <c:if test="${fn:contains(currentPath, '/admin/movie_requests')}">active</c:if>" 
       href="<c:url value='/admin/movie_requests' />">영화 요청</a>
       
    <a class="tab <c:if test="${fn:contains(currentPath, '/admin/reviews')}">active</c:if>" 
       href="<c:url value='/admin/reviews' />">리뷰 관리</a>
       
    <a class="tab <c:if test="${fn:contains(currentPath, '/admin/reservations')}">active</c:if>" 
       href="<c:url value='/admin/reservations' />">예매 관리</a>
       
       </div>
