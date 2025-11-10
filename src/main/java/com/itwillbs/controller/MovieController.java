package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.MovieVO;
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
    public List<MovieVO> movieList() {
    	return movieService.getMovieList();
    }
    
    // 영화 찜하기
    @GetMapping("/movies/favorite/{movieId}")
    public void movieFavorite(@PathVariable("movieId") Long movieId) {
    	
    	return;
    }
    // 영화 상세 페이지 이동 (jsp)
    @GetMapping("/movies/detailPage")
    public String movieDetailPage() {
    	System.out.println("message");
        return "movies/detail";  // detail.jsp
    }

	// 영화 상세 페이지 값 반환 (json)
	@GetMapping("/movies/detail")
	@ResponseBody
	public ResponseEntity<MovieVO> getmovieDetail(@RequestParam("tmdbId") int tmdbId) {
		System.out.println("message");
		MovieVO movieVO = movieService.getMovieById(tmdbId);
		return ResponseEntity.ok(movieVO);
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
	
	// 영화 검색하기
	@GetMapping("/movies/search")
	public String movieSearch() {
		return "/movies/search";
	}
	
	// 영화 예약하기
	@GetMapping("/reservation/info")
	public String resInfo() {
		return "/reservation/info";
	}
	
	// 영화 예약하기 (좌석 선택)
	@GetMapping("/reservation/seat")
	public String resSeat() {
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
	

}
