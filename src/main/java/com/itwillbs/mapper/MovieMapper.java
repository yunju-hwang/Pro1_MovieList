package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MovieVO;

//interface로 구현
@Mapper
public interface MovieMapper {
	// 기존 영화 전체 삭제 (새로 받아오기 용)
	void deleteAllMovies();
	
	// api로 받아온 movie db에 넣기
	void insertMovie(MovieVO movieVO);
	
	// db list 받아오기
	List<MovieVO> getAllMovies();
	
	// movie_genres 저장
	void insertMovieGenre(@Param("tmdbId") int movieId,
						  @Param("genreId") int genreId);
	
	// 장르 가져오기
	List<MovieVO> getMoviesWithGenres();
	
	// 장르 넣기
	void insertGenre(GenresVO vo);
	
	// 영화 상세 조회
	MovieVO getMovieById(int tmdbId);
	
	// 영화 업데이트
	// popularity, runtime 업데이트
    void updateMovieDetail(MovieVO movie);
    
    // 영화 정렬 (인기순, 최신순)
    List<MovieVO> findAllByOrderByPopularityDesc();
    List<MovieVO> findAllByOrderByReleaseDateDesc();
    
}
