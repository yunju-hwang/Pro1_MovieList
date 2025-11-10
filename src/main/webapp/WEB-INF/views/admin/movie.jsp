<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="dashboard.jsp" %> 

<div class="table-content-container">
    <div id="tab-movie" class="tab-content active">
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


<%@ include file="end.jsp" %> 