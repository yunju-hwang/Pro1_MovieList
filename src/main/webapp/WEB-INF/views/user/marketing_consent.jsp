<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마케팅 정보 수신 동의</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/terms.css">
</head>
<body>
	<div class="terms-wrapper" style="max-width: 900px; margin: 50px auto;">
		<!-- 약관 내용은 스크롤 가능한 컨테이너 안에 -->
		<div class="terms-container"
			style="max-height: 600px; overflow-y: auto; padding: 20px; background: #fff;">
			<h1>마케팅 정보 수신 동의</h1>

			<p>
				<strong>제1조(목적)</strong><br> 본 약관은 (주)무비리스트(이하 ‘(주)무비리스트’)가
				제공하는 다양한 서비스 및 상품에 대한 정보, 혜택, 이벤트, 프로모션 등 마케팅 활동을 위해 필요한 고객의 개인정보를
				수집하고 이용하는 것에 대한 동의를 얻기 위함입니다.
			</p>

			<p>
				<strong>제2조(개인정보 수집 및 이용)</strong><br> (주)무비리스트는 다음 각 항의 개인정보를
				마케팅 및 홍보 목적으로 수집 및 이용할 수 있습니다.<br> – 수집 항목: 성명, 이메일, 전화번호, 주소,
				서비스 이용 기록, 접속 일시, IP 주소 등<br> – 이용 목적: 신상품 및 서비스 안내, 맞춤형 서비스
				제공, 이벤트 및 프로모션 안내, 시장 조사 및 서비스 개발 연구
			</p>

			<p>
				<strong>제3조(개인정보 제3자 제공)</strong><br> (주)무비리스트는 마케팅 목적 달성을 위해
				필요한 경우 다음과 같이 개인정보를 제3자에게 제공할 수 있습니다.<br> – 제공받는 자: (제3자 회사명
				기입)<br> – 제공 목적: (제3자 회사에서 마케팅 활동을 하는 목적 기입)<br> – 제공 항목:
				(제3자에게 제공되는 개인정보 항목 기입)
			</p>

			<p>
				<strong>제4조(동의 거부권 및 철회권)</strong><br> 귀하는 마케팅 목적의 개인정보 수집 및
				이용에 대한 동의를 거부할 수 있습니다. 동의하지 않더라도 서비스 이용에는 문제가 없으나, 마케팅 관련 혜택 및 정보
				제공이 제한될 수 있습니다.<br> 귀하는 언제든지 개인정보의 수집 및 이용, 제3자 제공 동의를 철회할 수
				있습니다. 동의 철회는 서면 통지, 전화, 이메일 등 (주)무비리스트가 정한 방법을 통해 가능하며, 철회 후에는 더 이상
				마케팅 정보가 발송되지 않습니다.
			</p>

			<p>
				<strong>제5조(개인정보 보유 기간)</strong><br> 귀하가 마케팅 수신 동의를 철회하거나 회원 탈퇴
				시점까지 보유 및 이용됩니다. 또한 정보통신망 이용촉진 및 정보보호 등에 관한 법률에 따라 광고성 정보 수신동의 여부는
				2년마다 확인해야 합니다.
			</p>

		</div>

		<!-- 확인 버튼: 스크롤 바깥에 고정(terms-wrapper 내 하단) -->
		<div style="text-align: center; margin-top: 12px;">
			<button class="confirm-btn" onclick="history.back()">확인</button>
		</div>
	</div>
</body>
</html>