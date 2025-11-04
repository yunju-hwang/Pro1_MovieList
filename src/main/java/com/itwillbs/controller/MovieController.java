package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.service.MovieService;

@Controller
public class MovieController {

	@Inject
	private MovieService movieService;
	
	// 영화 목록 불러오기
	@GetMapping("/movies")
	public String movieList() {
		return "/movies/list";
	}

	// 영화 상세 페이지
	@GetMapping("/movies/detail")
	public String movieDetail() {
		return "/movies/detail";
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
	

}
