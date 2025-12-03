package com.itwillbs.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MovieVO;
import com.itwillbs.domain.TheatersVO;

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
    List<MovieVO> findAllByOrderByPopularityDesc(@Param("userId") String userId);
    List<MovieVO> findAllByOrderByReleaseDateDesc(@Param("userId") String userId);
    
    // 찜 여부 확인
    int isFavorite(@Param("userId") String userId,
            @Param("tmdbId") int tmdbId);
    
    // 찜 추가
    void addFavorite(@Param("userId") String userId,
            @Param("tmdbId") int tmdbId);
    // 찜 삭제
    void removeFavorite(@Param("userId") String userId,
            @Param("tmdbId") int tmdbId);
    
    // 찜 반영 movies popularity에
    void updateMoviePopularity(MovieVO movie);
    
    // 영화관 값들 가져오기
    List<TheatersVO> getAllTheaters();
    
    // 차지된 좌석 정보 가져오기
 // 특정 영화관/영화/시간에 이미 예약된 좌석 조회
    List<String> findReservedSeats(
        @Param("tmdbId") int tmdbId,
        @Param("theaterId") int theaterId,
        @Param("screeningTime") String screeningTime
    );
    
    // 선호 영화관 가져오기
    List<Long> selectTheaterIdsByUserId(String userId);
    

    // 영화 저장
    void insertMovie(Map<String, Object> movie);
}
