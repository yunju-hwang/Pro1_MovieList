<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/privacy_policy.css' />">
</head>
<body>
<div class="page-wrapper">
    <div class="policy-box">

        <div class="policy-title">청소년보호정책<br>무비리스트(MovieList)</div>

        <div class="section">
            <h3 class="section-title">1. 목적</h3>
            <p class="section-desc">
                이 정책은 청소년(만 19세 미만)의 유해정보로부터 보호하고, 건전한 서비스 이용 환경을 조성하기 위한 회사의 원칙 및 절차를 규정합니다.
            </p>
        </div>

        <div class="section">
            <h3 class="section-title">2. 유해정보의 정의</h3>
            <p class="section-desc">
                유해정보란 폭력·음란·마약·도박 등 청소년의 성장발달에 부정적 영향을 미칠 수 있는 정보 및 서비스를 말합니다.
            </p>
        </div>

        <div class="section">
            <h3 class="section-title">3. 연령확인 및 이용제한</h3>
            <p class="section-desc">
                회사는 서비스 이용 시 연령확인이 필요한 경우 본인확인 절차를 요구할 수 있으며, 연령 제한 대상 콘텐츠는 청소년이 접근하지 못하도록 차단합니다.
            </p>
        </div>

        <div class="section">
            <h3 class="section-title">4. 유해정보의 차단 및 관리</h3>
            <p class="section-desc">
                회사는 유해정보로 판단되는 게시물·광고·콘텐츠에 대해 사전·사후 점검을 실시하며, 위반 시 해당 콘텐츠 삭제·차단 및 관련 계정에 대해 제재를 가합니다.
            </p>
            <ul class="policy-list">
                <li>자동화 필터·AI 검수 도구의 활용</li>
                <li>사용자 신고 접수 및 신고 처리 프로세스 운영</li>
                <li>재발 방지를 위한 계정 제재 및 교육 안내</li>
            </ul>
        </div>

        <div class="section">
            <h3 class="section-title">5. 보호자 및 법정대리인 안내</h3>
            <p class="section-desc">
                보호자(법정대리인)는 청소년의 서비스 이용에 대해 관리·감독할 권리와 의무가 있으며, 필요한 경우 회사에 청소년 계정 관련 권리행사(열람·삭제 요청 등)를 요청할 수 있습니다.
            </p>
        </div>

        <div class="section">
            <h3 class="section-title">6. 신고 및 문의</h3>
            <p class="section-desc">
                유해정보 발견 시 즉시 회사에 신고해 주시기 바라며, 회사는 접수 즉시 조사하여 필요 조치를 취합니다.
            </p>

            <div class="info-card">
                <p><strong>신고 연락처</strong></p>
                <ul>
                    <li>이메일: abuse@movielist.com</li>
                    <li>전화: 02-1234-5678 (평일 09:00~18:00)</li>
                </ul>
            </div>
        </div>

        <div class="section">
            <h3 class="section-title">7. 교육·홍보</h3>
            <p class="section-desc">
                회사는 청소년 보호를 위해 이용자 대상 교육 및 안내 자료를 제공하고, 정기적으로 내부 직원 대상 관련 교육을 실시합니다.
            </p>
        </div>

         <div class="effective">부칙: 본 방침은 2025년 1월 1일부터 시행합니다.</div>

    </div>
</div>
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>