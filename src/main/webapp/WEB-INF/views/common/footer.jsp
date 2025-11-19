<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value='/resources/css/footer.css' />">

<footer id="main-footer">
    <div class="footer-container">
        <div class="footer-links">
            <div class="footer-section">
                <h4>고객센터</h4>
                <%-- 공지사항 (Notice) --%>
                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser and sessionScope.loginUser.role eq 'admin'}">
                        <a href="<c:url value='/admin/notices'/>">공지사항 관리</a>
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/customer/notices'/>">공지사항</a> <%-- 비로그인/일반유저 목록 --%>
                    </c:otherwise>
                </c:choose>
                <%-- FAQ --%>
                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser and sessionScope.loginUser.role eq 'admin'}">
                        <a href="<c:url value='/admin/faqs'/>">FAQ 관리</a>
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/customer/faqs'/>">FAQ</a> <%-- 비로그인/일반유저 목록 --%>
                    </c:otherwise>
                </c:choose>
                <%-- 1:1 문의 (Inquiry) --%>
                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser and sessionScope.loginUser.role eq 'admin'}">
                        <a href="<c:url value='/admin/inquiries'/>">1:1 문의 관리</a>
                    </c:when>
                    <c:when test="${not empty sessionScope.loginUser}">
                        <a href="<c:url value='/customer/inquiries'/>">1:1 문의 등록</a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:void(0);" onclick="alert('로그인이 필요한 서비스입니다.');">1:1 문의</a>
                    </c:otherwise>
                </c:choose>
                <%-- 영화 등록 요청 (Movie Request) --%>
                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser and sessionScope.loginUser.role eq 'admin'}">
                        <a href="<c:url value='/admin/movie_requests'/>">영화 요청 관리</a>
                    </c:when>
                    <c:when test="${not empty sessionScope.loginUser}">
                        <a href="<c:url value='/customer/movie_request'/>">영화 등록 요청</a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:void(0);" onclick="alert('로그인이 필요한 서비스입니다.');">영화 등록 요청</a>
                    </c:otherwise>
                </c:choose>
            </div>
            <%-- 2. 약관 및 정책 --%>
            <div class="footer-section">
                <h4>약관 및 정책</h4>
                <a href="<c:url value='/terms/location'/>">위치기반서비스 이용약관</a>
                <a href="<c:url value='/terms/policy'/>">개인정보 처리방침</a>
                <a href="<c:url value='/terms'/>">이용약관</a>
                <a href="<c:url value='/terms/youth'/>">청소년보호정책</a>
            </div>

            <%-- 3. 회사 정보 및 주소 (고정 텍스트) --%>
            <div class="footer-section">
                <h4>회사 정보</h4>
                <p>무비리스트 | 대표: 홍길동</p>
                <p>사업자등록번호: 123-45-67890</p>
                <p>주소: 서울특별시 강남구 테헤란로 123, 10층 (직접입력)</p>
                <p>대표전화: 1588-0000</p>
                <p>이메일: support@movielist.com</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 MovieList Inc. All rights reserved.</p>
        </div>
    </div>
</footer>