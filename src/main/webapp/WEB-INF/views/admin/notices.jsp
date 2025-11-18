<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/admin_navbar.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 관리</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/admin_base.css' />">
	<link rel="stylesheet" href="<c:url value='/resources/css/admin_form.css' />">
	<link rel="stylesheet" href="<c:url value='/resources/css/admin_table.css' />">

</head>
<body>
    <div class="dashboard-container">
        <div class="main-content">
            <h2 class="content-title">공지사항 관리</h2>

            <div class="table-header">
                <button class="register-btn" onclick="openNoticeModal()">공지 등록</button>
            </div>

            <div class="table-section">
                <table class="notice-table">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성일</th>
                            <th>조회수</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>10</td>
                            <%-- 인라인 스타일 제거 --%>
                            <td>시스템 정기 점검 안내 (11월 20일)</td>
                            <td>2025.11.05</td>
                            <td>1245</td>
                       <td>
    <button class="action-btn edit-btn" onclick="editNotice(번호)">수정</button>
    <button class="action-btn delete-btn" onclick="deleteNotice(번호)">삭제</button>
</td>
                        </tr>
                        <tr>
                            <td>9</td>
                            <td>개인정보처리방침 변경 예정 안내</td>
                            <td>2025.10.20</td>
                            <td>800</td>
                          <td>
    <button class="action-btn edit-btn" onclick="editNotice(번호)">수정</button>
    <button class="action-btn delete-btn" onclick="deleteNotice(번호)">삭제</button>
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
        function openNoticeModal() {
            console.log("공지 등록 모달 열기");
        }
        function editNotice(id) {
            console.log(id + "번 공지 수정");
        }
        function deleteNotice(id) {
            console.log(id + "번 공지 삭제");
        }
    </script>
</body>
</html>