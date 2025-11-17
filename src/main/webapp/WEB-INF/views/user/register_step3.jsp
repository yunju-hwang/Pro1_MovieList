<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>선호 장르 선택</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/register_step3.css" />
</head>
<body>
<div class="genre-container">
    <form class="genre-form" action="${pageContext.request.contextPath }/register/step3Pro" method="post">
        <h2>선호하는 영화 장르를 선택해주세요</h2>
        <p class="sub-text">여러 개 선택 가능합니다</p>

        <div class="genre-grid">
			
			<c:forEach var="genres" items="${genresVOList}"> 
				<label><input type="checkbox" name="genre" value="${genres.genreId }" ><span>${genres.genreName}</span></label>
			
			

</label>
			</c:forEach>

            
<!--             <label><input type="checkbox" name="genre" value="SF"> SF</label> -->
<!--             <label><input type="checkbox" name="genre" value="로맨스"> 로맨스</label> -->
<!--             <label><input type="checkbox" name="genre" value="드라마"> 드라마</label> -->
<!--             <label><input type="checkbox" name="genre" value="코미디"> 코미디</label> -->
<!--             <label><input type="checkbox" name="genre" value="스릴러"> 스릴러</label> -->
<!--             <label><input type="checkbox" name="genre" value="호러"> 호러</label> -->
<!--             <label><input type="checkbox" name="genre" value="판타지"> 판타지</label> -->
<!--             <label><input type="checkbox" name="genre" value="애니메이션"> 애니메이션</label> -->
<!--             <label><input type="checkbox" name="genre" value="다큐멘터리"> 다큐멘터리</label> -->
        </div>

        <div class="btn-row">
            <button type="button" class="prev-btn" onclick="history.back()">이전</button>
            <button type="submit" class="next-btn">가입 완료</button>
        </div>
    </form>
</div>

<script>
document.querySelectorAll('.genre-grid input[type="checkbox"]').forEach(input => {
    // 초기 선택 상태 반영
    if(input.checked) input.parentElement.classList.add('checked-label');

    input.addEventListener('click', function() {
        if(this.checked) {
            this.parentElement.classList.add('checked-label');
//             alert("T" + this.checked);
            this.setAttribute("checked","checked");
        } else {
            this.parentElement.classList.remove('checked-label');
//             alert("F" + this.checked);
            
        }
    });
});
</script>

</body>
</html>