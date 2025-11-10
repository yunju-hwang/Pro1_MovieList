package com.itwillbs.service;


import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MovieVO;
import com.itwillbs.mapper.MovieMapper;

@Service
public class MovieService {
	@Inject
	private MovieMapper movieMapper;
	
	// api key 삽입
	@Value("${tmdb.api.key}")
	private String tmdbApiKey;
	private final String TMDB_BASE_URL = "https://api.themoviedb.org/3/movie";
	

	// -----------장르 저장용 -----------
	public void loadGenres() throws Exception{
		String url = "https://api.themoviedb.org/3/genre/movie/list?api_key="
				+ tmdbApiKey + "&language=ko-KR";
		
		RestTemplate rest = new RestTemplate();
		String json = rest.getForObject(url, String.class);
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> map = mapper.readValue(json, Map.class);
		
		List<Map<String, Object>> genres = (List<Map<String, Object>>)map.get("genres");
		
		for(Map<String, Object>g: genres) {
			GenresVO vo = new GenresVO();
			vo.setGenreId((Integer)g.get("id"));
			vo.setGenreName((String)g.get("name"));
			
			movieMapper.insertGenre(vo);
		}
	}
	
	
	// -------- tmdb api로부터 movie 값들 받아오기 ------------
	public void getPopularMovies() throws Exception {
		String url = "https://api.themoviedb.org/3/movie/popular?api_key=" + tmdbApiKey
				+ "&language=ko-KR";
		RestTemplate rest = new RestTemplate();
		// tmdb가 json을 string으로 줌 -> 그대로 반환
		String json = rest.getForObject(url, String.class);
		
		// ObjectMapper 준비
		 ObjectMapper mapper = new ObjectMapper();
		    
	    // JSON -> Map 변환
		 Map<String, Object> map = mapper.readValue(json, new TypeReference<Map<String, Object>>(){});
		
		 // results 배열 가져오기
		 List<Map<String, Object>> results = (List<Map<String, Object>>)map.get("results");
		
		 
		 for(Map<String, Object> movie: results) {
			 
			 MovieVO movieVO = new MovieVO();
			 
			 movieVO.setTmdbId((Integer)movie.get("id"));
			 movieVO.setTitle((String)movie.get("title"));
			 movieVO.setOverview((String)movie.get("overview"));
			 movieVO.setPosterPath((String)movie.get("poster_path"));
			 
			 // release_date -> LocalDate로 변환
			 String dateStr = (String) movie.get("release_date");
			 if(dateStr != null && !dateStr.isEmpty()) {
				 movieVO.setReleaseDate(LocalDate.parse(dateStr));
			 }
			 
			 // runtime은 popular 리스트에 없음 -> null 유지
			 movieVO.setRuntime(null);
			 
			 // 영화 정보 DB에 저장
			 movieMapper.insertMovie(movieVO);
			 
			 // 장르 연결 저장
			 List<Integer> genreIds = (List<Integer>)movie.get("genre_ids");
			 
			 if(genreIds != null) {
				 for(Integer gId : genreIds) {
					 movieMapper.insertMovieGenre(movieVO.getTmdbId(), gId);
				 }
			 }
			 
		 }	
	}
	
	
	
	// -------- db로부터 movie값 받아오기 ------------
	public List<MovieVO> getMovieList(){
		return movieMapper.getMoviesWithGenres();
	}
	
	
	
	// ----------- db update용 (매일 새벽 2시에 db update ------
	@Transactional
	public void updateMovieList() throws Exception {
		movieMapper.deleteAllMovies();
		// 2. TMDB API에서 인기 영화 받아와서 DB 저장
	    getPopularMovies();
	}
	
	// movie 상세 페이지 가져오기 (tmdb api 이용)
	public MovieVO getMovieById(int tmdbId) {
	
		RestTemplate rest = new RestTemplate();
		
		String url = "https://api.themoviedb.org/3/movie/"+tmdbId+"?api_key="+tmdbApiKey+
				"&language=ko-KR";
		
		// tmdb api에서 JSON 받아오기
		Map<String, Object> result = rest.getForObject(url, Map.class);
		
		
		// db에서 기존 정보 가져오기
		MovieVO movie = movieMapper.getMovieById(tmdbId); 
		
		if(result != null) {
			// popularity
			Double popularity = result.get("popularity") != null ? ((Number) result.get("popularity")).doubleValue() : null;
			movie.setPopularity(popularity);
			
			// runtime
			Integer runtime = result.get("runtime") != null ? ((Number) result.get("runtime")).intValue() : null;
			movie.setRuntime(runtime);
			
			// db 업데이트
			movieMapper.updateMovieDetail(movie);
		}
		
		return movie;
		
		
	}
	
}
