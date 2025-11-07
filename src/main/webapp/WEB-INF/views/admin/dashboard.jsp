<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    <%@ include file="/WEB-INF/views/admin/admin_navbar.jsp" %>
    
<!DOCTYPE html>

<html>
<head>


    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 관리 대시보드</title>
       <link rel="stylesheet" href="<c:url value='/resources/css/base.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/stats_card.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/tabs_buttons.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/tables.css' />">
    <style>
        /* 1. 하이퍼링크 기본 스타일 무효화 */
        .menu-tabs a.tab {
            text-decoration: none; /* 밑줄 제거 */
            color: #333;          /* 글씨 색상 지정 (파란색 방지) */
            cursor: pointer;      /* 마우스 오버 시 커서 모양 유지 */
            
            /* (선택 사항) 너비/높이가 틀어지는 것을 방지 */
            display: inline-block; 
        }

        /* 2. 네가 원했던 호버(Hover) 효과 복구 */
        /* 네 기존 CSS에 hover 스타일이 없었더라도, 버튼 느낌을 주려면 이걸 추가하는 게 좋아! */
        .menu-tabs a.tab:hover {
            background-color: #dc3545; 
            color: #fff;
            border-color: #dc3545;
        }
		.menu-tabs a.tab.active {
        color: #fff !important;            
    }

    </style>
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