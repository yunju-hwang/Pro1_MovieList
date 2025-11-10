<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dashboard.jsp" %>
<div class="table-section">
    <table class="user-table"> 
        <thead>
            <tr>
                <th>등급</th>              <%-- 1. 등급 --%>
                <th>사용자 ID</th>          <%-- 2. 사용자 ID --%>
                <th>가입일</th>            <%-- 3. 가입일 --%>
                <th>최근 접속일</th>        <%-- 4. 최근 접속일 --%>
                <th>리뷰 건수</th>          <%-- 5. 작성 리뷰 건수 --%>
                <th>예매 건수</th>          <%-- 6. 예매 건수 --%>
                <th>문의 건수</th>          <%-- 7. 문의 건수 --%>
                <th>영화 요청 건수</th>     <%-- 8. 영화 요청 건수 (새로 추가) --%>
                <th>관리</th>               <%-- 9. 관리 (탈퇴) --%>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>골드</td>
                <td>user101</td>
                <td>2023.10.01</td>
                <td>2025.11.05</td>
                <td>12건</td>
                <td>3건</td>
                <td>0건</td>
                <td>1건</td>              
                <td>
                    <button class="action-btn delete-user-btn">탈퇴</button>
                </td>
            </tr>
            <tr>
                <td>골드</td>
                <td>user101</td>
                <td>2023.10.01</td>
                <td>2025.11.05</td>
                <td>12건</td>
                <td>3건</td>
                <td>0건</td>
                <td>1건</td>           
                <td>
                    <button class="action-btn delete-user-btn">탈퇴</button>
                </td>
            </tr>
           
        </tbody>
    </table>
</div>
                
<%@ include file="end.jsp" %> 