<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추가 정보 입력</title>
<style>
    /* 전체 화면 Dim */
    body {
        margin: 0;
        padding: 0;
        background: rgba(0, 0, 0, 0.5);
        font-family: 'Segoe UI', sans-serif;
    }

    /* 모달 박스 */
    .modal-container {
        width: 400px;
        padding: 30px;
        background: white;
        border-radius: 12px;
        box-shadow: 0 0 20px rgba(0,0,0,0.2);

        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);

        animation: fadeIn 0.4s ease;
        box-sizing: border-box;
    }

    /* fade 애니메이션 */
    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translate(-50%, -45%);
        }
        to {
            opacity: 1;
            transform: translate(-50%, -50%);
        }
    }

    /* 제목 */
    .title {
        font-size: 22px;
        font-weight: bold;
        margin-bottom: 20px;
        text-align: center;
    }

    /* 라벨 + 인풋 */
    .form-group {
        margin-bottom: 15px;
    }
    .form-group label {
        display: block;
        font-size: 14px;
        margin-bottom: 6px;
        color: #333;
    }
    .form-group input {
        width: 100%;
        padding: 10px;
        border-radius: 6px;
        border: 1px solid #ccc;
        font-size: 15px;
        box-sizing: border-box;
    }

    /* 버튼 */
    .btn-submit {
        width: 100%;
        padding: 12px;
        background: #cd0000;
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 10px;
    }
    .btn-submit:hover {
        background: #b10000;
    }
</style>
</head>
<body>
<div class="modal-container">
    <div class="title">추가 정보 입력</div>
<form action="${pageContext.request.contextPath}/member/extra-infoPro" method="post">
        <div>
        <div class="form-group">
            <label>이메일</label>
            <input type="email" name="email" required />
         </div>
        </div>
		<div class="form-group">
        <div>
            <label>전화번호</label>
            <input type="text" name="phone" required placeholder="010-0000-0000"/>
        </div>
        </div>

        <button type="submit" class="btn-submit">저장하기</button>
    </form>
</div>
</body>
</html>