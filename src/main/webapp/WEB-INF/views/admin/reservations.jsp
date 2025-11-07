<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<div class="table-section">
    <table class="booking-table">
        <thead>
            <tr>
                <th>예매 번호</th>
                <th>영화 제목</th>
                <th>예매자</th>
                <th>상영관</th>
                <th>날짜</th>
                <th>시간</th>
                <th>좌석</th>
                <th>금액</th>
                <th>환불</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>타이타닉</td>
                <td>테디베어</td>
                <td>강남 CGV</td>
                <td>2026.3.31</td>
                <td>15:00</td>
                <td>D5</td>
                <td>15,000원</td>
                <td>
                    <button class="action-btn refund-btn">
                         <img src="<c:url value='/resources/img/refund_icon.png'/>" alt="환불 아이콘"> 환불
                    </button>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>다크나이트</td>
                <td>테디베어</td>
                <td>강남 CGV</td>
                <td>2026.5.31</td>
                <td>18:30</td>
                <td>D5</td>
                <td>15,000원</td>
                <td>
                    <button class="action-btn refund-btn">
                         <img src="<c:url value='/resources/img/refund_icon.png'/>" alt="환불 아이콘"> 환불
                    </button>
                </td>
            </tr>
            <tr>
                <td colspan="9" class="no-data" style="display:none;">현재 예매 목록이 없습니다.</td>
            </tr>
        </tbody>
    </table>
</div>