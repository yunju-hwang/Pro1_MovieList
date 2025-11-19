package com.itwillbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.ReviewsVO;
import com.itwillbs.service.ChatGptService;
import com.itwillbs.service.ReviewService;

@Controller
public class ReviewController {
	
	@Inject
	private ChatGptService chatGptService;
	@Inject
	private ReviewService reviewService;
	
	
	// 리뷰 작성하기 (POST)
	@PostMapping("/movies/review_write")
	@ResponseBody
	public Map<String, Object> reviewWrite(
			@RequestParam int tmdbId,
	        @RequestParam String userId,
	        @RequestParam String content,
	        @RequestParam int rating) {
		Map<String, Object> result = new HashMap<>();
		
		try {
			ReviewsVO review = new ReviewsVO();
			review.setTmdbId(tmdbId);
			review.setUserId(userId);
			review.setContent(content);
			review.setRating(rating);
			
			System.out.println(review);
			
			reviewService.insertReview(review);
			
			result.put("success", true);
			result.put("message", "리뷰가 등록되었습니다.");
			
		}catch(Exception e) {
			result.put("success", false);
			result.put("message", "리뷰 등록에 실패했습니다");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 영화 리뷰 목록 불러오기
	@GetMapping("/movies/review_list")
	@ResponseBody
	public List<ReviewsVO> getReviewList(@RequestParam int tmdbId) {
		System.out.println(tmdbId);
		return reviewService.getReviewListByTmdbId(tmdbId);
	}
		
		
	
	
	
	// AI 리뷰 페이지
	@GetMapping("/movies/ai_review")
	public String aiReviews() {
		return "/movies/ai_review";
	}
		





}
