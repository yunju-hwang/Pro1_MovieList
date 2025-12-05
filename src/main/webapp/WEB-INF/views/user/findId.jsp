<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <title>아이디 찾기</title>
<style>
   
    /* -------------------------------------------------- */
/* 기본 및 배경 설정 (body) */
/* -------------------------------------------------- */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap');

html, body {
    height: 100%; /* HTML과 BODY가 뷰포트 높이를 모두 사용하도록 설정 */
    margin: 0;
    font-family: 'Inter', sans-serif;
    background-color: #f0f2f5; /* 밝은 배경 */
}

body {
    display: flex;
    justify-content: center; /* 수평 중앙 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    min-height: 100vh; /* 뷰포트 전체 높이 사용 */
    padding: 0;
}

/* -------------------------------------------------- */
/* Container (로그인 페이지와 통일된 카드 스타일) */
/* -------------------------------------------------- */
.container {
    background-color: #fcfcfc;
    padding: 25px; /* 💡 패딩 다시 감소 (30px -> 25px) */
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 350px; /* 💡 최대 너비도 약간 줄여서 더 작아 보이게 함 */
    text-align: center;
}

.container h2 {
    color: #333;
    margin-bottom: 15px; /* 💡 마진 감소 (20px -> 15px) */
    font-weight: 700;
}

/* -------------------------------------------------- */
/* Form Group & Input Styling (입력 필드 스타일) */
/* -------------------------------------------------- */
.form-group {
    margin-bottom: 10px; /* 💡 마진 감소 (15px -> 10px) */
    text-align: left;
}

.form-group label {
    display: block;
    margin-bottom: 3px; /* 💡 마진 감소 (5px -> 3px) */
    color: #555;
    font-size: 14px;
    font-weight: 600;
}

.form-group input[type="text"],
.form-group input[type="email"] {
    width: 100%;
    padding: 8px; /* 💡 패딩 감소 (10px -> 8px) */
    border: 1px solid #ccc;
    border-radius: 8px;
    box-sizing: border-box;
    font-size: 16px;
    transition: border-color 0.3s, box-shadow 0.3s;
}

.form-group input[type="text"]:focus,
.form-group input[type="email"]:focus {
    border-color: #007bff; /* 포커스 시 색상 변경 */
    box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.25);
    outline: none;
}

/* -------------------------------------------------- */
/* Button Styling (버튼 스타일) */
/* -------------------------------------------------- */
.btn {
    width: 100%;
    padding: 8px; /* 💡 패딩 감소 (10px -> 8px) */
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 16px;
    font-weight: 600;
    margin-top: 5px; /* 💡 마진 감소 (8px -> 5px) */
    transition: background-color 0.3s, transform 0.1s;
}

.btn-primary {
    background-color: red; /* 아이디 찾기 페이지와 동일한 빨간색 버튼 */
    color: white;
}

.btn-primary:hover {
    background-color: #c00; /* 조금 더 어두운 빨간색 (호버 효과) */
    transform: translateY(-1px);
}

.btn-secondary {
    background-color: #6c757d; /* 회색 (보조 행동) */
    color: white;
}

.btn-secondary:hover {
    background-color: #5a6268;
    transform: translateY(-1px);
}
</style>
</head>

<body>
    <!-- 💡 Container로 감싸서 로그인 페이지와 통일성 유지 -->
    <div class="container">
        <h2>아이디 찾기</h2>
        <form action="${pageContext.request.contextPath}/findId/sendEmail" method="post">
            <div class="form-group">
                <label for="email">가입 시 입력한 이메일:</label>
                <input type="email" id="email" name="email" placeholder="이메일 주소를 입력하세요" required>
            </div>
           
            <!-- 💡 버튼 클래스 (login.jsp의 버튼 스타일 사용) -->
            <button type="submit" class="btn btn-primary">이메일 전송</button>
            <button type="button" onclick="history.back()" class="btn btn-secondary">뒤로 가기</button>
        </form>
    </div>
</body>
</html>