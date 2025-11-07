<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MovieList Main</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/list.css">

</head>
<body>

<h2>영화 목록</h2>
<div id="movie-container"></div>

<script>
fetch('${pageContext.request.contextPath}/movies/list')
    .then(response => response.json())
    .then(data => {
        const container = document.getElementById('movie-container');
        data.forEach(movie => {
            const card = document.createElement('div');
            card.className = 'movie-card';

            card.innerHTML = `
                <img src="${movie.poster}" alt="${movie.title}" />
                <h3>${movie.title}</h3>
                <p>${movie.overview}</p>
            `;
            container.appendChild(card);
        });
    })
    .catch(err => console.error(err));
</script>

</body>
<style>

</style>
</html>