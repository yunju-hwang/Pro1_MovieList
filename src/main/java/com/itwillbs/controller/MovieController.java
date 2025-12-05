package com.itwillbs.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.MovieVO;
import com.itwillbs.domain.TheatersVO;
import com.itwillbs.service.ChatGptService;
import com.itwillbs.service.MovieService;

@Controller
public class MovieController {

	@Inject
	private MovieService movieService;
	private ChatGptService chatGptService;

	
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
    public Map<String, Object> movieList(
    		@RequestParam(value = "sort", defaultValue = "latest") String sort,
    		@RequestParam(value="page", defaultValue = "1") int page,
    		@RequestParam(value="size", defaultValue="20") int size,
    		HttpSession session) {
    	
    	String userId = null;
    	if (session.getAttribute("loginUser") != null) {
            MemberVO user = (MemberVO) session.getAttribute("loginUser");
            userId = user.getUser_id();
        }
    	
    	int offset = (page -1) * size;
    	
    	// 정렬 + userId 기준으로 영화 조회
    	List<MovieVO> movies;
    	System.out.println(sort);
    	
        switch (sort) {
        	//인기순 
            case "popularity":
                movies = movieService.getMovieListOrderByPopularity(userId, offset, size);
                break;
            //최신순
            case "latest":
            default:
                movies = movieService.getMovieListOrderByReleaseDate(userId, offset, size);
                break;
        }

        int totalCount = movieService.getTotalMovieCount();
        
        Map<String, Object> response = new HashMap<>();
        response.put("movies", movies);
        response.put("totalCount", totalCount);
        response.put("currentPage", page);
        response.put("pageSize", size);
        
        
        return response;
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
		Map<String, Object> credits = movieService.getMovieCredits(tmdbId); // 여기서 출연진 가져오기
		
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
	    
	    // 출연진 (credits에서 cast, crew 등)
	    model.addAttribute("credits", credits);
	    

	    // 추천 영화
	    List<Map<String, Object>> recommendations = movieService.getRecommendations(tmdbId);
	    model.addAttribute("recommendations", recommendations);
	   

		return "movies/searchDetail";
		
	}
	
	// 영화 감독/배우 정보 들고오기
	@GetMapping("/movies/{tmdbId}/credits")
	@ResponseBody
	public Map<String, Object> getMovieCredits(@PathVariable int tmdbId){
		return movieService.getMovieCredits(tmdbId);
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
    
    // 영화 tmdbId 값 받아와서 프론트에 카드 list 형태로 반환하기
    // 프론트에서 tmdbId 배열 받음 
    @PostMapping("/getmovie/details")
    public ResponseEntity<List<Map<String, Object>>> getMovieCard(@RequestBody List<String> tmdbIds){
    	List<Map<String, Object>> movieList = movieService.getMoviesDetails(tmdbIds);
        return ResponseEntity.ok(movieList);
    }
    
    
    
    
    // tmdbId 받아서 DB에 영화 저장
    @PostMapping("/movies/add/tmdb/{tmdbId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addMovieByTmdbId(@PathVariable int tmdbId) {
        Map<String, Object> result = new HashMap<>();
        try {
            // tmdb API에서 상세 정보 가져오기
            Map<String, Object> movieDetail = movieService.getSearchMovieDetail(tmdbId);
            System.out.println(movieDetail);

            // Map -> MovieVO 변환
            MovieVO movieVO = movieService.convertMapToMovieVO(movieDetail);

            // DB 저장
            movieService.insertMovie(movieVO);

            result.put("success", true);
            result.put("message", movieVO.getTitle() + " 영화가 추가되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "영화 추가 실패");
        }
        return ResponseEntity.ok(result);
    }



    
	// 영화 예약하기 창 이동
	@GetMapping("/reservation/info")
	public String resInfo(@RequestParam("tmdbId")String tmdbId,@RequestParam("title")String title, Model model, HttpSession session) {
		List<TheatersVO> theaters = movieService.getAllTheaters();
		
		
		// 지역 중복 제거
		List<String> locationsList = theaters.stream()
				.map(TheatersVO::getLocation)
				.distinct()
				.collect(Collectors.toList());
		
		
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		List<Long> userTheaterIds = new ArrayList<>();
		if(loginUser != null) {
			userTheaterIds = movieService.getUserTheatersIds(loginUser.getUser_id());
		}
		
		System.out.println(userTheaterIds);
		model.addAttribute("theaters", theaters); // 모든 영화관 
		model.addAttribute("locationsList", locationsList); // 지역
		model.addAttribute("userTheaterIds", userTheaterIds); // 선호 영화관 id
		model.addAttribute("tmdbId", tmdbId);
		model.addAttribute("title", title);
		
		return "/reservation/info";
	}
	
	

	
	// 영화 예약하기 (좌석 선택)
	@GetMapping("/reservation/seat")
	public String resSeat(Model model) {
		
		return "/reservation/seat";
	}
	
	// 영화 차지된 자석 불러오기
	@GetMapping("/reservation/seatReserved")
	@ResponseBody
	public List<String> getReservedSeats(
			@RequestParam("tmdbId") int tmdbId,
	        @RequestParam("theaterId") int theaterId,
	        @RequestParam("screeningTime") String screeningTime
	        ) {
		
		return movieService.getReservedSeats(tmdbId, theaterId, screeningTime);
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
	
	
	

	
	
	
	

}
