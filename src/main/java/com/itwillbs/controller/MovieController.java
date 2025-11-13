package com.itwillbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.MovieVO;
import com.itwillbs.domain.TheatersVO;
import com.itwillbs.service.MovieService;

@Controller
public class MovieController {

	@Inject
	private MovieService movieService;

	
	// 장르 저장하기 (처음 1번만 실행하는 용도)
	@GetMapping("/movies/loadGenres")
	public void loadGenres() throws Exception {
		movieService.loadGenres();
		return;
	}
	
	// 영화 목록 불러오기 -> list.jsp에서 fetch로 가져갈 데이터 
	@GetMapping("/movies/save")
	@ResponseBody
	public String saveMovies() throws Exception {
		movieService.getPopularMovies();
		return "저장완료";
	}
	
	// db에 저장된 movie 데이터 출력 (목록 페이지)
	// json으로 제공 (javaScript 파일)
    @GetMapping("/movies/list")
    @ResponseBody
    public List<MovieVO> movieList(@RequestParam(value = "sort", defaultValue = "latest") String sort, HttpSession session) {
    	String userId = null;
    	if (session.getAttribute("loginUser") != null) {
            MemberVO user = (MemberVO) session.getAttribute("loginUser");
            userId = user.getUser_id();
        }
    	
    	
    	// 정렬 + userId 기준으로 영화 조회
    	List<MovieVO> movies;
    	System.out.println(sort);
    	
        switch (sort) {
        	//인기순 
            case "popularity":
                movies = movieService.getMovieListOrderByPopularity(userId);
                break;
            //최신순
            case "latest":
            default:
                movies = movieService.getMovieListOrderByReleaseDate(userId);
                break;
        }

        return movies;
    }
    
    
    // 영화 상세 페이지 이동 (jsp)
    @GetMapping("/movies/detailPage")
    public String movieDetailPage() {
    	System.out.println("message");
        return "movies/detail";  // detail.jsp
    }

	// 영화 상세 페이지 값 반환 (json) -> DB 이용
	@GetMapping("/movies/detail")
	@ResponseBody
	public ResponseEntity<MovieVO> getmovieDetail(@RequestParam("tmdbId") int tmdbId, HttpSession session) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("loginUser");
		String userId = (memberVO != null) ? memberVO.getUser_id():null;
		
		MovieVO movieVO = movieService.getMovieById(tmdbId);
		
		// login한 상태면 좋아요 여부 검사
		if (userId != null) {
			boolean isFavorite = movieService.checkFavorite(userId, tmdbId);
			movieVO.setFavorite(isFavorite);
		}else {
			movieVO.setFavorite(false);
		}
		
		return ResponseEntity.ok(movieVO);
	}
	
	// 영화 검색하기
	@GetMapping(value="/movies/search", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String searchMovies(@RequestParam String query) {
		return movieService.searchMovies(query);
	}
	
	// 영화 상세 페이지 -> tmdb api 이용 +  [검색 페이지]
	@GetMapping("/movies/search/detail/{id}")
	public String searchMovieDetail(@PathVariable("id") int tmdbId, Model model) {
		Map<String, Object> movie = movieService.getSearchMovieDetail(tmdbId);
		
		// 안전하게 문자열 처리
	    String title = (String) movie.get("title");
	    String overview = (String) movie.get("overview");
	    String releaseDate = movie.get("release_date") != null ? (String) movie.get("release_date") : "정보 없음";
	    String posterPath = movie.get("poster_path") != null ? (String) movie.get("poster_path") : "/resources/images/default_poster.png";
	    Double popularityValue = movie.get("popularity") != null ? (Double) movie.get("popularity") : null;
	    int popularity = (popularityValue != null) ? (int) Math.round(popularityValue) : 0;
	    
	    // runtime 처리
	    Object runtimeObj = movie.get("runtime");
	    String runtimeText = (runtimeObj != null) ? runtimeObj.toString() + "분" : "정보 없음";

	    // 장르 처리
	    List<Map<String, Object>> genresList = (List<Map<String, Object>>) movie.get("genres");
	    String genresText = "정보 없음";
	    if (genresList != null && !genresList.isEmpty()) {
	        genresText = genresList.stream()
	                .map(g -> (String) g.get("name"))
	                .collect(Collectors.joining(", "));
	    }

	    model.addAttribute("title", title);
	    model.addAttribute("overview", overview);
	    model.addAttribute("releaseDate", releaseDate);
	    model.addAttribute("posterPath", posterPath);
	    model.addAttribute("runtimeText", runtimeText);
	    model.addAttribute("genresText", genresText);
	    model.addAttribute("popularity", popularity);
	    
		return "movies/searchDetail";
		
	}
	
	// 영화 찜하기
    @PostMapping("/movies/favorite/{tmdbId}")
    @ResponseBody
    public Map<String, Object> toggleFavorite(@PathVariable("tmdbId") int tmdbId, HttpSession session) {
    	Map<String, Object> result = new HashMap<>();
    	
    	MemberVO user = (MemberVO) session.getAttribute("loginUser");
    	
    	if(user == null) {
    		result.put("success", false);
    		return result;
    	}
    	
    	String userId = user.getUser_id();
    	
    	boolean isFavorite = movieService.toggleFavorite(userId, tmdbId);
    	
    	// popularity 업데이트
        if (isFavorite) {
            movieService.updatePopularity(tmdbId, 1.0); // 찜 추가 -> +1
        } else {
            movieService.updatePopularity(tmdbId, -1.0); // 찜 해제 -> -1
        }
    	
        // 최신 영화 정보 가져오기 (popularity 포함)
        MovieVO movie = movieService.getMovieById(tmdbId);
        double popularity = movieService.getMovieById(tmdbId).getPopularity();
        
    	// front로 보내기
    	result.put("success", true);
    	result.put("isFavorite", isFavorite);
    	result.put("popularity", movie.getPopularity()); 
    	return result;
    }
    

    
	// 영화 예약하기 창 이동
	@GetMapping("/reservation/info")
	public String resInfo(@RequestParam("tmdbId")String tmdbId,@RequestParam("title")String title, Model model, HttpSession session) {
		List<TheatersVO> theaters = movieService.getAllTheaters();
		System.out.println(theaters);
		
		// 지역 중복 제거
		List<String> locationsList = theaters.stream()
				.map(TheatersVO::getLocation)
				.distinct()
				.collect(Collectors.toList());
		System.out.println(theaters);
		
		
		
		model.addAttribute("theaters", theaters);
		model.addAttribute("locationsList", locationsList);
		model.addAttribute("tmdbId", tmdbId);
		model.addAttribute("title", title);
		
		return "/reservation/info";
	}
	
	

	
	// 영화 예약하기 (좌석 선택)
	@GetMapping("/reservation/seat")
	public String resSeat(Model model) {
		
		return "/reservation/seat";
	}
	
	// 영화 예약하기 (결제)
	@GetMapping("/reservation/payment")
	public String resPayment() {
		return "/reservation/payment";
	}
	
	// 영화 예약 완료창
	@GetMapping("/reservation/complete")
	public String resComplete() {
		return "/reservation/complete";
	}
	
	
	// AI 리뷰 페이지
	@GetMapping("/movies/ai_review")
	public String aiReviews() {
		return "/movies/ai_review";
	}

	// 영화 리뷰 목록 불러오기
	@GetMapping("/movies/review_list")
	public String reviewList() {
		return "/movies/review_list";
	}
	
	

	// 리뷰 작성하기
	@GetMapping("/movies/review_write")
	public String reviewWrite() {
		return "/movies/review_write";
	}
	
	
	

}
