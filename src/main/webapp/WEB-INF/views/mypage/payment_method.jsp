<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp"%>

<head>
    <meta charset="UTF-8">
    <title>마이페이지 | 결제 수단 관리</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
/* ========================================================== */
/* 1. 전역 스타일 및 NAV BAR 스타일 */
/* ========================================================== */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f7f7f7;
    min-height: 100vh;
}

/* 🚨 마이페이지 가로형 메뉴 컨테이너 */
.header-nav {
    width: 100%;
    background-color: #ffffff;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    padding: 3px 0;
    margin-bottom: 40px; /* 컨텐츠 박스와 분리 */
}

.header-nav ul {
    list-style: none;
    padding: 0;
    margin: 0;
    display: flex;
    justify-content: center;
}

.header-nav li {
    padding: 12px 20px;
    font-size: 14px;
    color: #555;
    cursor: pointer;
    transition: color 0.3s, background-color 0.3s;
    border-radius: 4px;
    margin: 0 7px;
}

.header-nav li:hover {
    color: white;
    background-color: #cd0000;
}

.header-nav li a {
    text-decoration: none;
    color: inherit;
    display: flex;
    align-items: center;
}

/* 🚨 활성화 메뉴 스타일 */
.header-nav li.active {
    color: white;
    background-color: #cd0000;
    font-weight: bold;
}

.header-nav li.active:hover {
    background-color: #a00000;
    color: white;
}

.header-nav li i {
    margin-right: 5px;
}

/* ========================================================== */
/* 2. 메인 컨텐츠 스타일 */
/* ========================================================== */
.container {
    padding: 0 20px;
    width: 100%;
    max-width: 600px;
    margin: 0 auto 40px auto;
}

