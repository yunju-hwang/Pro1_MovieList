<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 목록</title>

<style>
        body { font-family: Arial; background: #f7f7f7; padding: 20px; }
        .movie-container { 
            display: flex; 
            flex-wrap: wrap; 
            gap: 20px; 
        }
        .movie-card {
            width: 230px;
            background: white;
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.2);
        }
        .poster {
            width: 100%;
            border-radius: 8px;
        }
        .title {
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
        }
        .date {
            font-size: 14px;
            color: #555;
        }
        .overview {
            font-size: 13px;
            margin-top: 8px;
            color: #333;
        }
        .genre-tag {
    		display: inline-block;
    		background: #ffdddd;
    		color: #333;
    		padding: 4px 8px;
    		margin: 2px;
    		border-radius: 8px;
    		font-size: 12px;
}
 </style>

</head>
<body>

<h2>영화 목록</h2>
<div class="movie-container">
	<c:forEach var="movie" items="${movies }">
		<div class="movie-card">
			<c:if test="${not empty movie.posterPath }">
			 	<img class="poster"
			 		 src="https://image.tmdb.org/t/p/w300${movie.posterPath }"
			 		 alt="${movie.title }"/>
					
			</c:if>
			
			<div class="title">${movie.title }</div>
			<div class="date">${movie.releaseDate }</div>
			<!-- 장르 출력 부분 -->
        	<div class="genres">
            	<c:forEach var="g" items="${movie.genres}">
                	<span class="genre-tag">${g}</span>
            	</c:forEach>
        	</div>
			<div class="overview">
				<c:out value="${movie.overview }"/>
			</div>
		</div>
	</c:forEach>

</div>

</body>
</html>