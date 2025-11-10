<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ include file="dashboard.jsp" %> 
<div class="table-section">
    <table class="request-table">
        <thead>
            <tr>
                <th>번호</th>            
                <th>영화제목</th>        
                <th>장르</th>           
                <th>개봉년도</th>        
                <th>요청자</th>          
                <th>요청일</th>        
                <th>상태</th>          
                <th>관리</th>         
            </tr>
        </thead>
        <tbody>
          
            <tr>
                <td>24</td>
                <td>극한직업</td>
                <td>코미디, 액션</td>
                <td>2019</td>
                <td>볼만한게 없네</td>
                <td>2025. 11. 03</td>
                <td><span class="status-badge checking">검토중</span></td>
                <td>
                    <button class="action-icon-btn check-btn">
                       <img src="${pageContext.request.contextPath}/resources/img/check_green.png" alt="확인 아이콘">
                    </button>
                    <button class="action-icon-btn delete-btn">
                        <img src="${pageContext.request.contextPath}/resources/img/close_red.png" alt="삭제 아이콘">
                    </button>
                </td>
            </tr>
             <tr>
                <td>24</td>
                <td>극한직업</td>
                <td>코미디, 액션</td>
                <td>2019</td>
                <td>볼만한게 없네</td>
                <td>2025. 11. 03</td>
                <td><span class="status-badge checking">검토중</span></td>
                <td>
                    <button class="action-icon-btn check-btn">
                       <img src="${pageContext.request.contextPath}/resources/img/check_green.png" alt="확인 아이콘">
                    </button>
                    <button class="action-icon-btn delete-btn">
                        <img src="${pageContext.request.contextPath}/resources/img/close_red.png" alt="삭제 아이콘">
                    </button>
                </td>
            </tr>
        </tbody>
    </table>
</div>
<%@ include file="end.jsp" %> 