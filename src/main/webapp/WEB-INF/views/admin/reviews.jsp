<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<div class="table-section">
    <table class="review-table">
        <thead>
            <tr>
                <th>번호</th>
                <th>영화 제목</th>
                <th>작성자</th>
                <th style="width: 33%;">리뷰 내용</th> <!-- 내용을 가장 넓게! -->
                <th>평점</th>
                <th>감정</th>
                <th>날짜</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <!-- ⭐️ 나중에 DB에서 데이터를 가져와서 반복문으로 채워 넣을 거야 -->
            <tr>
                <td>4</td>
                <td>다크나이트</td>
                <td>직장인할줄</td>
                <td class="review-content-cell">히스 레저의 조커 연기는 특히 뛰어납니다.</td>
                <td class="rating-cell">
                    <span class="star-rating">⭐️⭐️⭐️⭐️⭐️</span>
                </td>
                <td><span class="sentiment-badge positive">긍정</span></td>
                <td>2025.11.03</td>
                <td>
                    <button class="action-icon-btn">
                        <img src="<c:url value='/resources/img/trash_red.png'/>" alt="삭제 아이콘">
                    </button>
                </td>
            </tr>
            <tr>
                <td>3</td>
                <td>타이타닉</td>
                <td>영화읽어여</td>
                <td class="review-content-cell">제임스 카메론 감독의 &lt;타이타닉&gt;은 단순한 영화가 아닙니다.</td>
                <td class="rating-cell">
                    <span class="star-rating">⭐️⭐️⭐️⭐️⭐️</span>
                </td>
                <td><span class="sentiment-badge positive">긍정</span></td>
                <td>2025.11.03</td>
                <td>
                    <button class="action-icon-btn">
                        <img src="<c:url value='/resources/img/trash_red.png'/>" alt="삭제 아이콘">
                    </button>
                </td>
            </tr>
             <tr>
                <td>2</td>
                <td>쇼생크 탈출</td>
                <td>출근극혐 34</td>
                <td class="review-content-cell">회사에서 불만만 하네요.</td>
                <td class="rating-cell">
                    <span class="star-rating">⭐️</span>
                </td>
                <td><span class="sentiment-badge negative">부정</span></td>
                <td>2025.11.03</td>
                <td>
                    <button class="action-icon-btn">
                        <img src="<c:url value='/resources/img/trash_red.png'/>" alt="삭제 아이콘">
                    </button>
                </td>
            </tr>
            <tr>
                <td colspan="8" class="no-data" style="display:none;">등록된 리뷰가 없습니다.</td>
            </tr>
        </tbody>
    </table>
</div>