.content-box {
    background-color: #ffffff;
    padding: 40px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.content-box h1 {
    text-align: left;
    margin-bottom: 30px;
    font-size: 24px;
    color: #333;
}

/* ========================================================== */
/* 3. 결제 수단 전용 스타일 (리스트, 폼 등) */
/* ========================================================== */
/* 등록된 결제 수단 없을 때 메시지 */
.empty-state-message {
	text-align: center;
	padding: 60px 0 60px 0;
	color: #999;
	font-size: 16px;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	border: 2px dashed #ddd;
	border-radius: 8px;
	margin-top: 20px;
	margin-bottom: 20px;
}

.empty-state-message .empty-icon {
	font-size: 3.5em;
	color: #aaa;
	margin-bottom: 15px;
}

.empty-state-message .sub-text {
	font-size: 14px;
	color: #777;
	margin-top: 5px;
}

/* 카드 등록 버튼 스타일 */
.register-button {
	background-color: #cd0000;
	color: white;
	border: none;
	width: 100%;
	padding: 18px 20px;
	border-radius: 4px;
	font-size: 18px;
	font-weight: bold;
	cursor: pointer;
	transition: background-color 0.2s;
}

.register-button:hover {
	background-color: #a00000;
}

/* 폼 그룹 및 인풋 스타일 */
.form-group { margin-bottom: 20px; }
.form-group label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
.form-input { 
    width: 100%; 
    height: 44px; 
    padding: 12px; 
    border: 1px solid #ddd; 
    border-radius: 4px; 
    box-sizing: border-box; /* 🚨 이 속성이 중요합니다. (이미 설정되어 있음) */
}
.help-text { font-size: 13px; color: #888; margin-top: 5px; }

.form-row { display: flex; gap: 20px; align-items: flex-start; }
.form-row .form-group { flex: 1; display: flex; flex-direction: column; justify-content: flex-start; gap: 5px; }


/* 🚨 카드 번호 분리 입력 스타일 추가 */
.card-number-group {
    display: flex;
    gap: 8px; /* 🚨 간격을 10px에서 8px로 미세 조정하여 여유 공간 확보 */
    width: 100%; /* 부모의 100% 너비를 사용하도록 명시 */
}

.card-number-group .card-input-part {
    flex: 1; 
    height: 44px;
    padding: 12px 5px; /* 🚨 좌우 패딩을 줄여 너비 확보 */
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box; /* 🚨 box-sizing 명시 (패딩과 보더가 너비에 포함되도록) */
    text-align: center;
    font-size: 16px;
    min-width: 0; /* flex 아이템이 넘치는 것을 방지 */
}

/* 폼 설명 */
#payment-form-area .form-description {
	text-align: left;
	margin-bottom: 30px;
	color: #555;
	font-size: 16px;
	font-weight: 500;
}

/* 폼 액션 버튼 스타일 */
.form-action-buttons { display: flex; justify-content: flex-end; gap: 10px; margin-top: 30px; }
.form-button { padding: 12px 20px; border-radius: 4px; font-weight: bold; cursor: pointer; transition: background-color 0.2s; }
.btn-cancel { background-color: #eee; color: #333; border: 1px solid #ddd; }
.btn-cancel:hover { background-color: #e0e0e0; }
.btn-submit { background-color: #cd0000; color: white; border: none; }
.btn-submit:hover { background-color: #a00000; }

/* 유형 선택 버튼 스타일 */
.form-type-selection-buttons { display: flex; justify-content: space-between; gap: 10px; margin-bottom: 30px; }
.form-type-selection-buttons .type-button { flex: 1; padding: 15px 10px; background-color: #f0f0f0; color: #333; border: 1px solid #ddd; font-size: 16px; font-weight: bold; transition: all 0.2s; }
.form-type-selection-buttons .type-button.active { background-color: #cd0000; color: white; border-color: #cd0000; }
#register-content-container { padding-top: 20px; border-top: 1px solid #eee; }
</style>
</head>

<body>
    
    <div class="header-nav">
        <ul>
            <li><a href="/movielist/mypage/reservations"><i class="fa-solid fa-calendar-check"></i> 예매 내역</a></li>
            <li><a href="/movielist/mypage/favorites"><i class="fa-regular fa-heart"></i> 관심 목록</a></li>
            <li><a href="/movielist/mypage/profile"><i class="fa-regular fa-user"></i> 회원 정보</a></li>
            <li><a href="/movielist/mypage/theaters"><i class="fa-solid fa-map-pin"></i> 선호 영화관</a></li>
            <li class="active"><a href="/movielist/mypage/paymentmethod"><i class="fa-solid fa-credit-card"></i> 결제 수단</a></li>
            <li><a href="/movielist/mypage/inquiries"><i class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
            <li><a href="/movielist/mypage/movierequest"><i class="fa-solid fa-film"></i> 영화 요청</a></li>
        </ul>
    </div>
    
    <div class="container">
		<div class="content-box">
			<h1 id="page-title">결제 수단 관리</h1>

			<div id="payment-list-area">
				<div class="payment-list">
					<div class="empty-state-message">
						<i class="fa-regular fa-credit-card empty-icon"></i>
						<p>등록된 결제 수단이 없습니다.</p>
						<p class="sub-text">새로운 결제 수단을 등록해주세요.</p>
					</div>
				</div>

				<div class="action-bar" id="list-action-bar">
					<button class="register-button" id="show-form-button">
						<i class="fa-solid fa-plus"></i> 카드/계좌 등록하기
					</button>
				</div>
			</div>

			<div id="payment-form-area" style="display: none;">

				<div class="form-action-buttons form-type-selection-buttons">
					<button type="button" class="form-button type-button"
						id="show-card-form">신용/체크카드 등록</button>
					<button type="button" class="form-button type-button"
						id="show-account-form">계좌이체/무통장 등록</button>
				</div>

				<div id="register-content-container">
					<p class="form-description" id="form-title-description">새로운 결제
						수단 정보를 입력해주세요.</p>

					<form id="payment-register-form">

						<div id="card-form-content" style="display: none;">

							<div class="form-group">
								<label for="cardCompany">카드사 선택 *</label> 
								<select id="cardCompany" name="card_company" class="form-input select-input" required>
									<option value="">카드사를 선택하세요</option>
									</select>
							</div>

							<div class="form-group">
								<label for="cardNumber1">카드 번호 *</label> 
								<div class="card-number-group">
									<input type="text" id="cardNumber1" name="card_number_part1" class="card-input-part" placeholder="0000" maxlength="4" required>
									<input type="text" id="cardNumber2" name="card_number_part2" class="card-input-part" placeholder="0000" maxlength="4" required>
									<input type="text" id="cardNumber3" name="card_number_part3" class="card-input-part" placeholder="0000" maxlength="4" required>
									<input type="text" id="cardNumber4" name="card_number_part4" class="card-input-part" placeholder="0000" maxlength="4" required>
								</div>
							</div>

							<div class="form-row">
								<div class="form-group"> 
                                     <label for="expiryDate">유효 기간 (MM/YY) *</label> 
									<input type="text" id="expiryDate" name="expiry_date" class="form-input" placeholder="MM/YY" maxlength="4" required>
								</div>
								<div class="form-group"> 
                                     <label for="password">비밀번호 앞 2자리 *</label> 
									<input type="password" id="password" name="pin_first_two" class="form-input" placeholder="**" maxlength="2" required>
								</div>
							</div>
							
							</div>

						<div id="account-form-content" style="display: none;">
							<div class="form-group">
								<label for="bankName">은행 선택 *</label> 
								<select id="bankName" class="form-input select-input">
									<option value="">은행을 선택하세요</option>
									<option value="woori">우리은행</option>
									<option value="kb">KB국민은행</option>
									<option value="shinhan">신한은행</option>
									<option value="hana">하나은행</option>
									<option value="nh">NH농협은행</option>
								</select>
							</div>
							<div class="form-group">
								<label for="accountNumber">계좌 번호 *</label> 
								<input type="text" id="accountNumber" class="form-input" placeholder="계좌 번호를 입력하세요">
							</div>
							<div class="form-group">
								<label for="accountHolder">예금주 *</label> 
								<input type="text" id="accountHolder" class="form-input" placeholder="예금주 이름을 입력하세요">
							</div>
						</div>

						<div class="form-action-buttons">
							<button type="button" class="form-button btn-cancel"
								id="cancel-form-button">취소</button>
							<button type="submit" class="form-button btn-submit"
								id="submit-register-button">등록하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script>
document.addEventListener('DOMContentLoaded', function() {
    // 폼 전환에 필요한 요소
    const listArea = document.getElementById('payment-list-area');
    const formArea = document.getElementById('payment-form-area');
    const showFormButton = document.getElementById('show-form-button'); // 목록의 '카드/계좌 등록하기' 버튼
    const cancelFormButton = document.getElementById('cancel-form-button'); // 폼 내부의 '취소' 버튼
    const pageTitle = document.getElementById('page-title');
    
    // 유형 선택 버튼 및 폼 요소
    const showCardButton = document.getElementById('show-card-form');
    const showAccountButton = document.getElementById('show-account-form');
    const typeButtons = document.querySelectorAll('.form-type-selection-buttons .type-button');
    
    const registerContentContainer = document.getElementById('register-content-container');
    const cardFormContent = document.getElementById('card-form-content');
    const accountFormContent = document.getElementById('account-form-content');
    const formDescription = document.getElementById('form-title-description');
    const registerForm = document.getElementById('payment-register-form');


    // ---------------------------------------------------------------------
    // ✅ 폼 내용 토글 및 버튼 활성화 함수
    // ---------------------------------------------------------------------
    function setActiveForm(formType) {
        // 모든 폼 내용 및 폼을 숨김
        cardFormContent.style.display = 'none';
        accountFormContent.style.display = 'none';
        registerContentContainer.style.display = 'block';

        // 버튼 상태 초기화
        typeButtons.forEach(btn => btn.classList.remove('active'));

        // 선택된 폼만 표시하고 버튼 활성화
        if (formType === 'card') {
            cardFormContent.style.display = 'block';
            showCardButton.classList.add('active');
            formDescription.textContent = '새로운 신용/체크카드 정보를 입력해주세요.';
            document.getElementById('cardCompany').focus();
        } else if (formType === 'account') {
            accountFormContent.style.display = 'block';
            showAccountButton.classList.add('active');
            formDescription.textContent = '새로운 계좌이체 정보를 입력해주세요.';
            document.getElementById('bankName').focus();
        }
        
        // 폼 초기화
        registerForm.reset();
    }
    
    // ---------------------------------------------------------------------
    // ✅ 카드 번호 입력 시 자동 포커스 이동 기능 (UX 개선)
    // ---------------------------------------------------------------------
    const cardNumberInputs = [
        document.getElementById('cardNumber1'),
        document.getElementById('cardNumber2'),
        document.getElementById('cardNumber3'),
        document.getElementById('cardNumber4')
    ];

    cardNumberInputs.forEach((input, index) => {
        input.addEventListener('input', function(e) {
            // 4자리를 모두 입력했을 때
            if (this.value.length === this.maxLength) {
                // 다음 칸이 있다면 다음 칸으로 포커스 이동
                if (index < cardNumberInputs.length - 1) {
                    cardNumberInputs[index + 1].focus();
                }
            }
        });
        // 숫자만 입력되도록 강제 (선택 사항)
        input.addEventListener('keypress', function(e) {
            if (e.charCode < 48 || e.charCode > 57) {
                e.preventDefault();
            }
        });
    });

    // ---------------------------------------------------------------------
    // ✅ 이벤트 핸들러
    // ---------------------------------------------------------------------

    // '카드/계좌 등록하기' 버튼 클릭 이벤트 (목록 -> 폼)
    showFormButton.addEventListener('click', function() {
        listArea.style.display = 'none';
        formArea.style.display = 'block';
        pageTitle.textContent = '결제 수단 등록';
        
        // 폼 영역을 표시하지만, 처음에는 카드/계좌 버튼만 보이고 실제 폼 내용은 숨겨둡니다.
        registerContentContainer.style.display = 'none';	
        
        // 모든 버튼의 active 상태를 제거하고 폼 내용을 숨김
        typeButtons.forEach(btn => btn.classList.remove('active'));
        cardFormContent.style.display = 'none';
        accountFormContent.style.display = 'none';
    });

    // '신용/체크카드 등록' 버튼 클릭 이벤트
    showCardButton.addEventListener('click', function() {
        setActiveForm('card');
    });

    // '계좌이체/무통장 등록' 버튼 클릭 이벤트
    showAccountButton.addEventListener('click', function() {
        setActiveForm('account');
    });

    // '취소' 버튼 클릭 이벤트 (폼 -> 목록)
    cancelFormButton.addEventListener('click', function() {
        registerForm.reset();
        
        formArea.style.display = 'none';
        listArea.style.display = 'block';
        pageTitle.textContent = '결제 수단 관리';
    });
    
});
</script>

</body>
</html>