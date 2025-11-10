<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 | 회원 정보 수정</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        
    <style>
        /* ========================================================== */
        /* 1. 전역 스타일 및 NAV BAR 스타일 (기존 유지) */
        /* ========================================================== */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f7f7;
            min-height: 100vh;
        }

        .header-nav {
            width: 100%;
            background-color: #ffffff;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .header-nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
        }
        
        /* 🚨 회원 정보 메뉴를 활성화합니다. */
        .header-nav li {
            padding: 15px 25px;
            font-size: 14px;
            color: #555;
            cursor: pointer;
            transition: color 0.3s;
            border-bottom: 3px solid transparent; 
        }

        .header-nav li:hover {
            color: #ff4d4d;
        }
        
        /* 🚨 A 태그 스타일 (링크 스타일 초기화 및 영역 확장) */
        .header-nav li a {
            text-decoration: none; /* 링크 밑줄 제거 */
            color: inherit; /* 부모 li의 색상을 상속받음 */
            display: flex; /* 아이콘과 텍스트 중앙 정렬 */
            align-items: center; 
        }

        .header-nav li.active {
            color: #ff4d4d; 
            border-bottom: 3px solid #ff4d4d; 
            font-weight: bold;
        }

        .header-nav li i {
            margin-right: 5px;
        }
        
        /* ========================================================== */
        /* 2. 메인 컨텐츠 스타일 (폼에 맞게 너비 유지) */
        /* ========================================================== */
        .container {
            padding: 40px 20px;
            width: 100%;
            max-width: 500px; /* 폼에 맞게 너비 조정 */
            margin: 40px auto; 
        }

        .content-box {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); 
        }

        .content-box h1 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
            color: #333;
        }

        /* ========================================================== */
        /* 3. 회원 정보 폼 전용 스타일 (상세) */
        /* ========================================================== */
        
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
            font-size: 15px;
        }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 15px;
            box-sizing: border-box;
            background-color: #fff;
        }
        
        /* 아이디와 같은 수정 불가 필드 스타일 */
        .form-group input:read-only {
            background-color: #f0f0f0;
            color: #666;
            cursor: not-allowed;
        }
        
        .help-text {
            font-size: 12px;
            color: #888;
            margin-top: 5px;
        }
        
        /* 비밀번호 변경 버튼 그룹 */
        .password-group {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
        }
        
        .password-group button {
            /* 예매하기 버튼 색상 (붉은 계열)과 통일성을 위해 약간 변경 */
            background-color: #6c757d; 
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.2s;
        }

        .password-group button:hover {
            background-color: #5a6268;
        }

        /* 저장 버튼 (붉은 계열 유지) */
        .submit-button {
            width: 100%;
            background-color: #ff4d4d;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 4px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 30px;
            transition: background-color 0.2s;
        }

        .submit-button:hover {
            background-color: #e63939;
        }
    </style>
</head>
<body>
    
    <div class="header-nav">
        <ul>
            <li><a href="/movielist/mypage/reservations"><i class="fa-solid fa-calendar-check"></i> 예매 내역</a></li>
            <li><a href="/movielist/mypage/favorites"><i class="fa-regular fa-heart"></i> 관심 목록</a></li>
            <li class="active"><a href="/movielist/mypage/profile"><i class="fa-regular fa-user"></i> 회원 정보</a></li>
            <li><a href="/movielist/mypage/theaters"><i class="fa-solid fa-map-pin"></i> 선호 영화관</a></li>
            <li><a href="/movielist/mypage/paymentmethod"><i class="fa-solid fa-credit-card"></i> 결제 수단</a></li>
            <li><a href="/movielist/mypage/inquiries"><i class="fa-regular fa-clipboard"></i> 문의 내역</a></li>
            <li><a href="/movielist/mypage/movierequest"><i class="fa-solid fa-film"></i> 영화 요청</a></li>
        </ul>
    </div>

    <div class="container">
        <div class="content-box">
            <h1>회원 정보 수정</h1>
            
            <form action="/mypage/updateMember" method="POST" onsubmit="return validateForm()">
                
                <div class="form-group">
                    <label for="memberId">아이디</label>
                    <input type="text" id="memberId" name="memberId" value="${loginMember.memberId}" readonly>
                </div>
                
                <div class="form-group">
                    <label for="memberName">이름</label>
                    <input type="text" id="memberName" name="memberName" value="${loginMember.memberName}" readonly>
                    <p class="help-text">이름은 변경할 수 없습니다. 문의가 필요하면 고객센터를 이용해 주세요.</p>
                </div>

                <div class="form-group">
                    <label for="memberEmail">이메일</label>
                    <input type="email" id="memberEmail" name="memberEmail" value="${loginMember.memberEmail}">
                </div>
                
                <div class="form-group">
                    <label for="memberPhone">연락처</label>
                    <input type="text" id="memberPhone" name="memberPhone" value="${loginMember.memberPhone}">
                </div>

                <div class="form-group">
                    <label>비밀번호</label>
                    <p class="help-text">비밀번호는 보안을 위해 별도의 버튼을 통해 변경합니다.</p>
                    <div class="password-group">
                        <button type="button" onclick="openPasswordChangeModal()">
                            <i class="fa-solid fa-lock"></i> 비밀번호 변경
                        </button>
                    </div>
                </div>

                <button type="submit" class="submit-button">
                    <i class="fa-solid fa-floppy-disk"></i> 변경 사항 저장
                </button>
            </form>
            
        </div>
    </div>

    <script>
        // 폼 유효성 검사 (프론트엔드 예시)
        function validateForm() {
            const phone = document.getElementById('memberPhone').value.trim();
            const email = document.getElementById('memberEmail').value.trim();

            if (phone === "" || email === "") {
                alert("이메일과 연락처는 필수 입력 항목입니다.");
                return false;
            }
            
            // 이메일 형식 검사 (간단 예시)
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert("유효한 이메일 주소를 입력해주세요.");
                return false;
            }
            
            return confirm("회원 정보를 수정하시겠습니까?");
        }
        
        // 비밀번호 변경 모달/팝업 호출 함수 (더미)
        function openPasswordChangeModal() {
            alert("비밀번호 변경 팝업/모달이 곧 표시됩니다.");
            // 실제 구현: 별도의 비밀번호 변경 페이지로 이동 또는 모달 창 띄우기
        }
        
    </script>
</body>
</html>