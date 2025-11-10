package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MovieVO;

//interface로 구현
@Mapper
public interface MovieMapper {
	// api로 받아온 movie db에 넣기
	void insertMovie(MovieVO movieVO);
	
	// db list 받아오기
	List<MovieVO> getAllMovies();
	
	// movie_genres 저장
	void insertMovieGenre(@Param("tmdbId") int movieId,
						  @Param("genreId") int genreId);
	List<MovieVO> getMoviesWithGenres();
	
	void insertGenre(GenresVO vo);
}
