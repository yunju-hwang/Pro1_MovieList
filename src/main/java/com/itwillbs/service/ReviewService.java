package com.itwillbs.service;

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
	public List<ReviewsVO> getReviewListByTmdbId(int tmdbId){
		System.out.println(reviewMapper.selectReviewListByTmdbId(tmdbId));
		return reviewMapper.selectReviewListByTmdbId(tmdbId);
	}
	
	// userId 일치하는 모든 리뷰 테이블 가져오기
	public List<ReviewsVO> getReviewsByUser(String userId) {
        return reviewMapper.selectByUserId(userId); // Mapper에서 userId 조건으로 SELECT
    }
	
	
	
	
	
}
