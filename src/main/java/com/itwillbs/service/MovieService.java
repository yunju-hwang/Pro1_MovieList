package com.itwillbs.service;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MovieVO;
import com.itwillbs.domain.TheatersVO;
import com.itwillbs.mapper.MovieMapper;

@Service
public class MovieService {
	@Inject
	private MovieMapper movieMapper;
	
	// api key 삽입 -> tmdb api key
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
	
	
	// -------- tmdb api로부터 popular movie list 값들 받아오기 ------------
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
	
	// movie 검색
	public String searchMovies(String query) {
		String result = "";
		try {
			//tmdb 검색 URL
			String encodedQuery = URLEncoder.encode(query, StandardCharsets.UTF_8);
			String tmdbUrl = "https://api.themoviedb.org/3/search/movie"
					+"?api_key=" +tmdbApiKey 
					+"&language=ko-KR"
					+"&query=" + encodedQuery
					+"&page=1&include_adult=false";
			
			URL url = new URL(tmdbUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			
			// 결과 읽기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(),StandardCharsets.UTF_8));
			StringBuilder sb = new StringBuilder();
			String line;
			while((line=br.readLine())!=null) {
				sb.append(line);
			}
			br.close();
			result = sb.toString();
			System.out.println(result);
			
			
		} catch(Exception e) {
			e.printStackTrace();
			result = "{\"error\":\"검색 중 문제가 발생했습니다.\"}";
		}
		 return result;
	}
	
	// tmdb api로 상세 정보값 가져오기 (검색용)
	public Map<String, Object> getSearchMovieDetail(int tmdbId){
		String url = "https://api.themoviedb.org/3/movie/" + tmdbId
	            + "?api_key=" + tmdbApiKey
	            + "&language=ko-KR";
		RestTemplate rest = new RestTemplate();
		return rest.getForObject(url, Map.class);
	}
	
	// 영화 정렬
	public List<MovieVO> getMovieListOrderByPopularity(String userId) {
		List<MovieVO> movies = movieMapper.findAllByOrderByPopularityDesc(userId);
        addFavoriteStatus(movies, userId);
        return movies;
	}
	
	public List<MovieVO> getMovieListOrderByReleaseDate(String userId) {
		List<MovieVO> movies = movieMapper.findAllByOrderByReleaseDateDesc(userId);
        addFavoriteStatus(movies, userId);
        return movies;
	}
	
	
	// 찜 여부 확인
	public boolean checkFavorite(String userId, int tmdbId) {
		Integer count = movieMapper.isFavorite(userId, tmdbId);
		return count != null && count>0;
	}
	
	
	// 찜 여부 반영 (isFavorite 세팅)
    private void addFavoriteStatus(List<MovieVO> movies, String userId) {
        if (userId != null) {
            for (MovieVO m : movies) {
                int count = movieMapper.isFavorite(userId, m.getTmdbId());
                m.setFavorite(count > 0);
            }
        }
    }
    // Map -> MovieVO 변환
    public MovieVO convertMapToMovieVO(Map<String, Object> movieDetail) {
        MovieVO movieVO = new MovieVO();
        movieVO.setTmdbId((Integer) movieDetail.get("id"));
        movieVO.setTitle((String) movieDetail.getOrDefault("title", "제목 없음"));
        movieVO.setOverview((String) movieDetail.getOrDefault("overview", ""));
        movieVO.setPosterPath((String) movieDetail.getOrDefault("poster_path", null));

        String releaseDateStr = (String) movieDetail.get("release_date");
        if (releaseDateStr != null && !releaseDateStr.isEmpty()) {
            try {
                movieVO.setReleaseDate(LocalDate.parse(releaseDateStr, DateTimeFormatter.ISO_DATE));
            } catch (DateTimeParseException e) {
                movieVO.setReleaseDate(null);
            }
        }

        Object popularityObj = movieDetail.get("popularity");
        movieVO.setPopularity(popularityObj != null ? ((Number) popularityObj).doubleValue() : 0.0);

        Object runtimeObj = movieDetail.get("runtime");
        movieVO.setRuntime(runtimeObj != null ? (Integer) runtimeObj : null);

        // genres ID만 추출
        List<Map<String, Object>> genresList = (List<Map<String, Object>>) movieDetail.get("genres");
        List<Integer> genreIds = new ArrayList<>();
        if (genresList != null) {
            for (Map<String, Object> g : genresList) {
                Object idObj = g.get("id");
                if (idObj instanceof Number) {
                    genreIds.add(((Number) idObj).intValue());
                }
            }
        }
        movieVO.setGenreIds(genreIds);
        movieVO.setFavorite(false);
        return movieVO;
    }




 // DB 저장
    @Transactional
    public void insertMovie(MovieVO movie) {
        // 1. movies 테이블 저장
        movieMapper.insertMovie(movie);

        // genre_ids가 있으면 movie_genres에 바로 넣기
        if (movie.getGenreIds() != null) {
            for (Integer genreId : movie.getGenreIds()) {
                movieMapper.insertMovieGenre(movie.getTmdbId(), genreId);
            }
        }
    }
    
    // ---- 영화 감독, 배우 정보 가져오기
    public Map<String, Object> getMovieCredits(int tmdbId){
    	String url = "https://api.themoviedb.org/3/movie/" + tmdbId + "/credits?api_key="+tmdbApiKey+"&language=ko-KR";
    	
    	RestTemplate rest = new RestTemplate();
    	Map<String, Object> response = rest.getForObject(url, Map.class);
    	
    	return response;
    }
    
    // ---- 추천 영화 리스트 가져오기
    public List<Map<String, Object>> getRecommendations(int tmdbId){
    	String url = "https://api.themoviedb.org/3/movie/" + tmdbId +
                "/recommendations?api_key=" + tmdbApiKey + "&language=ko-KR&page=1";
    	
    	RestTemplate rest = new RestTemplate();
    	Map<String, Object> response = rest.getForObject(url, Map.class);
    	
    	if(response != null && response.containsKey("results")) {
    		return (List<Map<String, Object>>) response.get("results");
    	}
    	
    	return List.of();
    	
    }
    
    
    
	
	// 영화 찜하기 
	public boolean toggleFavorite(String userId, int tmdbId) {
		int count = movieMapper.isFavorite(userId, tmdbId);
		
		if(count > 0) {
	        movieMapper.removeFavorite(userId, tmdbId);
	        return false; // 찜 해제됨
	    } else {
	        movieMapper.addFavorite(userId, tmdbId);
	        return true; // 찜 추가됨
	    }
		
	}
	
	// movies에서 popularity 업데이트
	public void updatePopularity(int tmdbId, double change) {
		MovieVO movie = movieMapper.getMovieById(tmdbId);
	    if (movie == null) {
	        // 로그 남기고 종료 또는 예외 처리
	        System.out.println("해당 tmdbId 영화가 존재하지 않습니다: " + tmdbId);
	        return;
	    }
	    Double currentPopularity = movie.getPopularity() != null ? movie.getPopularity() : 0.0;
	    movie.setPopularity(currentPopularity + change);
	    movieMapper.updateMoviePopularity(movie);
	}
	
	// DB에서 모든 영화관 조회
	public List<TheatersVO> getAllTheaters(){
		return movieMapper.getAllTheaters();
	}
	
	// tmdb id 받아서 영화 상세 정보 가져오기
	public List<Map<String, Object>> getMoviesDetails(List<String> tmdbIds){
		List<Map<String, Object>> movieList = new ArrayList<>();
		RestTemplate restTemplate = new RestTemplate();
		
		for (String tmdbId : tmdbIds) {
	        try {
	            String url = "https://api.themoviedb.org/3/movie/" + tmdbId +
	                         "?api_key=" + tmdbApiKey + "&language=ko";
	            Map<String, Object> movieData = restTemplate.getForObject(url, Map.class);

	            if (movieData == null) continue; // null이면 건너뛰기

	            Map<String, Object> result = new HashMap<>();
	            result.put("tmdbId", tmdbId);
	            result.put("title", movieData.get("title"));
	            result.put("overview", movieData.get("overview"));
	            result.put("poster", movieData.get("poster_path") != null
	                    ? "https://image.tmdb.org/t/p/w200" + movieData.get("poster_path")
	                    : "");
	            movieList.add(result);

	        } catch (Exception e) {
	            System.err.println("TMDB API 호출 실패 tmdbId=" + tmdbId + ", error=" + e.getMessage());
	            // 예외 발생해도 movieList에 영향 X
	        }
	    }

	        return movieList;
		
	}
	
	
	// 선호 영화관 가져오기
	public List<Long> getUserTheatersIds(String userId){
		return movieMapper.selectTheaterIdsByUserId(userId);
	}
	
	
	// 영화 차지된 좌석 정보 가져오기
	 public List<String> getReservedSeats(int tmdbId, int theaterId, String screeningTime) {
	        return movieMapper.findReservedSeats(tmdbId, theaterId, screeningTime);
	    }
}
