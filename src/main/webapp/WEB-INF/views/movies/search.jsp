<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 검색창 -->
<div class="movie-search">
    <form id="movieSearchForm">
        <input type="text" id="searchInput" placeholder="영화 제목을 입력하세요" />
         <img src="${pageContext.request.contextPath}/resources/img/search.png" 
         id="searchBtn" alt="검색" />
    </form>
</div>


<!-- css -->
<style>
.movie-search {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 20px 0;
    gap: 10px;
}

.movie-search input[type="text"] {
	padding: 12px 20px;       /* 위아래 12px, 좌우 20px로 조금 넓게 */
    border-radius: 12px;
    border: 1px solid #ccc;
    font-size: 16px;
    width: 400px;             /* 기존 250px → 400px로 길게 */
}

.movie-search img {
    width: 30px;      /* 이미지 크기 조절 */
    height: 30px;
    cursor: pointer;
    transition: transform 0.2s;
    vertical-align: middle;
    
       /* 이미지 위치 조정 */
    margin-top: -1px;   /* 살짝 위로 이동 (~1mm 정도) */
    margin-left: 2px;   /* 검색창과 약간의 간격 (~2mm 정도) */

}

.movie-search img:hover {
    transform: scale(1.1); /* hover 시 살짝 커짐 */
}
</style>
</body>
</html>