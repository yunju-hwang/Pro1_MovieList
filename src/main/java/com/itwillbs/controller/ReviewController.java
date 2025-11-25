package com.itwillbs.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.domain.AiReviewRequestVO;
import com.itwillbs.domain.ReviewsVO;
import com.itwillbs.service.ChatGptService;
import com.itwillbs.service.MovieService;
import com.itwillbs.service.ReviewService;

@Controller
public class ReviewController {
	
	@Inject
	private ChatGptService chatGptService;
	@Inject
	private ReviewService reviewService;
	@Inject
	private MovieService movieService;
	
	
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
	
	// 영화 상세 페이지에서 리뷰 목록 불러오기
	@GetMapping("/movies/review_list")
	@ResponseBody
	public Map<String, Object> getReviewList(@RequestParam int tmdbId,
							@RequestParam(defaultValue = "1") int page,
							@RequestParam(defaultValue = "10") int size
	) {
		System.out.println("tmdbId: " + tmdbId + ", page: " + page + ", size: " + size);
		List<ReviewsVO> reviews = reviewService.getReviewListByTmdbId(tmdbId, page, size);
		int total = reviewService.getReviewCountByTmdbId(tmdbId);
		
		Map<String, Object> result = new HashMap<>();
	    result.put("reviews", reviews);
	    result.put("total", total);
	    result.put("page", page);
        result.put("size", size);

	    return result;

		
	}
		
		
	
	
	
	// AI 리뷰 페이지
	@GetMapping("/movies/ai_review")
	public String aiReviews() {
		return "/movies/ai_review";
	}
	
	// userId에 맞는 모든 리뷰 가져오기
	@GetMapping("/movies/reviews_by_user")
	@ResponseBody
	public List<ReviewsVO> getReviewsByUser(@RequestParam String userId) {
	    return reviewService.getReviewsByUser(userId);
	}
	
	
	// 리뷰 수정
	@PostMapping("/movies/review_update")
	@ResponseBody
	public Map<String, Object> updateReview(
			@RequestParam int reviewId, 
			@RequestParam String content,
			@RequestParam int rating){
		Map<String, Object> result = new HashMap<>();
		

	    try {
	        ReviewsVO review = new ReviewsVO();
	        review.setId(reviewId);
	        review.setContent(content);
	        review.setRating(rating);

	        int updateCount = reviewService.updateReview(review);

	        if(updateCount > 0) {
	            result.put("success", true);
	            result.put("message", "리뷰가 수정되었습니다.");
	        } else {
	            result.put("success", false);
	            result.put("message", "리뷰 수정 실패: 리뷰가 존재하지 않거나 권한이 없습니다.");
	        }

	    } catch(Exception e) {
	        e.printStackTrace();
	        result.put("success", false);
	        result.put("message", "리뷰 수정 중 오류 발생");
	    }

	    return result;
		
	}
	
	
	// 리뷰 삭제
	@PostMapping("/movies/review_delete")
	@ResponseBody
	public Map<String, Object> deleteReview(@RequestParam("reviewId")int reviewId, @RequestParam String userId){
	
		Map<String, Object> result = new HashMap<>();
		
		try {
	        boolean success = reviewService.deleteReview(reviewId, userId);
	        result.put("success", success);

	        if (!success) {
	            result.put("message", "삭제 권한이 없거나 삭제 실패");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("success", false);
	        result.put("message", "서버 오류 발생");
	    }
		
		return result;
	}

	
	// ai 리뷰 요청 및 받아오기
	@PostMapping("/movies/ai_review")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> analyzeReviews(@RequestBody AiReviewRequestVO request) throws JsonMappingException, JsonProcessingException{
		
		//1. DB에서 userId 조건으로 리뷰 조회
		 List<ReviewsVO> userReviews = reviewService.getReviewsByUser(request.getUserId());
		
		// GPT 분석
		// String result = chatGptService.askGPT(userReviews);
		 // 2. 리뷰 + 영화 제목 모아서 프롬프트 생성 
		 StringBuilder promptBuilder = new StringBuilder();
		 promptBuilder.append("사용자가 작성한 리뷰와 영화 제목을 분석하고, ")
				         .append("추천 영화 5개를 반환하세요.\n")
				         .append("출력은 반드시 JSON으로만 반환하고 다른 설명은 추가하지 마세요.\n")
				         .append("JSON 예시:\n")
				         .append("{\n")
				         .append("  \"analysis\": \"사용자 분석 텍스트\",\n")
				         .append("  \"recommendations\": [\n")
				         .append("    { \"title\": \"프레데터\"},\n")
				         .append("    { \"title\": \"어벤져스\"}\n")
				         .append("  ]\n")
				         .append("}\n\n")
				         .append("사용자 리뷰 목록:\n");
		 
		 for(ReviewsVO r: userReviews) {
			 promptBuilder.append("영화: ").append(r.getTitle()).append("\n")
			 			  .append("리뷰: ").append(r.getContent()).append("\n\n");
			 
		 }
		 
		 
		 String prompt = promptBuilder.toString();
		 
		 // 3. GPT 분석
		 String result = chatGptService.askGPT(prompt);
		 System.out.println("search api");
		 
		 // GPT가 준 JSON 파싱
		 ObjectMapper mapper = new ObjectMapper();
		 JsonNode root = mapper.readTree(result);
		 
		 // analysis 텍스트
		 String analysisResult = root.get("analysis").asText();
		 
		 // GPT 추천 영화 목록
		 JsonNode recList = root.get("recommendations");
		 
		 List<Map<String, Object>> finalRecommendations = new ArrayList<>();
		 
		// ⭐⭐⭐ 추천 영화 → TMDB 검색 → 결과 ID 추출
		 for(JsonNode rec: recList) {
			 String title = rec.get("title").asText();
			 System.out.println("추천 영화 검색 시작: " + title);
			 
			 // tmdb 검색 api (제일 첫 결과 사용)
			try {
				 // TMDB 검색 호출 (문자열 JSON 반환)
	            String searchResultJson = movieService.searchMovies(title);
	            JsonNode searchRoot = mapper.readTree(searchResultJson);

	            JsonNode results = searchRoot.get("results");
	            
	            if (results != null && results.size() > 0) {
	                // 첫 번째 결과
	                int tmdbId = results.get(0).get("id").asInt();

	                Map<String, Object> movieData = new HashMap<>();
	                movieData.put("title", title);
	                movieData.put("tmdbId", tmdbId);

	                finalRecommendations.add(movieData);

	                System.out.println("TMDB 매칭 성공: " + title + " → " + tmdbId);
	            } else {
	                // 검색 결과 없을 때
	                Map<String, Object> movieData = new HashMap<>();
	                movieData.put("title", title);
	                movieData.put("tmdbId", null);

	                finalRecommendations.add(movieData);

	                System.out.println("TMDB 결과 없음: " + title);
	            }
	            
			}catch(Exception e) {
				e.printStackTrace();

	            Map<String, Object> movieData = new HashMap<>();
	            movieData.put("title", title);
	            movieData.put("tmdbId", null);

	            finalRecommendations.add(movieData);

	            System.out.println("TMDB 검색 오류: " + title);
			}
			 
		 }
		 
		 
		 // 5. 최종 응답 JSON으로 반환
		 Map<String, Object> response = new HashMap<>();
		 response.put("analysis", analysisResult);
		 response.put("recommendations", finalRecommendations);
		 
		 System.out.println(result);
		 System.out.println(response);
		 
		return ResponseEntity.ok(response);
	}
		





}
