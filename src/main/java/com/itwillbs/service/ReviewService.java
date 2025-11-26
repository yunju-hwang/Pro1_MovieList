package com.itwillbs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.ReviewsVO;
import com.itwillbs.mapper.ReviewMapper;

@Service
public class ReviewService {
	@Inject 
	private ReviewMapper reviewMapper;
	
	// 리뷰 등록하기
	public void insertReview(ReviewsVO review) {
		reviewMapper.insertReview(review);
	}
	
	
	// tmdbId값에 맞는 리뷰 리스트 가져오기
	public List<ReviewsVO> getReviewListByTmdbId(int tmdbId, String userId, int page, int size){
		int offset = (page - 1) * size;
		
		Map<String, Object> params = new HashMap<>();
		params.put("tmdbId", tmdbId);
		params.put("userId", userId); // 추가
		params.put("size", size);
		params.put("offset", offset);
		
		return reviewMapper.selectReviewListByTmdbId(params);
	}
	
	// 리뷰 개수 세기
	public int getReviewCountByTmdbId(int tmdbId) {
	    return reviewMapper.selectReviewCountByTmdbId(tmdbId);
	}
	
	// userId 일치하는 모든 리뷰 테이블 가져오기
	public List<ReviewsVO> getReviewsByUser(String userId) {
        return reviewMapper.selectByUserId(userId); // Mapper에서 userId 조건으로 SELECT
    }
	
	// 리뷰 수정하기
	public int updateReview(ReviewsVO review) {
	    return reviewMapper.updateReview(review); // mapper 호출
	}
	
	// 리뷰 삭제하기
	public boolean deleteReview(int reviewId, String userId) {
        // 본인 리뷰 확인 후 삭제
        ReviewsVO review = reviewMapper.selectReviewById(reviewId);
        return reviewMapper.deleteReview(reviewId) > 0;
    }

	
	
	
	
}
