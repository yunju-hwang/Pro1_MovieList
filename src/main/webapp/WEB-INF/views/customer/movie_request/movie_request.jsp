<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/movie_request.css'/>">
</head>
<body>
	<h1 class="movie-req">영화 등록 요청 내역</h1>
	<h4 class="req">총 ${count } 건의 요청</h4>
	<div class="container">
	<c:choose>
		<c:when test="${count == 0 }">
			<p class="ma">요청 내역이 없습니다</p>	
		</c:when>
		
        <c:otherwise>

            <div class="inquiry_head">
            	<span class="sp_num">글번호</span>
                <span class="sp_title">제목</span>
                <span class="sp_content">내용</span>
                <span class="sp_wri_date">작성일</span>
				<span class="sp_ans">승인여부</span>

            </div>
            
            		
            <div class="inquiry_list">
                <c:forEach var="movieRequestVO" items="${movie_request_list}">
                    <div class="inquiry_item">
                    	<span class="item_num">${movieRequestVO.id}</span>
                        <span class="item_title">${movieRequestVO.title}</span>
                        <span class="item_content">${movieRequestVO.content}</span>
                        <span class="item_date">
    						 ${movieRequestVO.createdAt.toString().substring(0,10)}
						</span>
						<c:if test="${movieRequestVO.status eq 'pending' }">
						
                        <span class="item_status_pen">대기</span>
                        </c:if>
                        <c:if test="${movieRequestVO.status eq 'approved' }">
						
                        <span class="item_status_app">승인</span>
                        </c:if>
                        
                        <c:if test="${movieRequestVO.status eq 'rejected' }">
                          <span class="item_status_rej">거부</span>
                        </c:if>
                      
                        


                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
	</c:choose>
	</div>
<a href="${pageContext.request.contextPath }/customer/write_movie_request" class="mov-write">
	<div class="movie">
	
	
		<p>영화 등록 요청하기</p>
	</div>
</a>
</body>
</html>