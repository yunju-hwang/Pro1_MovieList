<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- 네비게이션 바는 dashboard.jsp처럼 상단에 포함 --%>
<%@ include file="/WEB-INF/views/admin/admin_navbar.jsp" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ 관리</title>
    
    <link rel="stylesheet" href="<c:url value='/resources/css/base.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/tabs_buttons.css' />"> 
    <link rel="stylesheet" href="<c:url value='/resources/css/tables.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/buttons.css' />"> 
</head>
<body>
    <div class="dashboard-container">
        <div class="main-content">
            <h2 class="content-title">FAQ 관리</h2>

            <div class="table-header">
                <button class="register-btn" onclick="openFaqModal()">FAQ 등록</button>
            </div>

            <div class="table-section">
                <table class="faq-table">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>카테고리</th>
                            <th>질문</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>3</td>
                            <td>예매/결제</td>
                            <td>결제 수단 변경은 어떻게 하나요?</td>
                     <td>
    <button class="action-btn edit-btn" onclick="editFaq(번호)">수정</button>
    <button class="action-btn delete-btn" onclick="deleteFaq(번호)">삭제</button>
</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>회원정보</td>
                            <td>비밀번호를 잊어버렸어요. 어떻게 해야 하나요?</td>
                           <td>
    <button class="action-btn edit-btn" onclick="editFaq(번호)">수정</button>
    <button class="action-btn delete-btn" onclick="deleteFaq(번호)">삭제</button>
</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="pagination-area">
            </div>

        </div>
    </div>

    <script>
        // 임시 JS 함수 (실제 구현은 추후에)
        function openFaqModal() {
            console.log("FAQ 등록 모달 열기");
        }
        function editFaq(id) {
            console.log(id + "번 FAQ 수정");
        }
        function deleteFaq(id) {
            console.log(id + "번 FAQ 삭제");
        }
    </script>
</body>
</html>