<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ include file="dashboard.jsp" %> 
	
<div class="table-section">
    <table class="inquiry-table">
        <thead>
            <tr>
                <th>번호</th>
                <th>카테고리</th>
                <th>제목</th>
                <th>작성자</th>
                <th>이메일</th>
                <th>날짜</th>
                <th>상태</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1001</td>
                <td>영화정보</td>
                <td>문의합니다</td>
                <td>guest1</td>
                <td>guest1@guest1.com</td>
                <td>2025.11.03</td>
                <td><span class="status-badge pending">답변대기</span></td> 
                <td>
                    <button class="action-btn answer-btn" data-inquiry-id="111">답변하기</button>
                </td>
            </tr>
       
        </tbody>
    </table>
</div>

<div class="reply-section" id="replyForm" style="display: none;">
    <h3>답변 작성</h3>
    <textarea placeholder="답변 내용을 입력하세요" rows="8"></textarea>
    <div class="reply-actions">
        <button class="reply-submit-btn">답변 등록</button>
        <button class="reply-cancel-btn">취소</button>
    </div>
</div>

<%@ include file="end.jsp" %> 