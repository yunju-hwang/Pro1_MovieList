<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 처리방침</title>
<link rel="stylesheet" href="<c:url value='/resources/css/privacy_policy.css' />">
</head>
<body>
<div class="page-wrapper">
    <div class="policy-box">

        <div class="policy-title">개인정보 처리방침<br>무비리스트(MovieList)</div>

        <div class="section">
            <h3 class="section-title">1. 총칙</h3>
            <p class="section-desc">
                무비리스트 주식회사(이하 "회사")는 이용자의 개인정보를 중요시하며, 관련 법령을 준수합니다.
                본 개인정보 처리방침은 회사가 수집·이용·보관·파기하는 개인정보의 항목, 보유기간, 제3자 제공, 이용자 권리 및 행사 방법 등을 설명합니다.
            </p>
        </div>

        <div class="section">
            <h3 class="section-title">2. 수집하는 개인정보 항목</h3>
            <p class="section-desc">회사는 서비스 제공을 위해 다음과 같은 항목의 개인정보를 수집합니다.</p>

            <ul class="policy-list">
                <li><strong>회원가입 및 관리:</strong> 이름, 이메일, 비밀번호(암호화 저장), 전화번호, 회원ID 등</li>
                <li><strong>서비스 이용 기록:</strong> 접속 로그, 쿠키, IP 주소, 기기정보, 서비스 이용기록</li>
                <li><strong>결제 관련(해당 시):</strong> 결제자명, 결제수단, 거래내역 (단, 결제정보는 결제대행사를 통해 처리될 수 있음)</li>
                <li><strong>위치정보(위치기반 서비스 관련):</strong> 위치 좌표, 위치 요청 시간 등 (동의 기반)</li>
                <li><strong>문의/고충 처리:</strong> 문의 내용, 처리결과, 통화·문자 기록(녹취 포함, 사전 고지 시)</li>
            </ul>
        </div>

        <div class="section">
            <h3 class="section-title">3. 개인정보 수집 방법</h3>
            <p class="section-desc">
                이용자는 회원가입, 서비스 이용, 고객센터 문의, 이벤트 응모 등 다양한 경로로 개인정보를 제공할 수 있으며,
                회사는 로그, 쿠키 등 자동 수집 방법을 통해서도 일부 정보를 수집합니다.
            </p>
        </div>

        <div class="section">
            <h3 class="section-title">4. 개인정보의 수집 및 이용 목적</h3>
            <ul class="policy-list">
                <li>서비스 제공 및 유지·개선, 맞춤형 콘텐츠 제공</li>
                <li>회원 관리(고유식별, 본인확인, 불만처리 등)</li>
                <li>서비스의 통계 및 분석을 통한 품질 개선</li>
                <li>위치기반 서비스 제공 및 안전/보안 목적</li>
                <li>법령상 의무 이행 및 분쟁해결</li>
            </ul>
        </div>

        <div class="section">
            <h3 class="section-title">5. 개인정보 보유·이용 기간</h3>
            <p class="section-desc">
                원칙적으로 개인정보의 보유기간은 수집 및 이용목적 달성 시까지이며, 관련 법령에 따라 별도의 보관 기간이 요구되는 경우 해당 기간 동안 보관합니다.
            </p>
            <ul class="policy-list">
                <li>회원정보: 탈퇴 시까지(단, 관계법령에 의해 보관할 필요가 있는 경우 해당 기간 보관)</li>
                <li>위치정보 제공 사실 확인자료: 위치정보 보호법에 따라 6개월 이상 보관</li>
                <li>거래정보(결제 등): 전자상거래법 등 관련 법령에 따른 보관기간 준수</li>
            </ul>
        </div>

        <div class="section">
            <h3 class="section-title">6. 개인정보 파기절차 및 방법</h3>
            <p class="section-desc">
                목적 달성 후 즉시 또는 관련 법령에 따라 보관 기간 경과 시 지체 없이 파기합니다. 전자적 파일 형태는 복구 불가능한 방법으로 삭제하며, 기록물은 분쇄하거나 소각합니다.
            </p>
        </div>

        <div class="section">
            <h3 class="section-title">7. 개인정보의 제3자 제공</h3>
            <p class="section-desc">
                원칙적으로 이용자의 개인정보를 제3자에게 제공하지 않으며, 다음의 경우에만 제공합니다:
            </p>
            <ul class="policy-list">
                <li>이용자의 사전 동의를 받은 경우</li>
                <li>법령에 의하여 요구되는 경우(수사기관 등)</li>
                <li>서비스 제공을 위해 업무 위탁하는 경우(위탁업체는 개인정보 보호 계약 체결)</li>
            </ul>
        </div>

        <div class="section">
            <h3 class="section-title">8. 위탁처리</h3>
            <p class="section-desc">
                회사는 원활한 서비스 제공을 위해 아래와 같은 업무를 외부 전문업체에 위탁할 수 있습니다. 위탁 시 위탁업체와 개인정보보호 관련 계약을 체결하여 안전하게 관리합니다.
            </p>
            <div class="info-card">
                <p><strong>예: 위탁 대상 업무</strong></p>
                <ul>
                    <li>결제 처리 및 정산</li>
                    <li>호스팅 및 데이터 저장</li>
                    <li>고객센터 운영</li>
                    <li>통계분석 및 마케팅</li>
                </ul>
            </div>
        </div>

        <div class="section">
            <h3 class="section-title">9. 이용자 및 법정대리인의 권리·행사방법</h3>
            <p class="section-desc">
                이용자는 언제든지 개인정보 열람·정정·삭제·처리정지 등을 요청할 수 있으며, 회사는 관련 법령에 따라 지체 없이 처리합니다.
                만 14세 미만 아동의 개인정보는 법정대리인이 그 권리를 행사할 수 있습니다.
            </p>
        </div>

        <div class="section">
            <h3 class="section-title">10. 개인정보의 안전성 확보조치</h3>
            <ul class="policy-list">
                <li>관리적 조치: 내부관리계획 수립·관리, 직원 교육 등</li>
                <li>기술적 조치: 접속기록 보관, 접근통제, 암호화, 침입탐지 시스템 등</li>
                <li>물리적 조치: 전산실·자료보관실 접근 통제</li>
            </ul>
        </div>

        <div class="section">
            <h3 class="section-title">11. 쿠키(Cookie)의 운용 및 거부</h3>
            <p class="section-desc">
                회사는 서비스 최적화·이용자 편의 제공을 위해 쿠키를 사용합니다. 이용자는 브라우저 설정을 통해 쿠키 저장을 거부할 수 있으나, 일부 서비스 이용에 제한이 있을 수 있습니다.
            </p>
        </div>

        <div class="section">
            <h3 class="section-title">12. 국제전송</h3>
            <p class="section-desc">
                회사는 이용자의 개인정보를 원칙적으로 해외에 전송하지 않습니다. 다만, 서비스 제공을 위해 필요한 경우에는 관련 법령 및 이용자의 동의를 거쳐 안전하게 처리합니다.
            </p>
        </div>

        <div class="section">
            <h3 class="section-title">13. 고지의 의무</h3>
            <p class="section-desc">
                본 개인정보 처리방침의 내용 변경 시 웹사이트 공지사항 또는 이메일 등을 통해 사전 고지합니다.
            </p>
        </div>

        <div class="section">
            <h3 class="section-title">14. 연락처</h3>
            <p class="section-desc">개인정보 관련 문의·권리행사는 아래 연락처로 문의해 주세요.</p>

            <div class="contact-grid">
                <div class="contact-item">
                    <strong>회사 정보</strong>
                    <div>상호: 무비리스트 주식회사</div>
                    <div>주소: 서울특별시 강남구 테헤란로 123 무비리스트타워</div>
                    <div>대표전화: 02-1234-5678</div>
                </div>

                <div class="contact-item">
                    <strong>개인정보 보호책임자</strong>
                    <div>이름: 홍길동 CPO</div>
                    <div>이메일: privacy@movielist.com</div>
                    <div>전화: 02-1234-5678</div>
                </div>
            </div>
        </div>

        <div class="effective">부칙: 본 방침은 2025년 1월 1일부터 시행합니다.</div>

    </div>
</div>
</body>
</html>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>