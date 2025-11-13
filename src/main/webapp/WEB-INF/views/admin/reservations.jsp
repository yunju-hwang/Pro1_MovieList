<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="dashboard.jsp"%>
<div class="table-section">
	<table class="booking-table">
		<thead>
			<tr>
				<th>예매 번호</th>
				<th>영화 제목</th>
				<th>예매자</th>
				<th>상영관</th>
				<th>상영시간</th>
				<th>결제일시</th>
				<th>관람 인원</th>
				<th>좌석</th>
				<th>금액</th>
				<th>상태</th>
				<th>환불</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="reservations" items="${adminReservationsList}"
				varStatus="status">
				<tr>
					<td>${reservations.id}</td>
					<td>${reservations.movieTitle}</td>
					<td>${reservations.userId}</td>
					<td>${reservations.theaterName}</td>
					<td><c:set var="screenTime"
							value="${reservations.screeningTime}" /> <c:out
							value="${fn:substring(screenTime, 0, 10)}" /><br> <c:out
							value="${fn:substring(screenTime, 11, 16)}" /></td>
					<td><c:set var="reservationDate"
							value="${reservations.reservationDate}" /> <c:out
							value="${fn:substring(reservationDate, 0, 10)}" /><br> <c:out
							value="${fn:substring(reservationDate, 11, 16)}" /></td>
					<td>${reservations.people}명</td>
					<td>${reservations.seat}</td>
					<td>${reservations.finalAmount}원</td>
					<td><c:choose>
							<c:when test="${reservations.status eq 'reserved'}">
								<span class="status-reserved">예매 완료</span>
							</c:when>
							<c:when test="${reservations.status eq 'refunded'}">
								<span class="status-refunded">환불 완료</span>
							</c:when>
							<c:when test="${reservations.status eq 'cancelled'}">
								<span class="status-cancelled">사용자 취소</span>
							</c:when>
							<c:otherwise>${reservations.status}
        					</c:otherwise>
						</c:choose></td>
						<td><c:if test="${reservations.status eq 'reserved'}">
							<form id="refundForm_${reservations.id}"
								action="<c:url value='/admin/reservations/refund' />" method="post"> 
								<input type="hidden" name="id" value="${reservations.id}">
								<button type="submit" class="action-btn refund-btn"
									onclick="return confirm('${reservations.id}번 예매를 정말로 환불 처리하시겠습니까?');">
									환불</button>
							</form>
						</c:if><c:if test="${reservations.status ne 'reserved'}">     -
</c:if></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<%@ include file="end.jsp"%>
